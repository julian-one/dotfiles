#!/usr/bin/env python3
import json
import re
import subprocess
import sys

def get_weather():
    try:
        result = subprocess.run(['curl', '-s', 'https://wttr.in/Denver'],
                              capture_output=True, text=True, timeout=10)
        if result.returncode != 0:
            print(f"curl failed with code {result.returncode}: {result.stderr}", file=sys.stderr)
            return None
        return result.stdout
    except Exception as e:
        print(f"Exception in get_weather: {e}", file=sys.stderr)
        return None

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
    if not weather_raw:
        print(json.dumps({"text": "🌍 Error", "tooltip": "Failed to fetch weather"}))
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