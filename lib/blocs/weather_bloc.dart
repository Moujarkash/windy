import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:windy/models/forecast/forecast.dart';
import 'package:windy/repositories/weather_repository.dart';

class WeatherBloc {
  final _forecast = BehaviorSubject<Forecast>();

  Stream<Forecast> get forecast => _forecast.stream;

  Future<Forecast> getForecast({@required String regionId}) async {
    var response = await WeatherRepository.getInstance().fetchForecast(regionId: regionId);
    _forecast.sink.add(response);

    //put data in local
    if (response.error  == null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var currentDate = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
      if (!prefs.containsKey(currentDate.millisecondsSinceEpoch.toString())) {
        prefs.setString(currentDate.millisecondsSinceEpoch.toString(), jsonEncode(response.toJson()));
      }
    }

    return response;
  }

  void dispose() {
    _forecast.close();
  }
}

final weatherBloc = WeatherBloc();