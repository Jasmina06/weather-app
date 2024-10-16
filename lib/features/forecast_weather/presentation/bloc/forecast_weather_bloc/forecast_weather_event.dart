import 'package:freezed_annotation/freezed_annotation.dart';

part 'forecast_weather_event.freezed.dart';

@freezed
class ForecastEvent with _$ForecastEvent {
  const factory ForecastEvent.fetchForecast(String city) = _FetchForecast;
}
