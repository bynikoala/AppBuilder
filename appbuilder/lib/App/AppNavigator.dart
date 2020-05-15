import 'package:appbuilder/App/Design/AppColors.dart';
import 'package:appbuilder/App/Design/AppDimensions.dart';
import 'package:appbuilder/App/NikusWidgets/NikusLogin.dart';
import 'package:flutter/material.dart';

class AppNavigator extends StatefulWidget {
  final AppColors ac;
  final AppDimensions ad;

  AppNavigator(this.ac, this.ad);

  @override
  _AppNavigatorState createState() => _AppNavigatorState();
}

class _AppNavigatorState extends State<AppNavigator> {
  NikusLogin loginForm;

  @override
  Widget build(BuildContext context) {
    loginForm = NikusLogin();

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.account_circle),
              iconSize: 30,
              onPressed: () => {print('AppButton')},
            ),
            SizedBox(width: 10),
            Text('AppBuilder (AEOM)'),
          ],
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.settings),
            iconSize: 25,
            onPressed: () => {},
          ),
          IconButton(
            icon: Icon(Icons.message),
            iconSize: 25,
            onPressed: () => {},
          )
        ],
      ),
      body: Container(
          color: Colors.black,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Center(
                child: loginForm.getGoogleLoginButton(
                  text: 'Mit Google einloggen',
                  imagePath: "lib/Assets/Login/google_logo.png",
                  onSuccess: (user) => {},
                ),
              )
            ],
          )),
    );
  }
}
