import 'package:flutter/material.dart';
import 'package:flutter_examen1/components/config.dart';
import 'package:flutter_examen1/components/sliding_menu.dart';
import 'package:flutter_examen1/components/video_hero.dart';
import 'package:flutter_examen1/pages/regions_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key, required this.config});

  final Config config;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "France Data",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      drawer: SlideMenu(config: config, currentPage: config.get('page-name.home'),),
      body: ListView( // agencement des sections du body en colonne
        children: <Widget>[ // sections du body
          //... ici empilez les differentes sections du body.
          //... séparez les avec du padding
          VideoHero(config: config),
          Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  color: Colors.blue[700],
                  padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
                  child: const Text(
                    "I. Nos Régions",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ), // component affichant un Hero avec un background Video
            
          Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
                  child: const Text(
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas quam arcu, suscipit eu accumsan quis, posuere in massa. Phasellus tempor ante nec mi aliquam dignissim. Maecenas malesuada cursus ultrices. Cras in orci non lacus aliquet porttitor in id augue. Mauris consequat convallis magna, id consequat augue pulvinar vel. Maecenas malesuada cursus ultrices. Cras in orci non lacus aliquet porttitor in id augue. Mauris consequat convallis magna, id consequat augue pulvinar vel. ",
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
            ],
          ), 

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            
            children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(0,50,0,50),
                  child: ElevatedButton(
                    onPressed: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => RegionPage(config: config,))
                      );
                    }, 
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.search,
                          color: Colors.blueAccent,
                        ),
                        Text(
                          "Rechercher Par Région",
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        )
                      ],
                    ),
                  )
                ),
            ],
          ),

          Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
                  child: const Text(
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas quam arcu, suscipit eu accumsan quis, posuere in massa. Phasellus tempor ante nec mi aliquam dignissim. Maecenas malesuada cursus ultrices. Cras in orci non lacus aliquet porttitor in id augue. Mauris consequat convallis magna, id consequat augue pulvinar vel. ",
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 10,
                      color: Colors.grey
                    ),
                  ),
                ),
              ),
            ],
          ), 

        ],
      ),
    );
  }
}
