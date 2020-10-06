import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:windy/models/forecast/forecast.dart';
import 'package:windy/ui/screens/weather_day_details_screen.dart';
import 'package:windy/utils/extensions.dart';

class DayItem extends StatelessWidget {
  final DateTime date;
  final ForecastDetails forecastDetails;
  final String city;

  const DayItem({@required this.date, @required this.forecastDetails, @required this.city});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
      Navigator.of(context).push(MaterialPageRoute<void>(
        builder: (BuildContext context) => WeatherDayDetailsScreen(forecastDetails: forecastDetails, city: city,)));
      },
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        padding: const EdgeInsets.all(15),
        child: Stack(
          children: [
            Align(
              alignment: AlignmentDirectional.topStart,
              child: Text(
                date.day == DateTime.now().day ? 'Today' : DateFormat('dd MMMM').format(date),
                style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),
            Align(
              alignment: AlignmentDirectional.center,
              child: Image.asset(
                forecastDetails.weatherList[0].getWeatherImageName(),
                width: 80,
                height: 80,
              ),
            ),
            Align(
              alignment: AlignmentDirectional.bottomCenter,
              child: Text(
                forecastDetails.weatherList[0].description.capitalizeFirstLitter(),
                style: TextStyle(color: Colors.black, fontSize: 18),
              ),
            ),
          ],
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              forecastDetails.weatherList[0].getWeatherColor().withOpacity(0.7),
              forecastDetails.weatherList[0].getWeatherColor(),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}
