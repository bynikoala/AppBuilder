import 'package:appbuilder/App/Settings/GlobalSettings.dart';

import 'Model/News.dart';
import 'NewsView.dart';
import 'package:flutter/material.dart';

class NewsController {
  NewsView _view;
  Stream<List<News>> stream;

  NewsController() {
    _view = NewsView(this);
    initStream();
  }

  Widget getView() => _view;

  initStream() async {
    stream = GlobalSettings.getStore().doc('news').collection('news').snapshots().map(
          (query) => query.docs.map((doc) => News.fromStream(doc.data())),
    );
  }
}