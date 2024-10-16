import 'package:dartz/dartz.dart';
import 'package:weather_app/core/error/failures.dart';
import 'package:weather_app/features/current_weather/data/models/current_weather_model.dart';

abstract class ICurrentWeatherRepository {
  Future<Either<Failure, CurrentWeatherModel>> getCurrentWeather(String city);
}
