import 'package:appbuilder/App/Design/AppColors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'Model/Match.dart';
import 'MatchController.dart';
import 'MeetPersonPopup.dart';

class MatchView extends StatefulWidget {
  const MatchView({Key key, @required this.currentUser}) : super(key: key);
  final FirebaseUser currentUser;

  @override
  _MatchViewState createState() => _MatchViewState();
}

class _MatchViewState extends State<MatchView> with AutomaticKeepAliveClientMixin {
  AppColors cc = AppColors('');

  MatchController _matchLogic = MatchController();
  MeetPersonPopup meetPopup = MeetPersonPopup();
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Stack(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Image.asset("lib/assets/backgrounds/nsome.png", alignment: Alignment.center, fit: BoxFit.none),
            ],
          ),
          Scrollbar(
            child: ListView(
              children: <Widget>[],
            ),
          ),
          FutureBuilder(
              future: getMatchList(),
              builder: (context, AsyncSnapshot<List<Widget>> matchList) {
                return matchList.connectionState == ConnectionState.done
                    ? matchList.hasData
                        ? Container(
                            margin: EdgeInsets.fromLTRB(midSpacerW, ScreenUtil().setHeight(60), midSpacerW, ScreenUtil().setHeight(20)),
                            child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: <Widget>[
                              Text(
                                'Treffe jetzt interessante Leute!',
                                style: TextStyle(fontSize: 20),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: 40),
                              Text(
                                'Tippe einfach auf eine Person, schau dir Ihr Profil an und entscheide ob du Sie kennenlernen möchtest.',
                                style: TextStyle(fontSize: 16),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: 30),
                              Expanded(
                                child: GestureDetector(
                                    onTap: () => meetPopup.popupBuilder(context, _matchLogic.list[1], cc),
                                    child: ListWheelScrollView(
                                      itemExtent: 132,
                                      controller: FixedExtentScrollController(initialItem: 2),
                                      perspective: 0.0007,
                                      children: matchList.data,
                                    )),
                              )
                            ]))
                        : InkWell(
                            onTap: () => setState(() {}),
                            child: Padding(
                              padding: const EdgeInsets.all(32.0),
                              child: Center(
                                child: Text("Fehler. Tippen um zu wiederholen."),
                              ),
                            ),
                          )
                    : Center(
                        child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          CircularProgressIndicator(backgroundColor: Colors.black12, valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor)),
                          midSpacerH,
                          Text('Matches werden geladen...')
                        ],
                      ));
              }),
        ],
      ),
    );
  }

  // load contacts
  Future<List<Widget>> getMatchList() async {
    _matchLogic.list.clear();
    await _matchLogic.loadMatchesIntoList(widget.currentUser);
    List<Widget> matchWidgetList = new List<Widget>();
    _matchLogic.list.forEach((match) => {matchWidgetList.add(getCardForMatch(match))});

    return matchWidgetList;
  }

  Widget getCardForMatch(Match match) {
    var age = match.age;
    var sector = match.sector;
    var company = match.company;

    return Card(
        // color: Theme.of(context).backgroundColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topRight: Radius.circular(20.0), bottomRight: Radius.circular(20.0))),
        elevation: 5,
        // BUTTON FUNCTIONALITY
        child: InkWell(
            borderRadius: BorderRadius.only(topRight: Radius.circular(20.0), bottomRight: Radius.circular(20.0)),
            splashColor: match.accountType > 0 ? Color(0x20FF9933) : Color(0x10000000),
            highlightColor: match.accountType > 0 ? Color(0x20FF9933) : Color(0x10000000),
            onTap: () => MeetPersonPopup().popupBuilder(context, match, cc),
            onLongPress: () => {},
            // CONTENT
            child: Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
              Stack(children: <Widget>[
                match.photoUrl != ""
                    ? CachedNetworkImage(
                        imageUrl: match.photoUrl, // TODO: Accounttyp in matchliste visualisieren - ['accountType']
                        width: MediaQuery.of(context).size.width * 0.3,
                        height: MediaQuery.of(context).size.width * 0.3,
                        fit: BoxFit.contain,
                        placeholder: (context, url) => Container(
                            width: MediaQuery.of(context).size.width * 0.3,
                            height: MediaQuery.of(context).size.width * 0.3,
                            padding: EdgeInsets.all(20.0),
                            child: CircularProgressIndicator(strokeWidth: 2.0, valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor))))
                    : Container(
                        child: SvgPicture.asset(
                        match.getAsset(),
                        width: MediaQuery.of(context).size.width * 0.3,
                      )),
                Positioned(
                    top: 0,
                    right: 0,
                    child: Container(
                        decoration: new BoxDecoration(color: Colors.white38, borderRadius: new BorderRadius.only(bottomLeft: const Radius.circular(10.0))),
                        padding: EdgeInsets.all(4),
                        child: Text(" " + match.points.toString())))
              ]),
              SizedBox(width: 25),
              Stack(
                children: <Widget>[
                  Positioned(
                      right: 0,
                      bottom: 0,
                      child: Image.asset(
                        "lib/assets/backgrounds/nsome-r.png",
                      )),
                  Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: 10),
                        Row(children: <Widget>[Text('${match.name.toString()}${age != null && age != 0 ? ", " + age.toString() : ""}', style: TextStyle(fontSize: 16))]),
                        SizedBox(height: 2),
                        Row(children: <Widget>[
                          Icon(Icons.business, color: Theme.of(context).primaryColor, size: 16),
                          SizedBox(width: 5),
                          company != null && company.isNotEmpty
                              ? Text(company.toString(), style: TextStyle(fontSize: 14))
                              : Text('Nicht angegeben', style: TextStyle(fontSize: 14, color: Colors.black54))
                        ]),
                        SizedBox(height: 0),
                        Row(children: <Widget>[
                          Icon(
                            Icons.work,
                            color: Theme.of(context).primaryColor,
                            size: 16,
                          ),
                          SizedBox(width: 5),
                          sector != null && sector.isNotEmpty
                              ? Text(sector.toString(), style: TextStyle(fontSize: 14))
                              : Text('Nicht angegeben', style: TextStyle(fontSize: 14, color: Colors.black54))
                        ]),
                        SizedBox(height: 0),
                        Row(children: <Widget>[
                          Icon(
                            Icons.short_text,
                            color: Theme.of(context).primaryColor,
                            size: 16,
                          ),
                          SizedBox(width: 5),
                          Text(
                            match.bio.toString(),
                            style: TextStyle(fontSize: 14),
                            overflow: TextOverflow.clip,
                          )
                        ]),
                        SizedBox(height: 10)
                      ])
                ],
              )
            ])));
  }
}
