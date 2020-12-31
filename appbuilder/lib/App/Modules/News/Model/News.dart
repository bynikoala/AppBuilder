class News {
  String title;
  String description;
  String text;

  News(this.title, this.description, this.text);

  News.fromStream(Map<String, dynamic> doc) {
    title = doc['title'];
    description = doc['description'];
    text = doc['text'];
  }
}