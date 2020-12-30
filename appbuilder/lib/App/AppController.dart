import 'package:appbuilder/Config.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'AppView.dart';
import 'Settings/GlobalSettings.dart';

class AppController {
  BuildContext context;
  Config _config;
  AppView _av;

  Future<bool> loggedIn;


  AppController(this.context, this._config) {
    loggedIn = GlobalSettings.init(_config); // initialize the App-Settings
    _av = AppView(this);
  }

  Widget getFrame() => _av;

  login(User user) {
    GlobalSettings.login(user);
  }
}