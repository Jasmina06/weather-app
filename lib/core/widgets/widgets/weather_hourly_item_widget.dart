import 'package:flutter/material.dart';

class WeatherHourlyItem extends StatelessWidget {
  final String time;
  final IconData icon;
  final String temp;

  const WeatherHourlyItem({
    Key? key,
    required this.time,
    required this.icon,
    required this.temp,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final Color secondaryTextColor = isDarkMode ? Colors.white54 : Colors.black54;

    return Column(
      children: [
        Text(
          time,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: secondaryTextColor,
              ),
        ),
        const SizedBox(height: 8),
        Icon(icon, color: Colors.blue[400]),
        const SizedBox(height: 8),
        Text(
          temp,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: secondaryTextColor,
              ),
        ),
      ],
    );
  }
}
