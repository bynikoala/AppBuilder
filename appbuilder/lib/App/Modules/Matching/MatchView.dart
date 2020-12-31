import 'package:appbuilder/App/CustomWidgets/CustomError.dart';
import 'package:appbuilder/App/CustomWidgets/CustomWidgets.dart';
import 'package:appbuilder/App/Design/AppColors.dart';
import 'package:appbuilder/App/Design/AppDimensions.dart';
import 'package:appbuilder/App/Settings/GlobalSettings.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import '../Contacts/Model/Contact.dart';
import 'MatchController.dart';
import 'MeetPersonPopup.dart';

class MatchView extends StatefulWidget {
  final MatchController _controller;

  MatchView(this._controller);

  @override
  _MatchViewState createState() => _MatchViewState();
}

class _MatchViewState extends State<MatchView> {
  int _currentSlide;
  AppDimensions ad = GlobalSettings.ad;
  AppColors ac = GlobalSettings.ac;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: null,
      body: Container(
        child: StreamBuilder(
          stream: widget._controller.stream,
          builder: (context, AsyncSnapshot<List<Contact>> matches) {
            // Handle Connection Error
            if (matches.hasError) {
              print('Error while loading Matches: ${matches.error} # ${matches.connectionState}');
              return CustomError(() {
                setState(() {});
              }, error: 'Verbindungsfehler');
            }

            switch (matches.connectionState) {
              case ConnectionState.none:
                return CustomError(() {
                  setState(() {});
                }, error: 'Verbindungsfehler');

              case ConnectionState.waiting:
                return CustomWidgets().getViewLoader(ac, 'Matches werden geladen...', ad);

              case ConnectionState.active:
                if (matches.hasData && matches.data.isNotEmpty) {
                  return getContent(matches.data);
                } else {
                  return CustomError(() {
                    setState(() {});
                  }, error: "Noch keine Matches");
                }
                break;
              case ConnectionState.done:
                return CustomError(() {
                  setState(() {});
                }, error: "Noch keine Matches");
            }
            return null;
          },
        ),
      ),
    );
  }

  Center getContent(List<Contact> matches) {
    return Center(
      child: Column(
        children: <Widget>[
          ad.vMid(),
          Text(
            'Treffe jetzt interessante Leute!',
            style: TextStyle(fontSize: 20),
            textAlign: TextAlign.center,
          ),
          Container(
            margin: EdgeInsets.all(ad.vMidSpace),
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
                matches.length,
                    (index) =>
                    Container(
                      width: ad.hTinySpace,
                      height: ad.hTinySpace,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _currentSlide == index ? ac.dotAc : ac.dotIn,
                      ),
                    ),
              ),
            ),
          ),
          ad.vSmall(),
          CarouselSlider(
            options: CarouselOptions(
              height: ad.cardHeight,
              enlargeCenterPage: true,
              onPageChanged: (index, reason) {
                setState(() {
                  _currentSlide = index;
                });
              },
            ),
            items: matches.map((match) => getCardForMatch(match)).toList(),
          ),
        ],
      ),
    );
  }

  Card getCardForMatch(Contact match) {
    if (match.name == null) return null;

    return Card(
      color: ac.cardBck,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(ad.midRadius))),
      elevation: 5,
      // BUTTON FUNCTIONALITY
      child: InkWell(
        borderRadius: BorderRadius.only(topRight: Radius.circular(ad.midRadius), bottomRight: Radius.circular(ad.midRadius)),
        splashColor: match.accountType > 0 ? ac.cardInkP : ac.cardInk,
        highlightColor: match.accountType > 0 ? ac.cardInkP : ac.cardInk,
        onTap: () => MeetPersonPopup().popupBuilder(context, match, ac, ad),
        onLongPress: () {},
        // TODO: Match-Menu -> Block, report?
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
                      width: ad.pictureMid,
                      height: ad.pictureMid,
                      fit: BoxFit.contain,
                      placeholder: (context, url) =>
                          Container(
                            width: ad.pictureMid,
                            height: ad.pictureMid,
                            padding: EdgeInsets.all(ad.vMidSpace),
                            child: CircularProgressIndicator(
                              strokeWidth: 2.0,
                              valueColor: AlwaysStoppedAnimation<Color>(ac.circPrIn),
                            ),
                          ),
                    )
                        : Container(
                      // TODO: standardimage
                    ),
                    Positioned(
                      top: 0,
                      right: 0,
                      child: Container(
                        decoration: new BoxDecoration(
                          color: Colors.white38,
                          borderRadius: new BorderRadius.only(
                            bottomLeft: Radius.circular(ad.smallRadius),
                          ),
                        ),
                        child: Text(" " + match.points.toString()),
                      ),
                    ),
                  ],
                ),
                ad.hSmall(),
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
                        ad.vSmall(),
                        getCardLine(Icons.short_text, match.bio),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.all(ad.vMidSpace),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  getCardLine(Icons.business, 'test'),
                  ad.newLine(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Row getCardLine(IconData icon, String content) {
    return Row(
      children: <Widget>[
        Icon(icon, color: ac.iconPrim, size: 16),
        ad.iconText(),
        content != null && content.isNotEmpty
            ? Text(content.toString(), overflow: TextOverflow.clip, style: TextStyle(fontSize: 14))
            : Text('Nicht angegeben', style: TextStyle(fontSize: 14, color: ac.textOff))
      ],
    );
  }
}
