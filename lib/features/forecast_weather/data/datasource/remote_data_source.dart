import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather_app/core/error/exeptions.dart';
import 'package:weather_app/features/forecast_weather/data/model/forecast_weather_model.dart';

abstract class ForecastWeatherRemoteDataSource {
  
  Future<List<ForecastWeatherModel>> getForecastWeather(String city);
}

class ForecastWeatherRemoteDataSourceImpl implements ForecastWeatherRemoteDataSource {
  final http.Client client;
  final String apiKey = 'b39b811330e116d6bbdc3e808df5f0b4'; 
  final String baseUrl = 'https://api.openweathermap.org/data/2.5';

  ForecastWeatherRemoteDataSourceImpl({required this.client});

  @override
  Future<List<ForecastWeatherModel>> getForecastWeather(String city) async {
    final url = Uri.parse('$baseUrl/forecast?q=$city&appid=$apiKey&units=metric');

    final response = await client.get(url);

    if (response.statusCode == 200) {
      final jsonBody = jsonDecode(response.body) as Map<String, dynamic>;
      
      return (jsonBody['list'] as List)
          .map((item) => ForecastWeatherModel.fromJson(item as Map<String, dynamic>))
          .toList();
    } else {
      throw ServerExeption();
    }
  }
}
