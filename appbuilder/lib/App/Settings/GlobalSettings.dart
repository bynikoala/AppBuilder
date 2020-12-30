import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GlobalSettings {
  static SharedPreferences _prefs;
  static User _user;
  static FirebaseAuth _auth;
  static CollectionReference _store;
  static Map<String, List<String>> _config;
  static AppDimensions ad;

  static Future<bool> init(Map<String, List<String>> config) async {
    try {
      _config = config;
      await Firebase.initializeApp(); // Sets a default Firebase-Project
      _store = FirebaseFirestore.instance.collection(_config['slug'][0]); // Initialize the database
      _prefs = await SharedPreferences.getInstance(); // Loads the local Device-Settings for the app
      _auth = FirebaseAuth.instance; // Inititalizes the Firebase-Authentication

      return _prefs.getBool("loggedIn") ?? false;
    } catch (e) {
      print(e);
      return false;
    }
  }

  static Map<String, List<String>> getConfig() => _config;
  static FirebaseAuth getAuth() => _auth;
  static CollectionReference getStore() => _store;

  static User getUser() => _user;

  static login(User user) {
    _user = user;
    _prefs.setBool('loggedIn', true);
  }

  static logout() {
    _prefs.setBool('loggedIn', false);
  }
}