import 'package:equatable/equatable.dart';

class ForecastWeatherEntity extends Equatable {
  final List<ForecastDayEntity> forecastDays; 

  ForecastWeatherEntity({required this.forecastDays});

  @override
  List<Object?> get props => [forecastDays];
}

class ForecastDayEntity extends Equatable {
  final int dt; 
  final MainWeatherEntity main; 
  final List<WeatherConditionEntity> weather; 
  final CloudsEntity clouds; 
  final WindEntity wind;
  final int visibility; 
  final double? pop; 
  final RainEntity? rain; 

  ForecastDayEntity({
    required this.dt,
    required this.main,
    required this.weather,
    required this.clouds,
    required this.wind,
    required this.visibility,
    this.pop,
    this.rain,
  });

  @override
  List<Object?> get props => [dt, main, weather, clouds, wind, visibility, pop, rain];
}

class MainWeatherEntity extends Equatable {
  final double temp; 
  final double feelsLike; 
  final double tempMin; 
  final double tempMax; 
  final int humidity; 

  MainWeatherEntity({
    required this.temp,
    required this.feelsLike,
    required this.tempMin,
    required this.tempMax,
    required this.humidity,
  });

  @override
  List<Object?> get props => [temp, feelsLike, tempMin, tempMax, humidity];
}

class WeatherConditionEntity extends Equatable {
  final int id; 
  final String main; 
  final String description; 
  final String icon; 

  WeatherConditionEntity({
    required this.id,
    required this.main,
    required this.description,
    required this.icon,
  });

  @override
  List<Object?> get props => [id, main, description, icon];
}

class CloudsEntity extends Equatable {
  final int all; 

  CloudsEntity({required this.all});

  @override
  List<Object?> get props => [all];
}

class WindEntity extends Equatable {
  final double speed; 
  final int deg; 

  WindEntity({required this.speed, required this.deg});

  @override
  List<Object?> get props => [speed, deg];
}

class RainEntity extends Equatable {
  final double volume; 

  RainEntity({required this.volume});

  @override
  List<Object?> get props => [volume];
}
