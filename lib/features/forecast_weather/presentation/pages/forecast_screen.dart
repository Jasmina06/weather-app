import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:dartz/dartz.dart' as dartz;
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

// Import the necessary files
import 'package:weather_app/core/error/failures.dart';
import 'package:weather_app/core/platform/network_info.dart';
import 'package:weather_app/features/forecast_weather/data/datasource/local_data_source.dart';
import 'package:weather_app/features/forecast_weather/data/datasource/remote_data_source.dart';
import 'package:weather_app/features/forecast_weather/data/model/forecast_weather_model.dart';
import 'package:weather_app/features/forecast_weather/data/repository/forecast_weather_repository.dart';
import 'package:weather_app/features/forecast_weather/presentation/widgets/forecast_weather_info.dart';

class ForecastScreen extends StatefulWidget {
  const ForecastScreen({super.key});

  @override
  _ForecastScreenState createState() => _ForecastScreenState();
}

class _ForecastScreenState extends State<ForecastScreen> {
  // Переменная для хранения будущего прогноза погоды
  late Future<dartz.Either<Failure, List<ForecastWeatherModel>>> _forecastFuture;

  // Экземпляры зависимостей
  late ForecastWeatherRepositoryImpl weatherRepository;

  @override
  void initState() {
    super.initState();
    // Инициализируем зависимости и загружаем прогноз погоды
    _initializeDependencies();
  }

  // Метод для асинхронной инициализации зависимостей
  Future<void> _initializeDependencies() async {
    // Получаем SharedPreferences и InternetConnectionChecker
    final sharedPreferences = await SharedPreferences.getInstance();
    final internetConnectionChecker = InternetConnectionChecker();

    // Создаем экземпляры зависимостей
    final localDataSource = ForecastWeatherLocalDataSourceImpl(sharedPreferences: sharedPreferences);
    final remoteDataSource = ForecastWeatherRemoteDataSourceImpl(client: http.Client());
    final networkInfo = NetworkInfoImpl(internetConnectionChecker);

    // Создаем экземпляр репозитория с необходимыми зависимостями
    weatherRepository = ForecastWeatherRepositoryImpl(
      remoteDataSource: remoteDataSource,
      localDataSource: localDataSource,
      networkInfo: networkInfo,
    );

    // Загружаем данные прогноза погоды после инициализации
    _fetchForecastWeather();
  }

  // Метод для асинхронной загрузки данных прогноза погоды
  void _fetchForecastWeather() {
    // Присваиваем будущий результат, возвращаемый getForecastWeather
    _forecastFuture = weatherRepository.getForecastWeather('Tashkent');
    setState(() {}); // Обновляем состояние, чтобы запустить FutureBuilder
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('3-Day Weather Forecast'),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: FutureBuilder<dartz.Either<Failure, List<ForecastWeatherModel>>>(
        future: _forecastFuture,
        builder: (context, snapshot) {
          // Если данные еще загружаются, показываем индикатор загрузки
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          // Если произошла ошибка при загрузке данных
          else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          // Если данные успешно загружены
          else if (snapshot.hasData) {
            // Обрабатываем тип Either
            return snapshot.data!.fold(
              // Обрабатываем ошибку
              (failure) => Center(child: Text('Error: ${failure.toString()}')),
              // Обрабатываем успешный результат
              (forecastData) {
                log(forecastData.toString());
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      Expanded(
                        child: ListView.builder(
                          itemCount: forecastData.length,
                          itemBuilder: (context, index) {
                            final dayForecast = forecastData[index];
                            return DailyForecastWidget(
                              forecast: dayForecast,
                              dayLabel: index == 0 ? 'Tomorrow' : 'Day ${index + 1}',
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          }
          // Если данных нет (например, пустой список)
          else {
            return const Center(child: Text('No forecast data available.'));
          }
        },
      ),
    );
  }
}
