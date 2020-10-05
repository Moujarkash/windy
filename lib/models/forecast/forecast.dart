import 'package:json_annotation/json_annotation.dart';

part 'forecast.g.dart';

@JsonSerializable()
class Forecast {
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

  Forecast({this.date});

  factory Forecast.fromJson(Map<String, dynamic> json) => _$ForecastFromJson(json);

  Map<String, dynamic> toJson() => _$ForecastToJson(this);

  static DateTime _getDateFromTimestampString(String jsonValue) {
      if (jsonValue == null || jsonValue.isEmpty)
        return null;

      return DateTime.fromMillisecondsSinceEpoch(int.parse(jsonValue));
  }

  static String _getTimestampStringFromDate(DateTime date) {
    if (date == null)
      return '';
    return date.millisecondsSinceEpoch.toString();
  }
}

@JsonSerializable()
class ForecastMainInfo {
  @JsonKey(name: 'key')
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
  String icon;

  Weather({this.id, this.main, this.description, this.icon});

  factory Weather.fromJson(Map<String, dynamic> json) => _$WeatherFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherToJson(this);
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
  double speed;
  int deg;

  Wind({this.speed, this.deg});

  factory Wind.fromJson(Map<String, dynamic> json) => _$WindFromJson(json);

  Map<String, dynamic> toJson() => _$WindToJson(this);
}