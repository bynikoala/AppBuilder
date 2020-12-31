import 'package:appbuilder/App/Settings/GlobalSettings.dart';

import 'ContactListView.dart';
import 'package:flutter/material.dart';

import 'Model/Contact.dart';

class ContactListController {

  ContactListView _view;
  Stream<List<Contact>> stream;

  ContactListController() {
    _view = ContactListView(this);
    initStream();
  }

  Widget getView() => _view;

  initStream() async {
    stream = GlobalSettings.getStore().doc('users').collection('users').doc(GlobalSettings.getUser().uid).collection('contacts').snapshots().map(
        (query) => query.docs.map((doc) => Contact.fromStream(doc.id, doc.data())).toList(),
      );
  }

  message() {}

  delete() {}
}