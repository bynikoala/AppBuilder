import 'package:flutter/material.dart';

import 'App/Design/AppDimensions.dart';
import 'App/Design/AppColors.dart';
import 'App/AppNavigator.dart';

AppColors ac = AppColors('');
AppDimensions ad;

void main() {
  runApp(AppBuilder());
}

class AppBuilder extends StatelessWidget {
  @override
  Widget build(context) {

    return MaterialApp(
      title: 'AppBuilder',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: AppNavigator(ac, ad),
    );
  }
}