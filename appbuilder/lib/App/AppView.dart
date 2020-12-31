import 'package:appbuilder/App/Design/AppColors.dart';
import 'package:appbuilder/App/Design/AppDimensions.dart';
import 'package:flutter/material.dart';

import 'AppController.dart';
import 'CustomWidgets/CustomError.dart';
import 'CustomWidgets/LoginHandler.dart';
import 'Settings/GlobalSettings.dart';

class AppView extends StatefulWidget {
  final AppController _controller;

  AppView(this._controller);

  @override
  _AppViewState createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  AppColors ac;
  AppDimensions ad;

  List<String> auth;
  String logo;

  List<BottomNavigationBarItem> menuItems;
  int pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    ad = AppDimensions(context);
    ac = AppColors(GlobalSettings.getConfig().color);
    GlobalSettings.setDesign(ad, ac);
    logo = GlobalSettings.getConfig().logo;

    auth = GlobalSettings.getConfig().auth;

    menuItems = (GlobalSettings.getConfig().modules
        .map((item) => BottomNavigationBarItem(
              label: item.toString(),
              backgroundColor: ac.primary,
              icon: Icon(Icons.stream),
            ))
        .toList());



    return FutureBuilder(
      future: widget._controller.loggedIn,
      builder: (context, as) {
        if (as.hasError)
          return CustomError(() {
            setState(() {});
          });

        if (!as.hasData) return Center(child: CircularProgressIndicator());

        if (as.data) {
          widget._controller.loginSilent();
          return getAppFrame();
        } else {
          return getLoginMask(LoginHandler(GlobalSettings.getAuth()));
        }
      },
    );
  }

  Widget getLoginMask(LoginHandler loginForm) {
    return Scaffold(
      backgroundColor: ac.primary,
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: auth == null
              ? [
                  Center(
                    child: Text('Not Authentication specified'),
                  )
                ]
              : [
                  Center(
                      child: Image.asset(
                    "lib/Assets/" + logo,
                  )),
                  if (auth.contains('Google'))
                    Center(
                      child: loginForm.getGoogleLoginButton(
                        text: 'Mit Google einloggen',
                        imagePath: "lib/Assets/Login/google_logo.png",
                        color: Colors.black,
                        onSuccess: (user) {
                          setState(() {
                            widget._controller.login(user);
                          });
                        },
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
                ],
        ),
      ),
    );
  }

  Widget getAppFrame() {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ac.primary,
        title: Row(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.account_circle),
              iconSize: 30,
              onPressed: () => {print('AppButton')},
            ),
            SizedBox(width: 10),
            Text(GlobalSettings.getConfig().name),
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
      body: widget._controller.getPages()[pageIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: ac.primary,
        selectedItemColor: ac.standardBackground,
        unselectedItemColor: ac.alternateBackground,
        items: menuItems,
        currentIndex: pageIndex,
        onTap: ((newIndex) {
          setState(() {
            pageIndex = newIndex;
          });
        }),
      ),
    );
  }
}
