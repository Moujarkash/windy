// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'forecast.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Forecast _$ForecastFromJson(Map<String, dynamic> json) {
  return Forecast(
    date: Forecast._getDateFromTimestampString(json['dt'] as String),
  )
    ..forecastMainInfo = json['main'] == null
        ? null
        : ForecastMainInfo.fromJson(json['main'] as Map<String, dynamic>)
    ..weatherList = (json['weather'] as List)
        ?.map((e) =>
            e == null ? null : Weather.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..clouds = json['clouds'] == null
        ? null
        : Clouds.fromJson(json['clouds'] as Map<String, dynamic>)
    ..wind = json['wind'] == null
        ? null
        : Wind.fromJson(json['wind'] as Map<String, dynamic>)
    ..visibility = json['visibility'] as int
    ..pop = json['pop'] as int
    ..dateText = json['dt_txt'] as String;
}

Map<String, dynamic> _$ForecastToJson(Forecast instance) => <String, dynamic>{
      'dt': Forecast._getTimestampStringFromDate(instance.date),
      'main': instance.forecastMainInfo,
      'weather': instance.weatherList,
      'clouds': instance.clouds,
      'wind': instance.wind,
      'visibility': instance.visibility,
      'pop': instance.pop,
      'dt_txt': instance.dateText,
    };

ForecastMainInfo _$ForecastMainInfoFromJson(Map<String, dynamic> json) {
  return ForecastMainInfo(
    temp: (json['key'] as num)?.toDouble(),
    feelsLike: (json['feels_like'] as num)?.toDouble(),
    tempMin: (json['temp_min'] as num)?.toDouble(),
    tempMax: (json['temp_max'] as num)?.toDouble(),
    pressure: json['pressure'] as int,
    seaLevel: json['sea_level'] as int,
    groundLevel: json['grnd_level'] as int,
    humidity: json['humidity'] as int,
    tempKf: (json['temp_kf'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$ForecastMainInfoToJson(ForecastMainInfo instance) =>
    <String, dynamic>{
      'key': instance.temp,
      'feels_like': instance.feelsLike,
      'temp_min': instance.tempMin,
      'temp_max': instance.tempMax,
      'pressure': instance.pressure,
      'sea_level': instance.seaLevel,
      'grnd_level': instance.groundLevel,
      'humidity': instance.humidity,
      'temp_kf': instance.tempKf,
    };

Weather _$WeatherFromJson(Map<String, dynamic> json) {
  return Weather(
    id: json['id'] as int,
    main: json['main'] as String,
    description: json['description'] as String,
    icon: json['icon'] as String,
  );
}

Map<String, dynamic> _$WeatherToJson(Weather instance) => <String, dynamic>{
      'id': instance.id,
      'main': instance.main,
      'description': instance.description,
      'icon': instance.icon,
    };

Clouds _$CloudsFromJson(Map<String, dynamic> json) {
  return Clouds(
    all: json['all'] as int,
  );
}

Map<String, dynamic> _$CloudsToJson(Clouds instance) => <String, dynamic>{
      'all': instance.all,
    };

Wind _$WindFromJson(Map<String, dynamic> json) {
  return Wind(
    speed: (json['speed'] as num)?.toDouble(),
    deg: json['deg'] as int,
  );
}

Map<String, dynamic> _$WindToJson(Wind instance) => <String, dynamic>{
      'speed': instance.speed,
      'deg': instance.deg,
    };
