
import 'package:dartz/dartz.dart';
import 'package:weather_app/core/error/failures.dart';
import 'package:weather_app/features/forecast_weather/data/model/forecast_weather_model.dart';
import 'package:weather_app/features/forecast_weather/domain/repository/forecast_weather_repository.dart';

class GetForecastWeather {
  final IForecastWeatherRepository repository;

  GetForecastWeather(this.repository);

  Future<Either<Failure, List<ForecastWeatherModel>>> call(String city) {
    return repository.getForecastWeather(city);
  }
}
