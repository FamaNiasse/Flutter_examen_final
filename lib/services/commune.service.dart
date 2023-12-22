import 'dart:convert';
import 'package:flutter_examen1/models/commune.model.dart';
import 'package:http/http.dart' as http;

class CommuneService {
  static Future<CommuneList?> getCommunes(String codeDepartement) async {
    try {
      String baseUrl = "https://geo.api.gouv.fr/departements/$codeDepartement/communes";
      final response = await http.get(
        Uri.parse(baseUrl),
        headers: {"Accept": "application/json"},
      );

      if (response.statusCode == 200) {
        if (response.body.isNotEmpty) {
          final jsonResponse = json.decode(response.body);
          final CommuneList communes = CommuneList.fromJson(jsonResponse);

          if (communes.communes.isNotEmpty) {
            return communes;
          } else {
            return null;
          }
        } else {
          return null;
        }
      } else {
        throw Exception('Impossible de charger les communes. Code ${response.statusCode}');
      }
    } catch (e) {
      print(e.toString());
      throw Exception('Impossible de charger les communes. Erreur inattendue.');
    }
  }
}