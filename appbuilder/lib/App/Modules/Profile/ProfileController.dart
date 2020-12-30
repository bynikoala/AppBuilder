import 'package:appbuilder/App/Modules/Profile/ProfileView.dart';
import 'package:flutter/material.dart';

class ProfileController {
  BuildContext _context;
  ProfileView _view;

  ProfileController(this._context) {
    _view = ProfileView(this);
  }

  getView() => _view;
}