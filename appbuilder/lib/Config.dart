class Config {
  String name;
  String bucket;
  String theme;
  List<String> auth;
  List<String> modules;
  List<String> language;
  String color;
  String logo;

  Config(
    this.name,
    this.bucket,
    this.theme,
    this.auth,
    this.modules,
    this.language,
    this.color,
    this.logo,
  );

  Config.fromJson(Map<String, dynamic> config) {
    print('beebop');
    this.name = config['name'];
    this.bucket = config['bucket'];
    this.theme = config['theme'];
    this.auth = config['auth'];
    this.modules = config['modules'];
    this.language = config['language'];
    this.color = config['color'];
    this.logo = config['logo'];
  }

}
