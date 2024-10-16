import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/core/constants/constants.dart';
import 'package:weather_app/core/error/exeptions.dart';
import 'package:weather_app/features/current_weather/data/models/current_weather_model.dart';


abstract class CurrentWeatherLocalDataSource {
  Future<CurrentWeatherModel> getLastCurrentWeatherFromCache();
  Future<void> currentWeatherToCache(CurrentWeatherModel dailyWeather);
}

class CurrentWeatherLocalDataSourceImpl implements CurrentWeatherLocalDataSource {
  final SharedPreferences sharedPreferences;

  CurrentWeatherLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<void> currentWeatherToCache(CurrentWeatherModel dailyWeather) {
    final String jsonDailyWeather = json.encode(dailyWeather.toJson());
    sharedPreferences.setString(Constants.CACHED_DAILY_WEATHER, jsonDailyWeather);
    print('Current weather written to cache: $jsonDailyWeather');

    return Future.value();
  }

  @override
  Future<CurrentWeatherModel> getLastCurrentWeatherFromCache() {
    final jsonDailyWeather = sharedPreferences.getString(Constants.CACHED_DAILY_WEATHER);
    if (jsonDailyWeather == null || jsonDailyWeather.isEmpty) {
      throw CacheExeption();
    } else {
      return Future.value(CurrentWeatherModel.fromJson(json.decode(jsonDailyWeather)));
    }
  }
}
