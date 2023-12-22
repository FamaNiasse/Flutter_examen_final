import 'package:flutter/material.dart';
import 'package:flutter_examen1/components/departementLister.dart';
import 'package:flutter_examen1/models/departement.model.dart';
import 'package:flutter_examen1/services/departement.service.dart';

class DepartementPage extends StatelessWidget {
  const DepartementPage({Key? key, required this.regionCode, required this.value}) : super(key: key);

  final String regionCode;
  final String value;

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
              'Région: $value',
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
                child: FutureBuilder<DepartementList?>(
                  future: DepartementService.getDepartements(regionCode),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError || snapshot.data == null) {
                      return const Text("Erreur lors de la récupération des données");
                    } else {
                      int nombreDepartements = snapshot.data!.departements.length;
                      return Text(
                        "La région $value ($regionCode) compte $nombreDepartements départements.\nCliquez sur l'un des départements pour en savoir plus.",
                  style: const TextStyle(
                    fontSize: 15.0,
                  )
                  );
                  }
                },
                ),
              ),
            ),
          ),
          Expanded(
            child: DepartementLister(regionCode: regionCode),
          ),
        ],
      ),
    );
  }
}