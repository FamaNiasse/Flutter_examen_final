import 'package:flutter/services.dart' show rootBundle;
import 'package:yaml/yaml.dart';

class Config {
  static Config? _instance;

  late YamlMap _config;

  // Constructeur privé
  Config._internal();

  // Méthode pour obtenir l'instance unique de Config
  static Config getInstance() {
    _instance ??= Config._internal();
    return _instance!;
  }

  // Chargement du fichier YAML
  Future<void> load() async {
    try {
      final String yamlString = await rootBundle.loadString('assets/config/config.yaml');
      _config = loadYaml(yamlString);
    } catch (e) {
      print('Erreur lors du chargement du fichier YAML: $e');
    }
  }

  // Méthode pour accéder aux données du YAML
  dynamic get(String key) {
    dynamic value;
    try {
      value = _recursiveGet(_config, key.split('.'));
    } catch (e) {
      print('Erreur lors de l\'accès aux données YAML: $e');
    }
    return value;
  }

  dynamic _recursiveGet(YamlMap yamlMap, List<String> keys) {
    dynamic value = yamlMap;
    for (final key in keys) {
      value = value[key];
      print(value);
    }
    return value;
  }
}