import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:retrofit/retrofit.dart';
import 'package:windy/constants.dart';
import 'package:windy/models/forecast/forecast.dart';

part 'weather_rest_client.g.dart';

@RestApi (baseUrl: "api.openweathermap.org" )
abstract class WeatherRestClient {
  factory WeatherRestClient(Dio dio, { String baseUrl}) = _WeatherRestClient;

  @GET("/data/2.5/forecast")
  Future<Forecast> fetchForecast(
  {@required @Query("id") String id,
      @Query("appid") String appId = OPEN_WEATHER_API_KEY});
}