import 'package:flutter/material.dart';
import 'package:windy/blocs/weather_bloc.dart';
import 'package:windy/constants.dart';
import 'package:windy/models/forecast/forecast.dart';
import 'package:windy/ui/widgets/error_view.dart';
import 'package:windy/ui/widgets/items/day_item.dart';
import 'package:windy/ui/widgets/stateful_wrapper.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: StatefulWrapper(
          onInit: () {
            weatherBloc.getForecast(regionId: DUBAI_FORECAST_ID);
          },
          child: StreamBuilder(
            stream: weatherBloc.forecast,
            builder: (context, AsyncSnapshot<Forecast> snapshot) {
                if (snapshot.hasError || (snapshot.hasData && snapshot.data.error != null))
                  return Center(child: ErrorView(onRetry: () => weatherBloc.getForecast(regionId: DUBAI_FORECAST_ID)));
                else if (snapshot.hasData) {
                  var groupedDetails = snapshot.data.groupDetailsByDay();
                  return ListView(
                    physics: BouncingScrollPhysics(),
                    padding: const EdgeInsets.all(16),
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(snapshot.data.city.name, style: TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),),
                          const SizedBox(width: 8,),
                          Image.asset('assets/images/logo.png', width: 64, height: 64,)
                        ],
                      ),
                      const SizedBox(height: 18,),
                      GridView.builder(
                        shrinkWrap: true,
                        physics: BouncingScrollPhysics(),
                        itemCount: groupedDetails.length,
                        itemBuilder: (context, index) {
                          var date = groupedDetails.keys.toList()[index];
                          var details = groupedDetails.values.toList()[index][0];

                          return DayItem(date: date, forecastDetails: details, city: snapshot.data.city.name,);
                        },
                        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 200,
                          childAspectRatio: 1,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                        ),
                      ),
                    ],
                  );
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
