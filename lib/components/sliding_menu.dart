import 'package:flutter/material.dart';
import 'package:flutter_examen1/components/config.dart';
import 'package:flutter_examen1/pages/home_page.dart';
import 'package:flutter_examen1/pages/regions_page.dart';

class SlideMenu extends StatelessWidget {
  const SlideMenu({super.key, required this.config, required this.currentPage});
  final Config config;
  final String currentPage;

  @override
  Widget build(BuildContext context) {
    // print(currentPage);
    return Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blueGrey,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'France Data',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                  Text(
                    'Atlas de Données Françaises',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Accueil'),
              onTap: () {
                Navigator.pop(context); // Ferme le tiroir latéral
                if(currentPage == "home") {
                  return;
                }
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage(config: config,))
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.map),
              title: const Text('Régions'),
              onTap: () {
                Navigator.pop(context); // Ferme le tiroir latéral
                if(currentPage == "regions") {
                  return;
                }
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegionPage(config: config,))
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Paramètres'),
              onTap: () {
                Navigator.pop(context); // Ferme le tiroir latéral
              },
            ),
          ],
        ),
      );
  }
}