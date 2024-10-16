import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

// Core
import 'package:weather_app/core/platform/network_info.dart';
import 'package:weather_app/core/platform/geolocation_info.dart';

// Data Sources
import 'package:weather_app/features/current_weather/data/datasource/local_data_source.dart';
import 'package:weather_app/core/constants/remote_data_source.dart';
import 'package:weather_app/features/forecast_weather/data/datasource/local_data_source.dart';
import 'package:weather_app/features/forecast_weather/data/datasource/remote_data_source.dart';

// Repositories
import 'package:weather_app/features/current_weather/data/repository/current_weather_repository.dart';
import 'package:weather_app/features/current_weather/domain/repository/current_weather_repository.dart';
import 'package:weather_app/features/forecast_weather/data/repository/forecast_weather_repository.dart';
import 'package:weather_app/features/forecast_weather/domain/repository/forecast_weather_repository.dart';

// Use Cases
import 'package:weather_app/features/current_weather/domain/usecases/get_current_weather_usecase.dart';
import 'package:weather_app/features/forecast_weather/domain/usecase/get_forecast_weather_usecase.dart';

// Blocs
import 'package:weather_app/features/current_weather/presentation/bloc/daily_weather_bloc/daily_weather_cubit.dart';
import 'package:weather_app/features/forecast_weather/presentation/bloc/forecast_weather_bloc/forecast_weather_bloc.dart';

final sl = GetIt.instance;

Future<void> initDI() async {
  // Внешние зависимости
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());

  // Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  sl.registerLazySingleton<GeolocationImpl>(() => GeolocationImpl());

  // Data Sources
  sl.registerLazySingleton<CurrentWeatherLocalDataSource>(
    () => CurrentWeatherLocalDataSourceImpl(sharedPreferences: sl()),
  );
  sl.registerLazySingleton<CurrentWeatherRemoteDataSource>(
    () => CurrentWeatherRemoteDataSourceImpl(client: sl()),
  );
  sl.registerLazySingleton<ForecastWeatherLocalDataSource>(
    () => ForecastWeatherLocalDataSourceImpl(sharedPreferences: sl()),
  );
  sl.registerLazySingleton<ForecastWeatherRemoteDataSource>(
    () => ForecastWeatherRemoteDataSourceImpl(client: sl()),
  );

  // Repositories
  sl.registerLazySingleton<ICurrentWeatherRepository>(
    () => CurrentWeatherRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );
  sl.registerLazySingleton<IForecastWeatherRepository>(
    () => ForecastWeatherRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  // Use Cases54
  sl.registerLazySingleton(() => GetCurrentWeather(sl()));
  sl.registerLazySingleton(() => GetForecastWeather(sl()));

  // Блоки
  sl.registerFactory(() => DailyWeatherCubit(getCurrentWeather: sl()));
  sl.registerFactory(() => ForecastBloc(getForecastWeather: sl()));
}
