import 'package:flutter/material.dart';

class ErrorView extends StatelessWidget {
  final Function onRetry;

  const ErrorView({this.onRetry});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset('assets/images/logo.png', width: 64, height: 64, color: Colors.blueGrey,),
          const SizedBox(height: 8,),
          Text('OOPS! something went wrong, please try again.', textAlign: TextAlign.center, style: TextStyle(fontSize: 16),),
          const SizedBox(height: 8,),
          FlatButton(
            child: Text('Retry'),
            onPressed: () {
            if (onRetry != null)
              onRetry();
          },),
        ],
      ),
    );
  }
}
