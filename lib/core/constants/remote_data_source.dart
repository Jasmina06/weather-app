import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather_app/core/error/exeptions.dart';
import 'package:weather_app/features/current_weather/data/models/current_weather_model.dart';

abstract class CurrentWeatherRemoteDataSource {

  Future<CurrentWeatherModel> getCurrentWeather(String city);
}

class CurrentWeatherRemoteDataSourceImpl implements CurrentWeatherRemoteDataSource {
  final http.Client client;
  final String apiKey = 'b39b811330e116d6bbdc3e808df5f0b4'; 
  final String baseUrl = 'https://api.openweathermap.org/data/2.5';

  CurrentWeatherRemoteDataSourceImpl({required this.client});

  @override
  Future<CurrentWeatherModel> getCurrentWeather(String city) async {
    final url = Uri.parse('$baseUrl/weather?q=$city&appid=$apiKey&units=metric');

    final response = await client.get(url);

    if (response.statusCode == 200) {
      final jsonBody = jsonDecode(response.body);
      return CurrentWeatherModel.fromJson(jsonBody);
    } else {
      throw ServerExeption();
    }
  }
}
