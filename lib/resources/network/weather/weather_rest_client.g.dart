// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_rest_client.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _WeatherRestClient implements WeatherRestClient {
  _WeatherRestClient(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
    this.baseUrl ??= 'api.openweathermap.org';
  }

  final Dio _dio;

  String baseUrl;

  @override
  fetchForecast({id, appId = OPEN_WEATHER_API_KEY}) async {
    ArgumentError.checkNotNull(id, 'id');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'id': id, r'appid': appId};
    queryParameters.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final Response<Map<String, dynamic>> _result = await _dio.request(
        '/data/2.5/forecast',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = Forecast.fromJson(_result.data);
    return value;
  }
}
