import 'package:appbuilder/App/Design/AppColors.dart';
import 'package:appbuilder/App/Design/AppDimensions.dart';
import 'package:appbuilder/App/NikusWidgets/NikusLogin.dart';
import 'package:flutter/material.dart';

class AppNavigator extends StatefulWidget {
  final AppColors ac;
  final AppDimensions ad;
  final Map<String, Object> config;

  AppNavigator(this.ac, this.ad, this.config);

  @override
  _AppNavigatorState createState() => _AppNavigatorState();
}

class _AppNavigatorState extends State<AppNavigator> {
  NikusLogin loginForm;

  @override
  Widget build(BuildContext context) {
    loginForm = NikusLogin(shape: 2);
    List<String> auth = widget.config['auth'];

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
              auth == null
                  ? {
                      if (auth.contains('Google'))
                        Center(
                          child: loginForm.getGoogleLoginButton(
                            text: 'Mit Google einloggen',
                            imagePath: "lib/Assets/Login/google_logo.png",
                            onSuccess: (user) => {},
                          ),
                        ),
                      if (auth.contains('Facebook'))
                        Center(
                          child: Text('Facebook'),
                        ),
                      if (auth.contains('Mail'))
                        Center(
                          child: Text('Mail/PW'),
                        ),
                    }
                  : Center(
                      child: Text('Lets go'),
                    )
            ],
          )),
    );
  }
}
