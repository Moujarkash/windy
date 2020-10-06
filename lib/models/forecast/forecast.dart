import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:collection/collection.dart';

part 'forecast.g.dart';

@JsonSerializable()
class Forecast {
  @JsonKey(name: 'cod')
  String code;
  @JsonKey(name: 'message')
  int message;
  @JsonKey(name: 'list')
  List<ForecastDetails> details;
  @JsonKey(name: 'city')
  City city;
  @JsonKey(ignore: true)
  int error;

  Forecast({this.code, this.message, this.details, this.city});

  Forecast.withError(int error) {
    this.code = null;
    this.message = null;
    this.details = List<ForecastDetails>();
    this.city = null;
    this.error = error;
  }

  factory Forecast.fromJson(Map<String, dynamic> json) => _$ForecastFromJson(json);

  Map<String, dynamic> toJson() => _$ForecastToJson(this);

  Map<DateTime, List<ForecastDetails>> groupDetailsByDay() {
    if (details == null || details.isEmpty)
      return null;

    return groupBy(details, (ForecastDetails element) => DateTime(element.date.year, element.date.month, element.date.day));
  }
}

@JsonSerializable()
class ForecastDetails {
  @JsonKey(name: 'dt', fromJson: _getDateFromTimestampString, toJson: _getTimestampStringFromDate)
  DateTime date;
  @JsonKey(name: 'main')
  ForecastMainInfo forecastMainInfo;
  @JsonKey(name: 'weather')
  List<Weather> weatherList;
  @JsonKey(name: 'clouds')
  Clouds clouds;
  @JsonKey(name: 'wind')
  Wind wind;
  @JsonKey(name: 'visibility')
  int visibility;
  @JsonKey(name: 'pop')
  int pop;
  @JsonKey(name: 'dt_txt')
  String dateText;

  ForecastDetails({this.date});

  factory ForecastDetails.fromJson(Map<String, dynamic> json) => _$ForecastDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$ForecastDetailsToJson(this);

  static DateTime _getDateFromTimestampString(int jsonValue) {
      if (jsonValue == null)
        return null;

      return DateTime.fromMillisecondsSinceEpoch(jsonValue * 1000, isUtc: true);
  }

  static int _getTimestampStringFromDate(DateTime date) {
    if (date == null)
      return -1;
    return date.toUtc().millisecondsSinceEpoch ~/ 1000;
  }
}

@JsonSerializable()
class ForecastMainInfo {
  @JsonKey(name: 'temp')
  double temp;
  @JsonKey(name: 'feels_like')
  double feelsLike;
  @JsonKey(name: 'temp_min')
  double tempMin;
  @JsonKey(name: 'temp_max')
  double tempMax;
  @JsonKey(name: 'pressure')
  int pressure;
  @JsonKey(name: 'sea_level')
  int seaLevel;
  @JsonKey(name: 'grnd_level')
  int groundLevel;
  @JsonKey(name: 'humidity')
  int humidity;
  @JsonKey(name: 'temp_kf')
  double tempKf;

  ForecastMainInfo({
      this.temp,
      this.feelsLike,
      this.tempMin,
      this.tempMax,
      this.pressure,
      this.seaLevel,
      this.groundLevel,
      this.humidity,
      this.tempKf});

  factory ForecastMainInfo.fromJson(Map<String, dynamic> json) => _$ForecastMainInfoFromJson(json);

  Map<String, dynamic> toJson() => _$ForecastMainInfoToJson(this);
}

@JsonSerializable()
class Weather {
  int id;
  String main;
  String description;
  @JsonKey(fromJson: _getIconUrl)
  String icon;

  Weather({this.id, this.main, this.description, this.icon});

  factory Weather.fromJson(Map<String, dynamic> json) => _$WeatherFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherToJson(this);

  static String _getIconUrl(String jsonValue) {
    if (jsonValue == null || jsonValue.isEmpty)
      return null;

    jsonValue = jsonValue.replaceAll('n', 'd');

    return 'http://openweathermap.org/img/wn/$jsonValue@2x.png';
  }

  Color getWeatherColor() {
    switch(main) {
      case 'Rain':
      case 'Drizzle':
        return Colors.teal;
      case 'Clear':
        return Colors.orange;
      case 'Clouds':
        return Colors.lightGreen;
      case 'Snow':
        return Colors.blueGrey;
      case 'Thunderstorm':
        return Colors.yellow;
      default:
        return Colors.teal;
    }
  }

  String getWeatherImageName() {
    switch(main) {
      case 'Rain':
      case 'Drizzle':
        return 'assets/images/rain.png';
      case 'Clear':
        return 'assets/images/sun.png';
      case 'Clouds':
        return 'assets/images/clouds.png';
      case 'Snow':
        return 'assets/images/snow.png';
      case 'Thunderstorm':
        return 'assets/images/lighting.png';
      default:
        return 'assets/images/logo.png';
    }
  }
}

@JsonSerializable()
class Clouds {
  int all;

  Clouds({this.all});

  factory Clouds.fromJson(Map<String, dynamic> json) => _$CloudsFromJson(json);

  Map<String, dynamic> toJson() => _$CloudsToJson(this);
}

@JsonSerializable()
class Wind {
  @JsonKey(fromJson: _convertSpeedToKmPerHour)
  double speed;
  int deg;

  Wind({this.speed, this.deg});

  factory Wind.fromJson(Map<String, dynamic> json) => _$WindFromJson(json);

  Map<String, dynamic> toJson() => _$WindToJson(this);

  static double _convertSpeedToKmPerHour(dynamic jsonValue) {
    if (jsonValue == null)
      return -1;

    return jsonValue * 3.6;
  }
}

@JsonSerializable()
class City {
  int id;
  String name;
  String country;
  @JsonKey(name: 'coord')
  Coordinates coordinates;
  int population;
  int timezone;
  int sunrise;
  int sunset;

  City({this.id, this.name, this.country, this.coordinates, this.population,
      this.timezone, this.sunrise, this.sunset});

  factory City.fromJson(Map<String, dynamic> json) => _$CityFromJson(json);

  Map<String, dynamic> toJson() => _$CityToJson(this);
}

@JsonSerializable()
class Coordinates {
  double lat;
  double lon;

  Coordinates({this.lat, this.lon});

  factory Coordinates.fromJson(Map<String, dynamic> json) => _$CoordinatesFromJson(json);

  Map<String, dynamic> toJson() => _$CoordinatesToJson(this);
}