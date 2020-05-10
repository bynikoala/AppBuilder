import 'package:appbuilder/App/Design/AppColors.dart';
import 'package:appbuilder/App/Design/AppDimensions.dart';
import 'package:flutter/material.dart';

class AppNavigator extends StatefulWidget {
  final AppColors ac;
  final AppDimensions ad;
  AppNavigator(this.ac, this.ad);

  @override
  _AppNavigatorState createState() => _AppNavigatorState();
}

class _AppNavigatorState extends State<AppNavigator> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.account_circle),
              iconSize: 30,
              onPressed: () => {
                print('AppButton')
              },
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
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Text('Guten Morgen'),
            )
          ],
        )
      ),
    );
  }
}
