import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/core/constants/constants.dart';
import 'package:weather_app/core/error/exeptions.dart';
import 'package:weather_app/features/forecast_weather/data/model/forecast_weather_model.dart';

abstract class ForecastWeatherLocalDataSource {
  Future<List<ForecastWeatherModel>> getLastForecastWeatherFromCache();
  Future<void> forecastWeatherToCache(List<ForecastWeatherModel> forecastWeatherList);
}

class ForecastWeatherLocalDataSourceImpl implements ForecastWeatherLocalDataSource {
  final SharedPreferences sharedPreferences;

  ForecastWeatherLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<void> forecastWeatherToCache(List<ForecastWeatherModel> forecastWeatherList) {
    // Сериализуем список моделей прогноза погоды в JSON
    final List<String> jsonForecastWeatherList = forecastWeatherList.map((forecast) => json.encode(forecast.toJson())).toList();
    // Сохраняем сериализованный список в SharedPreferences
    sharedPreferences.setStringList(Constants.CACHED_FORECAST_WEAHTER, jsonForecastWeatherList);
    print('Forecast weather written to cache: $jsonForecastWeatherList');

    return Future.value();
  }

  @override
  Future<List<ForecastWeatherModel>> getLastForecastWeatherFromCache() {
    // Извлекаем сохраненный список строк из SharedPreferences
    final jsonForecastWeatherList = sharedPreferences.getStringList(Constants.CACHED_FORECAST_WEAHTER);
    if (jsonForecastWeatherList == null || jsonForecastWeatherList.isEmpty) {
      throw CacheExeption();
    } else {
      // Десериализуем каждую строку в объект ForecastWeatherModel
      final forecastList = jsonForecastWeatherList.map((jsonString) => ForecastWeatherModel.fromJson(json.decode(jsonString))).toList();
      return Future.value(forecastList);
    }
  }
}
