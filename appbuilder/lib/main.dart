import 'package:flutter/material.dart';

import 'App/Design/AppDimensions.dart';
import 'App/Design/AppColors.dart';
import 'App/AppNavigator.dart';

AppColors ac = AppColors('');
AppDimensions ad;

void main(var config) {
  config = {
    'name': 'AppBuilder-Test', // AppName
    'theme': ['light', true], // Changeable Theme
    'auth': ['Google'], // Authetication Methods
    'modules': ['Map', 'Matching', 'ContactList', 'News'], // Modules for the app
    'lang': ['de-de', 'en-us'], // Standard language + changeables
    'color': ['orange'], // Color Scheme for each module or standard
    '': '',
    ' ': '',
  };
  runApp(AppBuilder(config));
}

class AppBuilder extends StatelessWidget {
  final Map<String, Object> config;

  AppBuilder(this.config);

  @override
  Widget build(context) {
    return MaterialApp(
      title: config['name'],
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: AppNavigator(ac, ad, config),
    );
  }
}
