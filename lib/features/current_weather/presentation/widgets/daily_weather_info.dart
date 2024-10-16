import 'package:flutter/material.dart';
import 'package:weather_app/features/forecast_weather/data/model/forecast_weather_model.dart';

class CurrentWeatherWidget extends StatelessWidget {
  final ForecastWeatherModel forecast;

  const CurrentWeatherWidget({super.key, required this.forecast});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.blue.shade100,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Tomorrow',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  children: [
                    Image.asset(
                      'assets/images/cloud.png',
                      height: 100,
                      width: 100,
                    ),
                    Text(
                      forecast.weather[0].description, 
                      style: const TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              ),
              Text(
                '${forecast.main.temp}° / ${forecast.main.feelsLike}°',
                style: const TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildWeatherDetail(
                  Icons.water_drop, '${forecast.rain ?? 0} mm', 'Precipitation'), 
              _buildWeatherDetail(
                  Icons.opacity, '${forecast.main.feelsLike}%', 'Feels Like'), 
              _buildWeatherDetail(
                  Icons.air, '${forecast.wind.speed} km/h', 'Wind speed'), 
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildWeatherDetail(IconData icon, String value, String label) {
    return Column(
      children: [
        Icon(icon, color: Colors.blue),
        const SizedBox(height: 5),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        Text(
          label,
          style: const TextStyle(fontSize: 12, color: Colors.grey),
        ),
      ],
    );
  }
}
