import 'package:flutter/material.dart';
import 'package:weather_app/features/current_weather/data/models/current_weather_model.dart';
import 'package:weather_app/core/widgets/widgets/wearher_detail_item_widget.dart';
import 'package:weather_app/core/widgets/widgets/weather_hourly_item_widget.dart';

class WeatherInfo extends StatelessWidget {
  final CurrentWeatherModel weather;

  const WeatherInfo({Key? key, required this.weather}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final Color textColor = isDarkMode ? Colors.white70 : Colors.black87;
    final Color secondaryTextColor = isDarkMode ? Colors.white54 : Colors.black54;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            weather.name,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: textColor,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            weather.weather[0].description,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontSize: 18,
                  color: secondaryTextColor,
                ),
          ),
          const SizedBox(height: 24),
          Image.asset(
            'assets/images/cloud.png',
            height: 120,
            width: 120,
          ),
          Text(
            '${weather.main.temp.toStringAsFixed(1)}°C',
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  fontSize: 64,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              WeatherDetailItem(
                icon: Icons.water_drop,
                label: 'Humidity',
                value: '${weather.main.humidity}%',
              ),
              WeatherDetailItem(
                icon: Icons.thermostat,
                label: 'Feels Like',
                value: '${weather.main.feelsLike.toStringAsFixed(1)}°C',
              ),
            ],
          ),
          const SizedBox(height: 24),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              WeatherHourlyItem(time: '11AM', icon: Icons.cloud, temp: '29°'),
              WeatherHourlyItem(time: '12PM', icon: Icons.wb_sunny, temp: '30°'),
              WeatherHourlyItem(time: '1PM', icon: Icons.cloud, temp: '31°'),
              WeatherHourlyItem(time: '2PM', icon: Icons.wb_sunny, temp: '31°'),
              WeatherHourlyItem(time: '3PM', icon: Icons.wb_sunny, temp: '41°'),
            ],
          ),
        ],
      ),
    );
  }
}
