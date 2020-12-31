import 'package:appbuilder/App/Settings/GlobalSettings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

import 'MatchView.dart';
import 'Model/Match.dart';

class MatchController {
  MatchView _view;
  Stream<List<Match>> stream;

  MatchController() {
    initStream();
    _view = MatchView(this);
  }

  Widget getView() => _view;

  initStream() async {
    stream = GlobalSettings.getStore().doc('users').collection('users').doc(GlobalSettings.getUser().uid).collection('matches').snapshots().map(
          (query) => query.docs.map((doc) => Match.fromStream(doc.id, doc.data())).toList()
        );
  }

  void acceptMatch() {}

  void deleteMatch() {}

  void chatMatch() {}

  void getMatchProfile() {}
}
