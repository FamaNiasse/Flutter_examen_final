import 'package:flutter/material.dart';
import 'package:flutter_examen1/models/commune.model.dart';
import 'package:flutter_examen1/services/commune.service.dart';

class CommuneLister extends StatefulWidget {
  const CommuneLister({Key? key, required this.codeDepartement, required this.onCommuneTap}) : super(key: key);

  final String codeDepartement;
  final void Function(Commune) onCommuneTap;

  @override
  _CommuneListerState createState() => _CommuneListerState();
}

class _CommuneListerState extends State<CommuneLister> {
  late Future<CommuneList?> communes;

  @override
  void initState() {
    super.initState();
    loadCommunes();
  }

  void loadCommunes() {
    setState(() {
      communes = CommuneService.getCommunes(widget.codeDepartement);
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: communes,
      builder: (context, snapshot) {
        // Les données sont arrivées sans erreurs:
        if (snapshot.hasData) {
          List<Commune> communes = snapshot.data!.communes;
          return ListView.builder(
            itemCount: snapshot.data!.communes.length,
            itemBuilder: (context, index) {
              Commune commune = communes[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  // Vous pouvez personnaliser les propriétés de la carte ici
                  child: ListTile(
                    title: Text("${commune.nom}"),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Code de la commune: ${commune.code}"),
                        Text("Code postal: ${commune.codesPostaux.isNotEmpty ? commune.codesPostaux[0] : ''}"),
                        Text("Population: ${commune.population}"),
                      ],
                    ),
                    // Vous pouvez gérer onTap ici
                    onTap: () {
                      // Naviguer vers la page listant toutes les communes du département
                      widget.onCommuneTap(commune);
                    },
                  ),
                ),
              );
            },
          );
          // La requête a provoqué une erreur
        } else if (snapshot.hasError) {
          return Text("Erreur: ${snapshot.error}");
        }

        return const Expanded(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}