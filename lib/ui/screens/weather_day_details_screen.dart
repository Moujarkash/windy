import 'package:flutter/material.dart';
import 'package:windy/models/forecast/forecast.dart';
import 'package:windy/utils/extensions.dart';

class WeatherDayDetailsScreen extends StatelessWidget {
  final ForecastDetails forecastDetails;
  final String city;

  const WeatherDayDetailsScreen(
      {@required this.forecastDetails, @required this.city});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(left: 24, top: 48, bottom: 16),
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              forecastDetails.weatherList[0].getWeatherColor().withOpacity(0.7),
              forecastDetails.weatherList[0].getWeatherColor(),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              forecastDetails.weatherList[0].description
                  .replaceAll(' ', '\n').capitalizeFirstLitter(),
              style: TextStyle(color: Colors.white, fontSize: 28),
            ),
            const SizedBox(height: 48,),
            Expanded(
              flex: 1,
                child: Center(child: Image.asset(forecastDetails.weatherList[0].getWeatherImageName(), width: 250, height: 250,))),
            const SizedBox(height: 48,),
            SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        city,
                        style: TextStyle(color: Colors.white, fontSize: 38, fontWeight: FontWeight.w300),
                      ),
                      Text(
                        '${forecastDetails.forecastMainInfo.temp.round()}°',
                        style: TextStyle(color: Colors.white, fontSize: 60),
                      ),
                    ],
                  ),
                  const SizedBox(width: 16,),
                  _getWindControl(),
                  const SizedBox(width: 16,),
                  _getHumidityControl(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _getWindControl() {
    return Container(
      padding: const EdgeInsets.only(top: 8, bottom: 8, left: 8, right: 24),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Wind', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300),),
          const SizedBox(height: 4,),
          Text('${forecastDetails.wind.speed.round()}km/h', style: TextStyle(fontWeight: FontWeight.w600),),
        ],
      ),
    );
  }

  Widget _getHumidityControl() {
    return Container(
      padding: const EdgeInsets.only(top: 8, bottom: 8, left: 8, right: 24),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Humidity', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300),),
          const SizedBox(height: 4,),
          Text('${forecastDetails.forecastMainInfo.humidity}%', style: TextStyle(fontWeight: FontWeight.w600),),
        ],
      ),
    );
  }
}
