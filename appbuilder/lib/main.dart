import 'package:appbuilder/App/AppController.dart';
import 'package:flutter/material.dart';
import 'AppConfig.dart';

void main(AppConfig config) {
  AppConfig config = AppConfig(
    name: 'AppBuilder', // AppName
    bucket: 'AppBuilder-WS2020-21',
    theme: 'light', // Changeable Theme
    auth: ['Google'], // Authetication Methods
    modules: ['Map', 'Matching', 'ContactList', 'News'], // Modules for the app
    language: ['de-de', 'en-us'], // Standard language + changeables
    color: 'orange', // Color Scheme for each module or standard
    logo: 'logo.png'
  );
  runApp(AppBuilder(config));
}

class AppBuilder extends StatelessWidget {
  final AppConfig config;

  AppBuilder(this.config);

  @override
  Widget build(context) {
    return MaterialApp(
      title: config.name,
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: AppController(config).getFrame(),
    );
  }
}
