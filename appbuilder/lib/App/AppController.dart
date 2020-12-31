import 'package:appbuilder/Config.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'AppView.dart';
import 'Modules/Contacts/ContactListController.dart';
import 'Modules/Map/MapController.dart';
import 'Modules/Matching/MatchController.dart';
import 'Modules/News/NewsController.dart';
import 'Settings/GlobalSettings.dart';

class AppController {
  BuildContext context;
  Config _config;
  AppView _av;

  Map<String, Widget> modules = {
    'Map': MapController().getView(),
    'Matching': MatchController().getView(),
    'ContactList': ContactListController().getView(),
    'News': NewsController().getView(),
  };


  Future<bool> loggedIn;


  AppController(this.context, this._config) {
    loggedIn = GlobalSettings.init(_config); // initialize the App-Settings
    _av = AppView(this);
  }

  Widget getFrame() => _av;

  login(User user) {
    GlobalSettings.login(user);
  }

  getPages() => (GlobalSettings.getConfig().modules
      .map((item) => modules[item])
      .toList());
}