import 'package:flutter/material.dart';
import 'package:flutter_examen1/components/config.dart';
import 'package:flutter_examen1/components/search_bar.dart';
import 'package:flutter_examen1/components/sliding_menu.dart';
import 'package:flutter_examen1/components/svg_map.dart';

class RegionPage extends StatelessWidget {
   const RegionPage({super.key, required this.config});

  final Config config;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset:false,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "Recherche Par Region",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      drawer: SlideMenu(config: config, currentPage: config.get('page-name.regions')),
      body: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(
              height:300,
              child: SearchBarApp(config: config),
            ),
            
            Expanded(
              child: Padding(
                padding:const EdgeInsets.only(left: 40.0),
                child: Center(
                  child: SvgMap(config: config),
                ),
              ),
              
            ),
          ],
        )
      
      
      
    );
  }
}