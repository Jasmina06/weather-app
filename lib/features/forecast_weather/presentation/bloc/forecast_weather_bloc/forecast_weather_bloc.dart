import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:weather_app/core/error/failures.dart';
import 'package:weather_app/features/forecast_weather/data/model/forecast_weather_model.dart';
import 'package:weather_app/features/forecast_weather/domain/usecase/get_forecast_weather_usecase.dart'; // Импортируйте ваш UseCase
import 'forecast_weather_event.dart';
import 'forecast_weather_state.dart';

part 'forecast_weather_bloc.freezed.dart';

class ForecastBloc extends Bloc<ForecastEvent, ForecastState> {
  final GetForecastWeather getForecastWeather; 

  // Передаем UseCase в конструктор вместо репозитория
  ForecastBloc({required this.getForecastWeather}) : super(const ForecastState.initial()) {
    on<ForecastEvent>(_forecastFetch);
  }

  Future<void> _forecastFetch(ForecastEvent event, Emitter<ForecastState> emit) async {
    await event.when(
      fetchForecast: (city) async {
        emit(const ForecastState.loading());
        
        // Вызываем UseCase
        final Either<Failure, List<ForecastWeatherModel>> result = await getForecastWeather(city);

        result.fold(
          (failure) {
            emit(ForecastState.error(_mapFailureToMessage(failure)));
          },
          (forecast) {
            emit(ForecastState.loaded(forecast));
          },
        );
      },
    );
  }

  // Метод для маппинга Failure в сообщение об ошибке
  String _mapFailureToMessage(Failure failure) {
    if (failure is ServerFailure) {
      return 'Server Failure: Could not fetch forecast weather data';
    } else if (failure is CacheFailure) {
      return 'Cache Failure: Could not retrieve cached data';
    } else {
      return 'Unexpected Error';
    }
  }
}
