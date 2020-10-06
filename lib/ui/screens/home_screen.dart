import 'package:flutter/material.dart';
import 'package:windy/blocs/weather_bloc.dart';
import 'package:windy/constants.dart';
import 'package:windy/models/forecast/forecast.dart';
import 'package:windy/ui/widgets/error_view.dart';
import 'package:windy/ui/widgets/stateful_wrapper.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: StatefulWrapper(
          onInit: () {
            weatherBloc.getForecast(regionId: DUBAI_FORECAST_ID);
          },
          child: StreamBuilder(
            stream: weatherBloc.forecast,
            builder: (context, AsyncSnapshot<Forecast> snapshot) {
                if (snapshot.hasError || (snapshot.hasData && snapshot.data.error != null))
                  return Center(child: ErrorView(onRetry: () => weatherBloc.getForecast(regionId: DUBAI_FORECAST_ID)));
                else if (snapshot.hasData) {
                  return Container();
                } else {
                  return Center(child: CircularProgressIndicator());
                }
            },
          ),
        ),
      ),
    );
  }
}
