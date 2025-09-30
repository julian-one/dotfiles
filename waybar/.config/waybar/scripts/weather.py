#!/usr/bin/env python3
import json
import os
import re
import subprocess
import sys
import time

CACHE_FILE = os.path.expanduser("~/.cache/waybar-weather.json")

def check_network():
    """Check if network is available by pinging a reliable DNS server."""
    try:
        result = subprocess.run(['ping', '-c', '1', '-W', '1', '8.8.8.8'],
                              capture_output=True, timeout=2)
        return result.returncode == 0
    except:
        return False

def get_weather(retry_count=3, initial_delay=1):
    """Fetch weather with retry logic and exponential backoff."""
    for attempt in range(retry_count):
        try:
            # Check network connectivity first
            if not check_network():
                if attempt == 0:
                    print("Network not ready, waiting...", file=sys.stderr)
                time.sleep(initial_delay * (2 ** attempt))
                continue

            result = subprocess.run(['curl', '-s', '--connect-timeout', '5',
                                   '--max-time', '10', 'https://wttr.in/Denver'],
                                  capture_output=True, text=True, timeout=15)

            if result.returncode == 0 and result.stdout:
                # Cache successful response
                save_cache(result.stdout)
                return result.stdout

            if attempt < retry_count - 1:
                delay = initial_delay * (2 ** attempt)
                print(f"Attempt {attempt + 1} failed, retrying in {delay}s...", file=sys.stderr)
                time.sleep(delay)
        except Exception as e:
            if attempt < retry_count - 1:
                delay = initial_delay * (2 ** attempt)
                print(f"Exception on attempt {attempt + 1}: {e}, retrying in {delay}s...", file=sys.stderr)
                time.sleep(delay)
            else:
                print(f"Final exception in get_weather: {e}", file=sys.stderr)

    return None

def save_cache(data):
    """Save weather data to cache file."""
    try:
        os.makedirs(os.path.dirname(CACHE_FILE), exist_ok=True)
        with open(CACHE_FILE, 'w') as f:
            json.dump({'data': data, 'timestamp': time.time()}, f)
    except Exception as e:
        print(f"Failed to save cache: {e}", file=sys.stderr)

def load_cache(max_age=3600):
    """Load cached weather data if it exists and is recent enough."""
    try:
        if os.path.exists(CACHE_FILE):
            with open(CACHE_FILE, 'r') as f:
                cache = json.load(f)
                age = time.time() - cache['timestamp']
                if age < max_age:
                    return cache['data'], age
    except Exception as e:
        print(f"Failed to load cache: {e}", file=sys.stderr)
    return None, None

def clean_ansi(text):
    ansi_escape = re.compile(r'\x1B(?:[@-Z\\-_]|\[[0-?]*[ -/]*[@-~])')
    return ansi_escape.sub('', text)

def fahrenheit_to_celsius(f_str):
    """Convert temperature string like '60 °F' to both F and C"""
    f_match = re.search(r'(\d+)', f_str)
    if f_match:
        f = int(f_match.group(1))
        c = round((f - 32) * 5/9)
        return f"{f}°F ({c}°C)"
    return f_str

def extract_current_weather(weather_data):
    lines = weather_data.split('\n')

    # Find current temperature - look for pattern like "+50(48) °F" or "50 °F"
    temp_match = re.search(r'\+?(\d+)(?:\(\d+\))?\s*°F', weather_data)
    if temp_match:
        temp_f = f"{temp_match.group(1)} °F"
    else:
        temp_f = "-- °F"
    temp = fahrenheit_to_celsius(temp_f)

    # Find current condition
    condition_match = re.search(r'(Clear|Sunny|Partly cloudy|Cloudy|Overcast|Rain|Snow)', weather_data)
    condition = condition_match.group(1) if condition_match else "Unknown"

    # Find wind
    wind_match = re.search(r'[←→↑↓↗↘↙↖] [\d-]+ mph', weather_data)
    wind = wind_match.group(0) if wind_match else None

    # Find visibility
    visibility_match = re.search(r'(\d+ mi)', weather_data)
    visibility = visibility_match.group(1) if visibility_match else None

    # Find precipitation
    precip_match = re.search(r'([\d.]+ in)', weather_data)
    precipitation = precip_match.group(1) if precip_match else None

    # Determine icon (using working Nerd Font icons from your config)
    icon = "󰖙"  # default weather icon (from your config style)
    if "Clear" in condition or "Sunny" in condition:
        icon = "󰖙"  # sunny (bright sun)
    elif "Partly" in condition:
        icon = "󰖕"  # partly cloudy
    elif "Cloudy" in condition or "Overcast" in condition:
        icon = "󰖐"  # cloudy
    elif "Rain" in condition:
        icon = "󰖗"  # rain
    elif "Snow" in condition:
        icon = "󰼶"  # snow

    return {
        'temp': temp,
        'temp_f': temp_f,  # Keep F-only for display text
        'condition': condition,
        'wind': wind,
        'visibility': visibility,
        'precipitation': precipitation,
        'icon': icon
    }

def extract_forecast(weather_data):
    forecast = []

    # Find all day headers like "Wed 24 Sep"
    day_pattern = r'([A-Z][a-z]+ \d+ [A-Z][a-z]+)'
    days = re.findall(day_pattern, weather_data)[:3]  # Only first 3 days

    for day in days:
        # Find the section for this day
        day_start = weather_data.find(day)
        if day_start == -1:
            continue

        # Get roughly 300 characters after the day header to capture the forecast table
        day_section = weather_data[day_start:day_start + 500]

        # Extract temperatures - look for patterns like "57 °F", "+59(57) °F", etc.
        temp_matches = re.findall(r'(?:\+?(\d+)(?:\(\d+\))? °F)', day_section)
        temps = [fahrenheit_to_celsius(f"{t} °F") for t in temp_matches[:4]]  # Morning, Noon, Evening, Night

        # Extract conditions
        condition_matches = re.findall(r'(Clear|Sunny|Partly Cloudy|Cloudy|Overcast|Rain|Snow)', day_section)
        conditions = '/'.join(list(dict.fromkeys(condition_matches)))  # Remove duplicates, preserve order

        # Extract precipitation percentage
        precip_matches = re.findall(r'(\d+%)', day_section)
        precip_chance = precip_matches[-1] if precip_matches else "0%"

        forecast.append({
            'day': day,
            'temps': temps,
            'conditions': conditions,
            'precipitation': precip_chance
        })

    return forecast

def main():
    weather_raw = get_weather()

    # If fetch failed, try to use cache
    if not weather_raw:
        weather_raw, cache_age = load_cache(max_age=7200)  # Accept cache up to 2 hours old
        if weather_raw:
            cache_mins = int(cache_age / 60)
            print(f"Using cached weather data ({cache_mins} minutes old)", file=sys.stderr)
        else:
            # Show loading indicator on first startup
            print(json.dumps({"text": "⏳ Loading", "tooltip": "Fetching weather data..."}))
            return

    weather_clean = clean_ansi(weather_raw)
    current = extract_current_weather(weather_clean)
    forecast = extract_forecast(weather_clean)

    # Build tooltip (using working Nerd Font icons)
    tooltip = f"󰔏 {current['condition']} • {current['temp']}"
    if current['wind']:
        tooltip += f"\n󰖝 Wind: {current['wind']}"
    if current['visibility']:
        tooltip += f"\n󰍉 Visibility: {current['visibility']}"
    if current['precipitation']:
        tooltip += f"\n󰖗 Precipitation: {current['precipitation']}"

    # Add forecast
    for day_data in forecast:
        tooltip += f"\n\n󰃭 {day_data['day']}"
        if len(day_data['temps']) >= 4:
            # Find min and max temps for the day
            temp_nums = []
            for temp_str in day_data['temps']:
                match = re.search(r'(\d+)°F', temp_str)
                if match:
                    temp_nums.append(int(match.group(1)))

            if temp_nums:
                min_f = min(temp_nums)
                max_f = max(temp_nums)
                min_c = round((min_f - 32) * 5/9)
                max_c = round((max_f - 32) * 5/9)
                tooltip += f"\n     󰔏 {min_f}°F - {max_f}°F ({min_c}°C - {max_c}°C)"
                tooltip += f"\n     󰃰 Morning: {day_data['temps'][0]} | Noon: {day_data['temps'][1]} | Evening: {day_data['temps'][2]} | Night: {day_data['temps'][3]}"
            else:
                tooltip += f"\n     󰔏 {', '.join(day_data['temps'])}"
        elif day_data['temps']:
            tooltip += f"\n     󰔏 {', '.join(day_data['temps'])}"

        if day_data['conditions']:
            tooltip += f"\n     󰖙 {day_data['conditions']}"
        if day_data['precipitation']:
            tooltip += f"\n     󰖗 Precipitation: {day_data['precipitation']}"

    result = {
        "text": f"{current['icon']} {current['temp_f']}",
        "tooltip": tooltip
    }

    print(json.dumps(result))

if __name__ == "__main__":
    main()