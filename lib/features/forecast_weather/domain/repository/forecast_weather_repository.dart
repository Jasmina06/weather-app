import 'package:dartz/dartz.dart';
import 'package:weather_app/core/error/failures.dart';
import 'package:weather_app/features/forecast_weather/data/model/forecast_weather_model.dart';

abstract class IForecastWeatherRepository {
  Future<Either<Failure, List<ForecastWeatherModel>>> getForecastWeather(String city);
}
