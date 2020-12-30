import 'package:appbuilder/App/Design/AppColors.dart';
import 'package:appbuilder/App/Design/AppDimensions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'Model/Match.dart';

class MeetPersonPopup {
  MeetPersonPopup();

  BuildContext context;
  Match match;

  double titleSize = 1.5;

  popupBuilder(BuildContext context, Match match, AppColors ac, AppDimensions ad) {
    this.context = context;
    String id = match.id;
    String name = match.name;
    String photoUrl = match.photoUrl;
    int age = match.age;
    String bio = match.bio;
    int points = match.points;
    int accountType = match.accountType;

    // Popup title
    String title = name + " treffen?";
    if (title.length >= 25) titleSize = 1;

    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              backgroundColor: ac.popBack,
              content: Form(
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: <Widget>[
                ad.vBig(),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
                  //Icon(Icons.person_add, size: 40, color: Theme.of(context).primaryColor,),ad.hBig(),
                  Text(
                    title,
                    textScaleFactor: titleSize,
                    style: TextStyle(color: ac.popText),
                  )
                ]),
                ad.vBig(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    match.photoUrl != ""
                        ? CachedNetworkImage(
                            imageUrl: photoUrl,
                            // TODO: Accounttyp in matchliste visualisieren - ['accountType']
                            width: MediaQuery.of(context).size.width * 0.25,
                            height: MediaQuery.of(context).size.width * 0.25,
                            fit: BoxFit.contain,
                            placeholder: (context, url) => Container(
                                width: MediaQuery.of(context).size.width * 0.25,
                                height: MediaQuery.of(context).size.width * 0.25,
                                padding: EdgeInsets.all(20.0),
                                child: CircularProgressIndicator(
                                  strokeWidth: 2.0,
                                  valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
                                )))
                        : Container(
                    ), //TODO: standardpic
                    ad.vSmall(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(children: <Widget>[
                          Text(name, style: TextStyle(color: ac.popText, fontSize: 19)),
                        ]),
                        ad.vMid(),
                        Row(children: <Widget>[
                          Icon(Icons.cake, color: ac.popIcon, size: 20),
                          ad.hBig(),
                          age != null && age != 0
                              ? Text(age.toString(), style: TextStyle(color: ac.popText, fontSize: 14))
                              : Text('Nicht angegeben', style: TextStyle(color: ac.popTextIn, fontSize: 14)),
                        ]),
                        ad.vSmall(),
                        Row(children: <Widget>[
                          Icon(Icons.location_on, color: ac.popIcon, size: 20),
                          ad.hBig(),
                          Text('Wiesbaden', style: TextStyle(color: ac.popText, fontSize: 14))
                        ])
                      ],
                    )
                  ],
                ),
                ad.vBig(),
                ad.vBig(),
                Text('Status:', style: TextStyle(color: ac.popText, fontSize: 12)),
                ad.vSmall(),
                Row(children: <Widget>[
                  Icon(Icons.short_text, color: ac.popIcon, size: 20),
                  ad.hSmall(),
                  Text(bio.toString(), style: TextStyle(color: ac.popText)),
                ]),
                ad.vBig(),
                ad.vSmall(),
                ad.vBig(),
                ad.vBig(),
                Center(
                    child: MaterialButton(
                        color: ac.popIcon,
                        onPressed: () {
                          _meetPerson();
                        },
                        child: Text('Kontakt Treffen', style: TextStyle(color: ac.popText)))),
                ad.vBig()
              ])));
        });
  }

  _meetPerson() {
    /**
     * TODO: Some Backend-stuff
     */
    Navigator.of(context, rootNavigator: true).pop('dialog');
    Fluttertoast.showToast(msg: 'Anfrage erfolgreich');
  }
}
