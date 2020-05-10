import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nsome/App/Design/CorporateColors.dart';
import 'Match.dart';

class MeetPersonPopup {
  MeetPersonPopup();
  BuildContext context;
  Match match;

  double titleSize = 1.5;

  popupBuilder(BuildContext context, Match match, CorporateColors cc) {
    this.context = context;
    String id = match.id;
    String name = match.name;
    String photoUrl = match.photoUrl;
    int age = match.age;
    String bio = match.bio;
    String company = match.company;
    String sector = match.sector;
    String department = match.department;
    int points = match.points;
    int accountType = match.accountType;

    // Popup title
    String title = name + " treffen?";
    if (title.length >= 25) titleSize = 1;

    showDialog(
        context: context,
        builder: (context) {
          //TODO: spacer ersetzen
          var vDivSm = SizedBox(height: ScreenUtil().setHeight(15));
          var vDivBig = SizedBox(height: ScreenUtil().setHeight(30));
          var hDivSm = SizedBox(width: ScreenUtil().setWidth(15));
          var hDivBig = SizedBox(width: ScreenUtil().setWidth(30));

          return AlertDialog(
              backgroundColor: cc.popBack,
              content: Form(
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: <Widget>[
                vDivBig,
                Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
                  //Icon(Icons.person_add, size: 40, color: Theme.of(context).primaryColor,),hDivBig,
                  Text(
                    title,
                    textScaleFactor: titleSize,
                    style: TextStyle(color: cc.popText),
                  )
                ]),
                vDivBig,
                vDivBig,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    match.photoUrl != ""
                        ? CachedNetworkImage(
                        imageUrl: photoUrl, // TODO: Accounttyp in matchliste visualisieren - ['accountType']
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
                        child: SvgPicture.asset(
                          match.getAsset(),
                          width: MediaQuery.of(context).size.width * 0.3,
                        )),
                    hDivSm,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(children: <Widget>[
                          Text(name, style: TextStyle(color: cc.popText, fontSize: 19)),
                        ]),
                        vDivSm,
                        vDivSm,
                        Row(children: <Widget>[
                          Icon(Icons.cake, color: cc.popIcon, size: 20),
                          hDivBig,
                          age != null && age != 0
                              ? Text(age.toString(), style: TextStyle(color: cc.popText, fontSize: 14))
                              : Text('Nicht angegeben', style: TextStyle(color: cc.popTextIn, fontSize: 14)),
                        ]),
                        vDivSm,
                        Row(children: <Widget>[
                          Icon(Icons.location_on, color: cc.popIcon, size: 20),
                          hDivBig,
                          Text('Wiesbaden', style: TextStyle(color: cc.popText, fontSize: 14))
                        ])
                      ],
                    )
                  ],
                ),
                vDivBig,
                vDivBig,
                Text('Status:', style: TextStyle(color: cc.popText, fontSize: 12)),
                vDivSm,
                Row(children: <Widget>[
                  Icon(Icons.short_text, color: cc.popIcon, size: 20),
                  hDivSm,
                  Text(bio.toString(), style: TextStyle(color: cc.popText)),
                ]),
                vDivBig,
                vDivSm,
                Text('Unternehmen:', style: TextStyle(color: cc.popText, fontSize: 12)),
                vDivSm,
                Row(children: <Widget>[
                  Icon(Icons.business, color: cc.popIcon, size: 20),
                  hDivSm,
                  company != null && company.isNotEmpty
                      ? Text(company.toString(), style: TextStyle(color: cc.popText))
                      : Text('Nicht angegeben', style: TextStyle(color: cc.popTextIn))
                ]),
                vDivBig,
                Text('Branche:', style: TextStyle(color: Theme.of(context).backgroundColor, fontSize: 12)),
                vDivSm,
                Row(children: <Widget>[
                  Icon(Icons.business_center, color: cc.popIcon, size: 20),
                  hDivSm,
                  sector != null && sector.isNotEmpty
                      ? Text(sector.toString(), style: TextStyle(color: cc.popText))
                      : Text('Nicht angegeben', style: TextStyle(color: cc.popTextIn))
                ]),
                vDivBig,
                Text('Abteilung:', style: TextStyle(color: cc.popText, fontSize: 12)),
                vDivSm,
                Row(children: <Widget>[
                  Icon(Icons.work, color: cc.popIcon, size: 20),
                  hDivSm,
                  department != null && department.isNotEmpty
                      ? Text(department.toString(), style: TextStyle(color: cc.popText))
                      : Text('Nicht angegeben', style: TextStyle(color: cc.popTextIn)),
                ]),
                vDivBig,
                vDivBig,
                vDivBig,
                vDivBig,
                Center(
                    child: MaterialButton(
                        color: cc.popIcon,
                        onPressed: () {
                          _meetPerson();
                        },
                        child: Text('Kontakt Treffen', style: TextStyle(color: cc.popText)))),
                vDivBig
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
