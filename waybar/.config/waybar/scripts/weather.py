#!/usr/bin/env python3
import json
import os
import subprocess
import sys
import time
from datetime import datetime

# Configuration
CONFIG_FILE = os.path.expanduser("~/.config/waybar/weather-config.json")
CACHE_FILE = os.path.expanduser("~/.cache/waybar-weather.json")
DEFAULT_LOCATION = "Denver"

def load_config():
    """Load configuration from file or use defaults."""
    try:
        if os.path.exists(CONFIG_FILE):
            with open(CONFIG_FILE, 'r') as f:
                config = json.load(f)
                return config.get('location', DEFAULT_LOCATION)
    except Exception:
        pass
    return DEFAULT_LOCATION

LOCATION = load_config()

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

            # Use wttr.in JSON API for more reliable parsing
            result = subprocess.run(['curl', '-s', '--connect-timeout', '5',
                                   '--max-time', '10', f'https://wttr.in/{LOCATION}?format=j1'],
                                  capture_output=True, text=True, timeout=15)

            if result.returncode == 0 and result.stdout:
                try:
                    data = json.loads(result.stdout)
                    # Cache successful response
                    save_cache(data)
                    return data
                except json.JSONDecodeError:
                    print(f"Failed to parse JSON response on attempt {attempt + 1}", file=sys.stderr)

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

def get_weather_icon(weather_code, is_day=True):
    """Convert weather code to appropriate icon."""
    # Weather codes from https://www.worldweatheronline.com/developer/api/docs/weather-icons.aspx
    weather_icons = {
        # Clear/Sunny
        113: "󰖙" if is_day else "󰖔",  # Clear/Sunny

        # Partly cloudy
        116: "󰖕" if is_day else "󰼱",  # Partly cloudy

        # Cloudy
        119: "󰖐",  # Cloudy
        122: "󰖐",  # Overcast

        # Fog
        143: "󰖑",  # Mist
        248: "󰖑",  # Fog
        260: "󰖑",  # Freezing fog

        # Light rain/drizzle
        176: "󰖗",  # Patchy rain possible
        179: "󰖘",  # Patchy snow possible
        182: "󰖘",  # Patchy sleet possible
        185: "󰖘",  # Patchy freezing drizzle possible
        263: "󰖗",  # Patchy light drizzle
        266: "󰖗",  # Light drizzle
        281: "󰖗",  # Freezing drizzle
        284: "󰖗",  # Heavy freezing drizzle
        293: "󰖗",  # Patchy light rain
        296: "󰖗",  # Light rain
        299: "󰖗",  # Moderate rain at times
        302: "󰖗",  # Moderate rain
        305: "󰖗",  # Heavy rain at times
        308: "󰖗",  # Heavy rain
        311: "󰖗",  # Light freezing rain
        314: "󰖗",  # Moderate or heavy freezing rain

        # Thunderstorm
        200: "󰖓",  # Thundery outbreaks possible
        386: "󰖓",  # Patchy light rain with thunder
        389: "󰖓",  # Moderate or heavy rain with thunder
        392: "󰖓",  # Patchy light snow with thunder
        395: "󰖓",  # Moderate or heavy snow with thunder

        # Snow
        179: "󰼶",  # Patchy snow possible
        182: "󰼶",  # Patchy sleet possible
        185: "󰼶",  # Patchy freezing drizzle possible
        227: "󰼶",  # Blowing snow
        230: "󰼶",  # Blizzard
        317: "󰼶",  # Light sleet
        320: "󰼶",  # Moderate or heavy sleet
        323: "󰼶",  # Patchy light snow
        326: "󰼶",  # Light snow
        329: "󰼶",  # Patchy moderate snow
        332: "󰼶",  # Moderate snow
        335: "󰼶",  # Patchy heavy snow
        338: "󰼶",  # Heavy snow
        350: "󰼶",  # Ice pellets
        353: "󰖗",  # Light rain shower
        356: "󰖗",  # Moderate or heavy rain shower
        359: "󰖗",  # Torrential rain shower
        362: "󰼶",  # Light sleet showers
        365: "󰼶",  # Moderate or heavy sleet showers
        368: "󰼶",  # Light snow showers
        371: "󰼶",  # Moderate or heavy snow showers
        374: "󰼶",  # Light showers of ice pellets
        377: "󰼶",  # Moderate or heavy showers of ice pellets
    }

    code = int(weather_code)
    return weather_icons.get(code, "󰖙")  # Default to sun icon if code not found

def format_temperature(temp_f, temp_c):
    """Format temperature for display."""
    return f"{temp_f}°F ({temp_c}°C)"

def get_wind_direction_arrow(degrees):
    """Convert wind direction degrees to arrow."""
    arrows = ["↓", "↙", "←", "↖", "↑", "↗", "→", "↘"]
    index = int((degrees + 22.5) / 45) % 8
    return arrows[index]

def main():
    weather_data = get_weather()

    # If fetch failed, try to use cache
    if not weather_data:
        weather_data, cache_age = load_cache(max_age=7200)  # Accept cache up to 2 hours old
        if weather_data:
            cache_mins = int(cache_age / 60)
            print(f"Using cached weather data ({cache_mins} minutes old)", file=sys.stderr)
        else:
            # Show loading indicator on first startup
            print(json.dumps({
                "text": "⏳ Loading",
                "tooltip": "Fetching weather data...",
                "class": "weather-loading"
            }))
            return

    try:
        current = weather_data['current_condition'][0]
        location = weather_data['nearest_area'][0]

        # Extract current weather data
        temp_f = int(current['temp_F'])
        temp_c = int(current['temp_C'])
        feels_like_f = int(current['FeelsLikeF'])
        feels_like_c = int(current['FeelsLikeC'])
        condition = current['weatherDesc'][0]['value']
        humidity = int(current['humidity'])
        wind_speed = int(current['windspeedMiles'])
        wind_dir = current['winddir16Point']
        wind_degrees = int(current['winddirDegree'])
        visibility = int(current['visibilityMiles'])
        pressure = int(current['pressureInches'])
        weather_code = int(current['weatherCode'])

        # Get appropriate icon
        # Determine if it's day (simple check based on time)
        current_hour = datetime.now().hour
        is_day = 6 <= current_hour < 20
        icon = get_weather_icon(weather_code, is_day)

        # Get wind direction arrow
        wind_arrow = get_wind_direction_arrow(wind_degrees)

        # Build display text
        display_text = f"{icon} {temp_f}°F"

        # Build tooltip
        location_name = location['areaName'][0]['value']
        tooltip = f"📍 {location_name}\n"
        tooltip += f"───────────────\n"
        tooltip += f"󰔏 {condition}\n"
        tooltip += f"🌡️ {temp_f}°F ({temp_c}°C)\n"
        tooltip += f"🤔 Feels like {feels_like_f}°F ({feels_like_c}°C)\n"
        tooltip += f"💧 Humidity: {humidity}%\n"
        tooltip += f"💨 Wind: {wind_arrow} {wind_speed} mph {wind_dir}\n"
        tooltip += f"👁️ Visibility: {visibility} mi\n"
        tooltip += f"🔽 Pressure: {pressure} in\n"

        # Add forecast
        if 'weather' in weather_data:
            tooltip += f"\n📅 3-Day Forecast\n"
            tooltip += f"───────────────\n"

            for day_data in weather_data['weather'][:3]:
                date = datetime.strptime(day_data['date'], '%Y-%m-%d')
                day_name = date.strftime('%a %b %d')
                max_temp_f = int(day_data['maxtempF'])
                max_temp_c = int(day_data['maxtempC'])
                min_temp_f = int(day_data['mintempF'])
                min_temp_c = int(day_data['mintempC'])

                # Get average conditions for the day
                hourly_data = day_data['hourly']
                conditions = set()
                total_precip = 0

                for hour in hourly_data:
                    conditions.add(hour['weatherDesc'][0]['value'])
                    total_precip += float(hour['precipInches'])

                # Get most common condition
                condition_str = ', '.join(list(conditions)[:2])  # Show up to 2 conditions

                tooltip += f"\n{day_name}:\n"
                tooltip += f"  📊 {min_temp_f}-{max_temp_f}°F ({min_temp_c}-{max_temp_c}°C)\n"
                tooltip += f"  🌤️ {condition_str}\n"
                if total_precip > 0:
                    tooltip += f"  💧 Precip: {total_precip:.1f} in\n"

        # Add last update time
        update_time = datetime.now().strftime('%H:%M')
        tooltip += f"\n🔄 Updated: {update_time}"

        result = {
            "text": display_text,
            "tooltip": tooltip,
            "class": "weather",
            "alt": condition
        }

        print(json.dumps(result))

    except Exception as e:
        print(f"Error processing weather data: {e}", file=sys.stderr)
        print(json.dumps({
            "text": "⚠️ Error",
            "tooltip": f"Error processing weather data:\n{str(e)}",
            "class": "weather-error"
        }))

if __name__ == "__main__":
    main()