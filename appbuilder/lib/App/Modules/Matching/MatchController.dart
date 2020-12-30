import 'package:appbuilder/App/Settings/GlobalSettings.dart';

import 'MatchViewSlide.dart';
import 'Model/Match.dart';

class MatchController {
  MatchViewSlide _view;
  Stream<Match> stream;

  MatchController() {
    initStream();
    _view = MatchViewSlide(this);
  }

  getView() => _view;

  initStream() async {
    stream = GlobalSettings.getStore().doc('users').collection('users').doc(GlobalSettings.getUser().uid).snapshots().map(
          (doc) => Match.fromStream(doc.id, doc.data()),
        );
  }

  void acceptMatch() {}

  void deleteMatch() {}

  void chatMatch() {}

  void getMatchProfile() {}
}
