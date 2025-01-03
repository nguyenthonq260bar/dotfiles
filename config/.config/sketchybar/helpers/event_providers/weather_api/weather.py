#!/usr/bin/env python3

import requests

API_KEY = "3fc21152eafd5eef4fbab5f0369b99d4"  
CITY = "Ho chi minh"
URL = f"https://api.openweathermap.org/data/2.5/weather?q={CITY}&units=metric&appid={API_KEY}"

def get_weather():
    try:
        response = requests.get(URL)
        data = response.json()
        if response.status_code == 200:
            # Lấy thông tin thời tiết
            temp = data['main']['temp']
            weather = data['weather'][0]['description']
            return f"{temp}°C, {weather.capitalize()}"
        else:
            return "Lỗi API"
    except Exception as e:
        return "Không thể lấy thời tiết"

if __name__ == "__main__":
    print(get_weather())
