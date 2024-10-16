
import 'dart:developer';
import 'package:dartz/dartz.dart';

import 'package:weather_app/core/error/failures.dart';
import 'package:weather_app/core/platform/network_info.dart';
import 'package:weather_app/features/current_weather/data/datasource/local_data_source.dart';
import 'package:weather_app/core/constants/remote_data_source.dart';
import 'package:weather_app/features/current_weather/data/models/current_weather_model.dart';
import 'package:weather_app/features/current_weather/domain/repository/current_weather_repository.dart';

/// Реализация интерфейса для работы с текущей погодой
class CurrentWeatherRepositoryImpl implements ICurrentWeatherRepository {
  final CurrentWeatherRemoteDataSource remoteDataSource;
  final CurrentWeatherLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  // Конструктор, позволяющий передать необходимые зависимости
  CurrentWeatherRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, CurrentWeatherModel>> getCurrentWeather(String city) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteWeather = await remoteDataSource.getCurrentWeather(city);
        // Сохранение данных в кэш
        localDataSource.currentWeatherToCache(remoteWeather);
        return Right(remoteWeather);
      }  catch (e) {


        log('Error fetching weather data from remote: $e');
        return Left(ServerFailure());
      }
    } else {
      try {
        // Получение данных из кэша, если отсутствует интернет
        final localWeather = await localDataSource.getLastCurrentWeatherFromCache();
        return Right(localWeather);
      } catch (e) {
        log('Error fetching weather data from cache: $e');
        return Left(CacheFailure());
      }
    }
  }
}
