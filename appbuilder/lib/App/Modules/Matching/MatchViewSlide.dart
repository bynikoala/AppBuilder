import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nsome/App/Design/MaterialLoader.dart';
import 'package:nsome/App/Design/Dimensions.dart';

import '../Design/CorporateColors.dart';
import 'Match.dart';
import 'MatchPresenter.dart';
import 'MeetPersonPopup.dart';

class MatchView extends StatefulWidget {
  const MatchView({Key key, @required this.currentUser, @required this.colors}) : super(key: key);
  final FirebaseUser currentUser;
  final CorporateColors colors;

  @override
  _MatchViewState createState() => _MatchViewState();
}

class _MatchViewState extends State<MatchView> {
  Dimensions dim;
  CorporateColors cc;

  MatchPresenter _matchLogic;
  Future<List<Widget>> _matchList;

  int _currentSlide;
  int _slideCount;

  @override
  void initState() {
    super.initState();

    // inital load
    _matchLogic = MatchPresenter();
    _matchList = updateAndGetMatchList();
    cc = widget.colors;
  }

  void refreshList() {
    setState(() {
      _matchList = updateAndGetMatchList();
    });
  }

  @override
  Widget build(BuildContext context) {
    dim = Dimensions(context);

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.35, 1.0],
            colors: [cc.grad1, cc.grad2],
          ),
        ),
        child: Stack(
          children: <Widget>[
//            Column(
//              mainAxisAlignment: MainAxisAlignment.end,
//              children: <Widget>[
//                Image.asset(
//                  "lib/assets/backgrounds/nsome.png",
//                  alignment: Alignment.center,
//                  fit: BoxFit.none,
//                ),
//              ],
//            ),
            FutureBuilder<List<Widget>>(
              future: _matchList,
              builder: (context, AsyncSnapshot<List<Widget>> matchList) {
                if (matchList.connectionState == ConnectionState.waiting) {
                  return MaterialLoader().viewLoader(cc, 'Matches werden geladen...', dim);
                } else if (matchList.connectionState == ConnectionState.done && matchList.hasData) {
                  return Container(
                    child: Column(
                      children: <Widget>[
                        dim.vMid(),
                        Text(
                          'Treffe jetzt interessante Leute!',
                          style: TextStyle(fontSize: 20),
                          textAlign: TextAlign.center,
                        ),
                        Container(
                          margin: EdgeInsets.all(dim.vBigSpace),
                          child: Text(
                            'Tippe einfach auf eine Person, schau dir Ihr Profil an und entscheide ob du Sie kennenlernen möchtest.',
                            style: TextStyle(fontSize: 16),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        // Dotted indicator
                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List<Widget>.generate(
                              _slideCount,
                              (index) => Container(
                                width: dim.hSmallSpace,
                                height: dim.hSmallSpace,
                                margin: EdgeInsets.symmetric(vertical: dim.vSmall().height, horizontal: dim.hTiny().width),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: _currentSlide == index ? cc.dotAc : cc.dotIn,
                                ),
                              ),
                            ),
                          ),
                        ),
                        dim.vSmall(),
                        CarouselSlider(
                          height: dim.cardHeight,
                          items: matchList.data,
                          enlargeCenterPage: true,
                          onPageChanged: (index) {
                            setState(() {
                              _currentSlide = index;
                            });
                          },
                        ),
                      ],
                    ),
                  );
                } else {
                  // Handle errors while connecting
                  if (matchList.hasError) print('Error while loading Matches: ${matchList.error}');
                  return InkWell(
                    onTap: () => setState(() {}),
                    child: Padding(
                      padding: EdgeInsets.all(dim.vBigSpace),
                      child: Center(
                        child: Text("Fehler. Tippen um zu wiederholen."),
                      ),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  // load contacts
  Future<List<Widget>> updateAndGetMatchList() async {
    _matchLogic.list.clear();
    await _matchLogic.loadMatchesIntoList(widget.currentUser);
    List<Widget> matchWidgetList = new List<Widget>();
    _matchLogic.list.forEach((match) => {matchWidgetList.add(getCardForMatch(match))});

    _slideCount = matchWidgetList.length;
    return matchWidgetList;
  }

  Widget getCardForMatch(Match match) {
    return Card(
      color: cc.cardBck,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(dim.midRadius))),
      elevation: 5,
      // BUTTON FUNCTIONALITY
      child: InkWell(
        borderRadius: BorderRadius.only(topRight: Radius.circular(dim.midRadius), bottomRight: Radius.circular(dim.midRadius)),
        splashColor: match.accountType > 0 ? cc.cardInkP : cc.cardInk,
        highlightColor: match.accountType > 0 ? cc.cardInkP : cc.cardInk,
        onTap: () => MeetPersonPopup().popupBuilder(context, match, cc),
        onLongPress: () {}, // TODO: Match-Menu -> Block, report?
        // CONTENT
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    // TODO: Accounttyp in matchliste visualisieren - ['accountType']
                    match.photoUrl != ""
                        ? CachedNetworkImage(
                            imageUrl: match.photoUrl,
                            width: dim.pictureMid,
                            height: dim.pictureMid,
                            fit: BoxFit.contain,
                            placeholder: (context, url) => Container(
                              width: dim.pictureMid,
                              height: dim.pictureMid,
                              padding: EdgeInsets.all(dim.vMidSpace),
                              child: CircularProgressIndicator(
                                strokeWidth: 2.0,
                                valueColor: AlwaysStoppedAnimation<Color>(cc.circPrIn),
                              ),
                            ),
                          )
                        : Container(
                            child: SvgPicture.asset(
                              match.getAsset(),
                              width: dim.pictureMid,
                            ),
                          ),
                    Positioned(
                      top: 0,
                      right: 0,
                      child: Container(
                        decoration: new BoxDecoration(
                          color: Colors.white38,
                          borderRadius: new BorderRadius.only(
                            bottomLeft: Radius.circular(dim.smallRadius),
                          ),
                        ),
                        child: Text(" " + match.points.toString()),
                      ),
                    ),
                  ],
                ),
                dim.hSmall(),
                Stack(
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text(
                              '${match.name.toString()}${match.age != null && match.age != 0 ? ", " + match.age.toString() : ""}',
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                        dim.vSmall(),
                        getCardLine(Icons.short_text, match.bio),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.all(dim.vMidSpace),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  getCardLine(Icons.business, match.company),
                  dim.newLine(),
                  getCardLine(Icons.business_center, match.sector),
                  dim.newLine(),
                  getCardLine(Icons.work, match.department),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getCardLine(IconData icon, String content) {
    return Row(
      children: <Widget>[
        Icon(icon, color: cc.iconPrim, size: 16),
        dim.iconText(),
        content != null && content.isNotEmpty
            ? Text(content.toString(), overflow: TextOverflow.clip, style: TextStyle(fontSize: 14))
            : Text('Nicht angegeben', style: TextStyle(fontSize: 14, color: cc.textOff))
      ],
    );
  }
}
