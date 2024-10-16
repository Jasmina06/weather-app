import 'package:equatable/equatable.dart';

class CurrentWeatherEntity extends Equatable {
  final List<WeatherConditionEntity> weather; 
  final MainWeatherEntity main; 
  final WindEntity wind; 
  final CloudsEntity clouds;
  final int dt; 
  final SysEntity sys; 
  final String name; 

  CurrentWeatherEntity({
    required this.weather,
    required this.main,
    required this.wind,
    required this.clouds,
    required this.dt,
    required this.sys,
    required this.name,
  });

  @override
  List<Object?> get props => [weather, main, wind, clouds, dt, sys, name];
}

class CloudsEntity extends Equatable {
  final int all; 

  CloudsEntity({required this.all});

  @override
  List<Object?> get props => [all];
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

class SysEntity extends Equatable {
  final String country; 
  final int sunrise; 
  final int sunset; 

  SysEntity({required this.country, required this.sunrise, required this.sunset});

  @override
  List<Object?> get props => [country, sunrise, sunset];
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

class WindEntity extends Equatable {
  final double speed;
  final int deg; 

  WindEntity({required this.speed, required this.deg});

  @override
  List<Object?> get props => [speed, deg];
}
