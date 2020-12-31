import 'package:appbuilder/App/Design/AppColors.dart';
import 'package:appbuilder/App/Design/AppDimensions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Config.dart';

class GlobalSettings {
  static SharedPreferences _prefs;
  static User _user;
  static FirebaseAuth _auth;
  static CollectionReference _store;
  static Config _config;
  static AppDimensions ad;
  static AppColors ac;

  static Future<bool> init(Config config) async {
    try {
      _config = config;
      await Firebase.initializeApp(); // Sets a default Firebase-Project
      _store = FirebaseFirestore.instance.collection(_config.bucket); // Initialize the database
      _prefs = await SharedPreferences.getInstance(); // Loads the local Device-Settings for the app
      _auth = FirebaseAuth.instance; // Inititalizes the Firebase-Authentication

      if(loggedIn()) {

        return true;
      }

      return false;
    } catch (e) {
      print(e);
      return false;
    }
  }

  static setDesign(_ad, _ac) {
    ad = _ad;
    ac = _ac;
  }

  static Config getConfig() => _config;
  static FirebaseAuth getAuth() => _auth;
  static CollectionReference getStore() => _store;
  static User getUser() => _user;

  static bool loggedIn() => _prefs.getBool("loggedIn") && _auth.currentUser != null ?? false;

  // Login User and Save settings
  static login(User user) {
    _prefs.setBool('loggedIn', true);
    _user = user;
  }
  static loginSilent() {
    _user = _auth.currentUser;
  }

  static logout() {
    _prefs.setBool('loggedIn', false);
  }
}