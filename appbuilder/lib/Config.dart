class Config {
  final String name;
  final String bucket;
  final String theme;
  final List<String> auth;
  final List<String> modules;
  final List<String> language;
  final String color;
  final String logo;

  Config.fromJson(Map<String, dynamic> config)
      : name = config['name'],
        bucket = config['bucket'],
        theme = config['theme'],
        auth = config['auth'],
        modules = config['modules'],
        language = config['language'],
        color = config['color'],
        logo = config['logo'];
}
