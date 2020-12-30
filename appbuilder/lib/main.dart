import 'package:appbuilder/App/AppController.dart';
import 'package:flutter/material.dart';

void main(var config) {
  Map<String, List<String>> config = {
    'name': ['AppBuilder'], // AppName
    'slug': ['AppBuilder-WS2020-21'],
    'theme': ['light', ''], // Changeable Theme
    'auth': ['Google'], // Authetication Methods
    'modules': ['Map', 'Matching', 'ContactList', 'News'], // Modules for the app
    'lang': ['de-de', 'en-us'], // Standard language + changeables
    'color': ['orange'], // Color Scheme for each module or standard
    'logo': ['logo.png'],
    ' ': [''],
  };
  runApp(AppBuilder(config));
}

class AppBuilder extends StatelessWidget {
  final Map<String, List<String>> config;

  AppBuilder(this.config);

  @override
  Widget build(context) {
    return MaterialApp(
      title: config['name'][0],
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: AppController(context, config).getFrame(),
    );
  }
}
