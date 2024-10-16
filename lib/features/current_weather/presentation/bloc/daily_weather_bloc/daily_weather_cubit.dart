import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:weather_app/core/error/failures.dart';
import 'package:weather_app/features/current_weather/domain/usecases/get_current_weather_usecase.dart';
import 'package:weather_app/features/current_weather/data/models/current_weather_model.dart';

import 'daily_weather_state.dart';

class DailyWeatherCubit extends Cubit<DailyWeatherState> {
  final GetCurrentWeather getCurrentWeather;

  // Corrected constructor to take only GetCurrentWeather
  DailyWeatherCubit({required this.getCurrentWeather}) : super(const DailyWeatherState.initial());

  Future<void> fetchCurrentWeather(String city) async {
    emit(const DailyWeatherState.loading());
    final Either<Failure, CurrentWeatherModel> eitherWeather = await getCurrentWeather(CurrentWeatherParams(city: city));

    eitherWeather.fold(
      (failure) {
        // Handling error
        final errorMessage = _mapFailureToMessage(failure);
        emit(DailyWeatherState.error(errorMessage));
      },
      (weather) {
        // If successful, update the state
        emit(DailyWeatherState.loaded(weather));
      },
    );
  }

  // Function to map Failure to error message
  String _mapFailureToMessage(Failure failure) {
    if (failure is ServerFailure) {
      return 'Server Failure: Could not fetch weather data';
    } else if (failure is CacheFailure) {
      return 'Cache Failure: Could not retrieve cached data';
    } else {
      return 'Unexpected Error';
    }
  }
}
