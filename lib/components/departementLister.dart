import 'package:flutter/material.dart';
import 'package:flutter_examen1/models/departement.model.dart';
import 'package:flutter_examen1/services/departement.service.dart';
import 'package:flutter_examen1/pages/commune_page.dart'; // Importez votre composant CommuneLister ici

class DepartementLister extends StatefulWidget {
  const DepartementLister({Key? key, required this.regionCode}) : super(key: key);

  final String regionCode;

  @override
  _DepartementListerState createState() => _DepartementListerState();
}

class _DepartementListerState extends State<DepartementLister> {
  late Future<DepartementList?> departements;

  @override
  void initState() {
    super.initState();
    loadDepartements();
  }

  void loadDepartements() {
    setState(() {
      departements = DepartementService.getDepartements(widget.regionCode);
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: departements,
      builder: (context, snapshot) {
        // Les données sont arrivées sans erreurs:
        if (snapshot.hasData) {
          List<Departement> departements = snapshot.data!.departements;
          return ListView.builder(
            itemCount: snapshot.data!.departements.length,
            itemBuilder: (context, index) {
              Departement departement = departements[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  // Vous pouvez personnaliser les propriétés de la carte ici
                  child: ListTile(
                    title: Text("${departement.nom}"),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Code du département: ${departement.code}"),
                      ],
                    ),
                    // Vous pouvez gérer onTap ici
                    onTap: () {
                      // Naviguer vers la page listant toutes les communes du département
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CommunePage(
                              regionCode: widget.regionCode,
                              departement: departement, // Passer le département sélectionné
                            ),
                          ),
                      );
                    }
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