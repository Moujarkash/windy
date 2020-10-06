import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:windy/models/forecast/forecast.dart';
import 'package:windy/resources/network/weather/weather_rest_client.dart';

class WeatherRepository {
  static WeatherRepository _instance;
  final WeatherRestClient _client;

  WeatherRepository._internal({WeatherRestClient client})
      : _client = client ?? WeatherRestClient(Dio());

  static WeatherRepository getInstance({WeatherRestClient client}) {
      if (_instance == null)
        _instance = WeatherRepository._internal(client: client);

      return _instance;
  }

  Future<Forecast> fetchForecast({@required String regionId}) async {
    //local
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var currentDate = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    if (prefs.containsKey(currentDate.millisecondsSinceEpoch.toString())) {
      var forecastJson = prefs.getString(currentDate.millisecondsSinceEpoch.toString());
      return Forecast.fromJson(jsonDecode(forecastJson));
    }

    //network
    return await _client
        .fetchForecast(regionId: regionId)
        .then((value) => value)
        .catchError((e) {
      log(e.toString());
      return Forecast.withError(500);
    });
  }
}
