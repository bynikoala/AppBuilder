import 'ContactListView.dart';
import 'package:flutter/material.dart';

class ContactListController {

  ContactListView _view;

  ContactListController() {
    _view = ContactListView(this);
  }

  Widget getView() => _view;
}