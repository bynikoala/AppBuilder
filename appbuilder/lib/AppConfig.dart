class AppConfig {
  String name;
  String bucket;
  String theme;
  List<String> auth;
  List<String> modules;
  List<String> language;
  String color;
  String logo;

  AppConfig({
    this.name,
    this.bucket,
    this.theme,
    this.auth,
    this.modules,
    this.language,
    this.color,
    this.logo,
  });

  AppConfig.fromJson(Map<String, dynamic> config) {
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
