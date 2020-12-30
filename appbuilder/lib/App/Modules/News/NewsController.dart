import 'NewsView.dart';

class NewsController {
  NewsView _view;

  NewsController() {
    _view = NewsView(this);
  }

  getView() => _view;
}