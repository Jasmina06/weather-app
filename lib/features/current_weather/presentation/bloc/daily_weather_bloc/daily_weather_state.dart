import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:weather_app/features/current_weather/data/models/current_weather_model.dart';

part 'daily_weather_state.freezed.dart';

@freezed
class DailyWeatherState with _$DailyWeatherState {
  const factory DailyWeatherState.initial() = _Initial;
  const factory DailyWeatherState.loading() = _Loading;
  const factory DailyWeatherState.loaded(CurrentWeatherModel weather) = _Loaded;
  const factory DailyWeatherState.error(String message) = _Error;
}
