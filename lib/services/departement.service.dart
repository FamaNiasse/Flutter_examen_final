import 'dart:convert';
import 'package:flutter_examen1/models/departement.model.dart';
import 'package:http/http.dart' as http;

class DepartementService { 

  static Future<DepartementList?> getDepartements(String regionCode) async {
    try {
      String baseUrl = "https://geo.api.gouv.fr/regions/$regionCode/departements";
      print(baseUrl);
      final response = await http.get(
        Uri.parse(baseUrl),
        headers: {"Accept": "application/json"},
      );

      if (response.statusCode == 200) {
        if (response.body.isNotEmpty) {
          final jsonResponse = json.decode(response.body);
          final DepartementList departements = DepartementList.fromJson(jsonResponse);

          if (departements.departements.isNotEmpty) {
            return departements;
          } else {
            return null;
          }
        } else {
          return null;
        }
      } else {
        throw Exception('Impossible de charger les départements. Code ${response.statusCode}');
      }
    } catch (e) {
      print(e.toString());
      throw Exception('Impossible de charger les départements. Erreur inattendue.');
    }
  }
}