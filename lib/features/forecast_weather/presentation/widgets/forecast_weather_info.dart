import 'package:flutter/material.dart';
import 'package:weather_app/features/forecast_weather/data/model/forecast_weather_model.dart'; // Модель данных прогноза

class DailyForecastWidget extends StatelessWidget {
  final ForecastWeatherModel forecast; 
  final String dayLabel;

  const DailyForecastWidget({
    super.key,
    required this.forecast,
    required this.dayLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  _getWeatherIcon(forecast.weather[0].main), 
                  size: 30,
                  color: Colors.blue,
                ),
                const SizedBox(width: 10),
                Text(
                  dayLabel,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  forecast.weather[0].description, 
                  style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
                ),
                const SizedBox(height: 4),
                Text(
                  '${forecast.main.temp}° / ${forecast.main.feelsLike}°', 
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  IconData _getWeatherIcon(String weatherMain) {
    switch (weatherMain) {
      case 'Clear':
        return Icons.wb_sunny;
      case 'Clouds':
        return Icons.cloud;
      case 'Rain':
        return Icons.beach_access;
      case 'Thunderstorm':
        return Icons.thunderstorm;
      case 'Snow':
        return Icons.ac_unit;
      default:
        return Icons.wb_cloudy;
    }
  }
}
