import 'package:equatable/equatable.dart';

class ForecastWeatherModel extends Equatable {
  final int dt;
  final MainWeather main;
  final List<WeatherDescription> weather;
  final CloudModel clouds;
  final WindModel wind;
  final int visibility;
  final double? pop;
  final double? rain;

  ForecastWeatherModel({
    required this.dt,
    required this.main,
    required this.weather,
    required this.clouds,
    required this.wind,
    required this.visibility,
    this.pop,
    this.rain,
  });

 
  Map<String, Object?> toJson() {
    return {
      'dt': dt,
      'main': main.toJson(),
      'weather': weather.map((w) => w.toJson()).toList(),
      'clouds': clouds.toJson(),
      'wind': wind.toJson(),
      'visibility': visibility,
      'pop': pop,
      'rain': rain,
    };
  }

  factory ForecastWeatherModel.fromJson(Map<String, Object?> json) {
    return ForecastWeatherModel(
      dt: json['dt'] as int,
      main: MainWeather.fromJson(json['main'] as Map<String, Object?>),
      weather: (json['weather'] as List<Object?>)
          .map((item) => WeatherDescription.fromJson(item as Map<String, Object?>))
          .toList(),
      clouds: CloudModel.fromJson(json['clouds'] as Map<String, Object?>),
      wind: WindModel.fromJson(json['wind'] as Map<String, Object?>),
      visibility: json['visibility'] as int,
      pop: (json['pop'] as num?)?.toDouble(),
      rain: (json['rain'] as Map<String, Object?>?)?['1h'] as double?,
    );
  }

  @override
  List<Object?> get props => [dt, main, weather, clouds, wind, visibility, pop, rain];
}

class MainWeather extends Equatable {
  final double temp;
  final double feelsLike;

  MainWeather({
    required this.temp,
    required this.feelsLike,
  });

  // Метод toJson для MainWeather
  Map<String, Object> toJson() {
    return {
      'temp': temp,
      'feels_like': feelsLike,
    };
  }

  factory MainWeather.fromJson(Map<String, Object?> json) {
    return MainWeather(
      temp: (json['temp'] as num).toDouble(),
      feelsLike: (json['feels_like'] as num).toDouble(),
    );
  }

  @override
  List<Object> get props => [temp, feelsLike];
}

class WeatherDescription extends Equatable {
  final String main;
  final String description;

  WeatherDescription({
    required this.main,
    required this.description,
  });

  // Метод toJson для WeatherDescription
  Map<String, Object> toJson() {
    return {
      'main': main,
      'description': description,
    };
  }

  factory WeatherDescription.fromJson(Map<String, Object?> json) {
    return WeatherDescription(
      main: json['main'] as String,
      description: json['description'] as String,
    );
  }

  @override
  List<Object> get props => [main, description];
}

class CloudModel extends Equatable {
  final int all;

  CloudModel({
    required this.all,
  });

  // Метод toJson для CloudModel
  Map<String, Object> toJson() {
    return {
      'all': all,
    };
  }

  factory CloudModel.fromJson(Map<String, Object?> json) {
    return CloudModel(
      all: json['all'] as int,
    );
  }

  @override
  List<Object> get props => [all];
}

class WindModel extends Equatable {
  final double speed;
  final int deg;
  final double? gust;

  WindModel({
    required this.speed,
    required this.deg,
    this.gust,
  });

  // Метод toJson для WindModel
  Map<String, Object?> toJson() {
    return {
      'speed': speed,
      'deg': deg,
      'gust': gust,
    };
  }

  factory WindModel.fromJson(Map<String, Object?> json) {
    return WindModel(
      speed: (json['speed'] as num).toDouble(),
      deg: json['deg'] as int,
      gust: (json['gust'] as num?)?.toDouble(),
    );
  }

  @override
  List<Object?> get props => [speed, deg, gust];
}
