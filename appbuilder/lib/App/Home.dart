import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
