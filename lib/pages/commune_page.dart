import 'package:flutter/material.dart';
import 'package:flutter_examen1/components/communeLister.dart';
import 'package:flutter_examen1/models/commune.model.dart';
import 'package:flutter_examen1/models/departement.model.dart';
import 'package:flutter_examen1/services/commune.service.dart';

class CommunePage extends StatelessWidget {
  const CommunePage({Key? key, required this.regionCode, required this.departement}) : super(key: key);

  final String regionCode;
  final Departement departement;

  void _showCommuneDetails(BuildContext context, Commune commune) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(commune.nom),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Code de la commune: ${commune.code}"),
              Text("Code postal: ${commune.codesPostaux.isNotEmpty ? commune.codesPostaux[0] : ''}"),
              Text("Population: ${commune.population}"),
              Text("SIREN: ${commune.siren}"),
              Text("Code EPCI: ${commune.codeEpci}"),
              Text("Code région: ${commune.codeRegion}"),
              // Ajoutez d'autres informations de la commune selon vos besoins
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Fermer"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AppBar(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            iconTheme: const IconThemeData(color: Colors.white),
            title: Text(
              'Département: ${departement.nom}',
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height / 5,
            color: const Color.fromARGB(255, 103, 202, 251).withOpacity(0.2),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: FutureBuilder<CommuneList?>(
                  // Vous devrez peut-être ajuster cela en fonction de la manière dont vous récupérez les communes
                  future: CommuneService.getCommunes(regionCode),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError || snapshot.data == null) {
                      return const Text("Erreur lors de la récupération des données");
                    } else {
                      int nombreCommunes = snapshot.data!.communes.length;
                      return Text(
                        "Le département ${departement.nom} (${departement.code}) compte $nombreCommunes communes.\nCliquez sur l'une des communes pour en savoir plus.",
                        style: const TextStyle(
                          fontSize: 15.0,
                        ),
                      );
                    }
                  },
                ),
              ),
            ),
          ),
          Expanded(
            child: CommuneLister(
              codeDepartement: regionCode,
              onCommuneTap: (commune) => _showCommuneDetails(context, commune),
            ),
          ),
        ],
      ),
    );
  }
}