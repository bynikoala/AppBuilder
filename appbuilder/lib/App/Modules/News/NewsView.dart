import 'package:appbuilder/App/CustomWidgets/CustomError.dart';
import 'package:appbuilder/App/CustomWidgets/CustomWidgets.dart';
import 'package:appbuilder/App/Design/AppColors.dart';
import 'package:appbuilder/App/Design/AppDimensions.dart';
import 'package:appbuilder/App/Modules/News/NewsController.dart';
import 'package:appbuilder/App/Settings/GlobalSettings.dart';
import 'package:flutter/material.dart';

import 'Model/News.dart';

class NewsView extends StatefulWidget {
  final NewsController _controller;

  NewsView(this._controller);

  @override
  _NewsViewState createState() => _NewsViewState();
}

class _NewsViewState extends State<NewsView> {
  AppDimensions ad = GlobalSettings.ad;
  AppColors ac = GlobalSettings.ac;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: null,
        body: Container(
          child: StreamBuilder(
            stream: widget._controller.stream,
            builder: (context, AsyncSnapshot<List<News>> news) {
              // Handle Connection Error
              if (news.hasError) {
                print('Error while loading News: ${news.error} # ${news.connectionState}');
                return CustomError(() {
                  setState(() {});
                }, error: 'Verbindungsfehler');
              }

              switch (news.connectionState) {
                case ConnectionState.none:
                  return CustomError(() {
                    setState(() {});
                  }, error: 'Verbindungsfehler');

                case ConnectionState.waiting:
                  return CustomWidgets().getViewLoader(ac, 'Neuigkeiten werden geladen...', ad);

                case ConnectionState.active:
                  if (news.hasData && news.data.isNotEmpty) {
                    return getContent(news.data);
                  } else {
                    return CustomError(() {
                      setState(() {});
                    }, error: "Noch keine Neuigkeiten");
                  }
                  break;
                case ConnectionState.done:
                  return CustomError(() {
                    setState(() {});
                  }, error: "Noch keine Neuigkeiten");
              }
              return null;
            },
          ),
        ));
  }

  Center getContent(List<News> newsList) {
    return Center(
      child: ListView(
        padding: EdgeInsets.all(ad.hSmallSpace),
        children: newsList
            .map(
              (news) => Card(
                child: Container(
                  padding: EdgeInsets.all(ad.hTinySpace),
                  child: Column(
                    children: [
                      Text(
                        news.title,
                        textScaleFactor: 1.2,
                        textAlign: TextAlign.center,
                      ),
                      ad.vSmall(),
                      Text(
                        news.text,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
