import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:windy/models/forecast/forecast.dart';
import 'package:windy/repositories/weather_repository.dart';

class WeatherBloc {
  final _forecast = BehaviorSubject<Forecast>();

  Stream<Forecast> get forecast => _forecast.stream;

  Future<Forecast> getForecast({@required String regionId}) async {
    var response = await WeatherRepository.getInstance().fetchForecast(regionId: regionId);
    _forecast.sink.add(response);

    return response;
  }

  void dispose() {
    _forecast.close();
  }
}

final weatherBloc = WeatherBloc();