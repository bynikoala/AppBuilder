import 'package:appbuilder/App/Design/AppColors.dart';
import 'package:appbuilder/App/Design/AppDimensions.dart';
import 'package:appbuilder/App/Modules/Matching/MatchController.dart';
import 'package:appbuilder/App/NikusWidgets/NikusError.dart';
import 'package:appbuilder/App/NikusWidgets/NikusLogin.dart';
import 'package:flutter/material.dart';

import 'AppController.dart';
import 'Modules/Contacts/ContactListController.dart';
import 'Modules/Map/MapController.dart';
import 'Modules/News/NewsController.dart';
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

  Map<String, Function()> classFactory;

  List<BottomNavigationBarItem> menuItems;
  int pageIndex = 0;
  List<Object> pages;

  @override
  Widget build(BuildContext context) {
    ad = AppDimensions(context);
    ac = AppColors(GlobalSettings.getConfig()['color'][0]);
    logo = GlobalSettings.getConfig()['logo'][0];

    auth = GlobalSettings.getConfig()['auth'];

    classFactory = {
      'Map': () => new MapController(),
      'Matching': () => new MatchController(),
      'ContactList': () => new ContactListController(),
      'News': () => new NewsController(),
    };

    menuItems = (GlobalSettings.getConfig()['modules']
        .map((item) => BottomNavigationBarItem(
              label: item.toString(),
              backgroundColor: ac.primary,
              icon: Icon(Icons.stream),
            ))
        .toList());
    pages = (GlobalSettings.getConfig()['modules']
        .map((item) => classFactory[item])
        .toList());

    return FutureBuilder(
      future: widget._controller.loggedIn,
      builder: (context, as) {
        if (as.hasError)
          return NikusError(() {
            setState(() {});
          });

        if (!as.hasData) return Center(child: CircularProgressIndicator());

        if (as.data) {
          return getAppFrame();
        } else {
          return getLoginMask(NikusLogin(GlobalSettings.getAuth()));
        }
      },
    );
  }

  Widget getLoginMask(NikusLogin loginForm) {
    return Scaffold(
      backgroundColor: Colors.purple,
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: auth == null
              ? [
                  Center(
                    child: Text('Lets go'),
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
            Text(GlobalSettings.getConfig()['name'][0]),
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
      body: getPage(),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: ac.primary,
        selectedItemColor: ac.standardBackground,
        unselectedItemColor: ac.alternateBackground,
        items: menuItems,
        currentIndex: pageIndex,
      ),
    );
  }

  getPage() {}
}
