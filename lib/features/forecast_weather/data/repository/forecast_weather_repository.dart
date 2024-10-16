import 'dart:convert';
import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/core/error/failures.dart';
import 'package:weather_app/core/platform/network_info.dart';
import 'package:weather_app/features/forecast_weather/data/datasource/local_data_source.dart';
import 'package:weather_app/features/forecast_weather/data/datasource/remote_data_source.dart';
import 'package:weather_app/features/forecast_weather/data/model/forecast_weather_model.dart';
import 'package:weather_app/features/forecast_weather/domain/repository/forecast_weather_repository.dart';


class ForecastWeatherRepositoryImpl implements IForecastWeatherRepository {
  final String apiKey = 'b39b811330e116d6bbdc3e808df5f0b4'; 
  final String baseUrl = 'https://api.openweathermap.org/data/2.5';
  final http.Client client;

  final ForecastWeatherRemoteDataSource remoteDataSource;
  final ForecastWeatherLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  ForecastWeatherRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
    http.Client? httpClient,
  }) : client = httpClient ?? http.Client();

  @override
  Future<Either<Failure, List<ForecastWeatherModel>>> getForecastWeather(String city) async {
    try {
      if (await networkInfo.isConnected) {
        // Если есть интернет-соединение, получаем данные из удаленного источника
        final url = Uri.parse('$baseUrl/forecast?q=$city&cnt=3&appid=$apiKey&units=metric');
        final response = await client.get(url);

        log('BODY (Forecast Weather): ${response.body}');

        if (response.statusCode == 200) {
          final jsonBody = jsonDecode(response.body) as Map<String, dynamic>;
          final forecastList = (jsonBody['list'] as List)
              .map((e) => ForecastWeatherModel.fromJson(e as Map<String, dynamic>))
              .toList();
          
          // Кэшируем данные
          localDataSource.forecastWeatherToCache(forecastList);

          return Right(forecastList);
        } else {
          return Left(ServerFailure('Failed to fetch forecast weather data for $city'));
        }
      } else {
        // Если нет интернет-соединения, получаем данные из локального кэша
        try {
          final cachedForecast = await localDataSource.getLastForecastWeatherFromCache();
          return Right(cachedForecast);
        } catch (e) {
          return Left(CacheFailure());
        }
      }
    } catch (e) {
      log('Error fetching forecast weather data: $e');
      return Left(ServerFailure('An unexpected error occurred.'));
    }
  }

  
}
