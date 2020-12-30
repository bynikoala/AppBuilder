import 'ContactListView.dart';

class ContactListController {

  ContactListView _view;

  ContactListController() {
    _view = ContactListView(this);
  }

  getView() => _view;
}