import 'package:dartz/dartz.dart';
import 'package:weather_app/core/error/failures.dart';
import 'package:weather_app/core/usecase/usecase.dart';
import 'package:weather_app/features/current_weather/data/models/current_weather_model.dart';
import 'package:weather_app/features/current_weather/domain/repository/current_weather_repository.dart';

class GetCurrentWeather implements UseCase<CurrentWeatherModel, CurrentWeatherParams> {
  final ICurrentWeatherRepository repository;

  GetCurrentWeather(this.repository);

  @override
  Future<Either<Failure, CurrentWeatherModel>> call(CurrentWeatherParams params) async {
    return await repository.getCurrentWeather(params.city);
  }
}

class CurrentWeatherParams {
  final String city;

  CurrentWeatherParams({required this.city});
}
