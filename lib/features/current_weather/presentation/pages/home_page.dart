import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/core/theme/app_colors.dart';
import 'package:weather_app/features/current_weather/presentation/bloc/daily_weather_bloc/daily_weather_cubit.dart';
import 'package:weather_app/features/current_weather/presentation/bloc/daily_weather_bloc/daily_weather_state.dart';
import 'package:weather_app/features/forecast_weather/presentation/pages/forecast_screen.dart';
import 'package:weather_app/features/current_weather/presentation/widgets/app_drawer_widget.dart';
import 'package:weather_app/features/current_weather/presentation/widgets/weather_info_widget.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    context.read<DailyWeatherCubit>().fetchCurrentWeather('London');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: TextStyle(color: AppColors.darkAppBarBackground),
        ),
        elevation: 0,
        backgroundColor: AppColors.lightDrawerBackground,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            color: AppColors.lightIconColor,
            onPressed: () {},
          ),
        ],
      ),
      drawer: const AppDrawer(),
      body: BlocBuilder<DailyWeatherCubit, DailyWeatherState>(
        builder: (context, state) {
          return state.when(
            initial: () => const Center(child: Text('No weather data available.')),
            loading: () => const Center(child: CircularProgressIndicator()),
            loaded: (weather) => WeatherInfo(weather: weather),
            error: (message) => Center(child: Text('Error: $message')),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue[400],
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ForecastScreen()),
          );
        },
        tooltip: '3-Day Forecast',
        child: const Icon(Icons.arrow_forward, color: Colors.white),
      ),
    );
  }
}
