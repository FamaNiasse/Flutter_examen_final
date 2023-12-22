import 'package:flutter/material.dart';
import 'package:flutter_examen1/components/config.dart';
import 'package:flutter_examen1/pages/departements_page.dart';
import 'package:yaml/yaml.dart';

class SearchBarApp extends StatefulWidget {
  const SearchBarApp({super.key, required this.config});

  final Config config;

  @override
  State<SearchBarApp> createState() => _SearchBarAppState();
}


class _SearchBarAppState extends State<SearchBarApp> {

  String _query = '';
  List<String> filteredItems = [];
  List<String> searchresults = [];
  bool sbHasFocus = false;
  final TextEditingController _searchController = TextEditingController();

  var searchBarHasFocus = FocusNode();

  @override
  void initState() {
    searchBarHasFocus.addListener(() {
      // print(searchBarHasFocus.hasFocus);
      setState(() {
        sbHasFocus = searchBarHasFocus.hasFocus;
      });
    });
    super.initState();
  }


  void search(String query) {
    setState(
      () {
        _query = query;

        filteredItems  = searchresults
            .where(
              (item) => item.toLowerCase().contains(
                    query.toLowerCase(),
                  ),
            )
            .toList();
      },
    );
  }

  void updateSearchQuery(value) {
    _searchController.text = value;
  }

  String getCode(value){
    return widget.config.get('regions.$value.code');
  }
  

  void setRegions(YamlMap regions) {
    if(searchresults.isEmpty) {
      for(var region in regions.values) {
        // print(region["nom"]);
        setState(() {
          searchresults.add(region["nom"]);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    //on récupere la liste des régions dans le yaml de config
    // si la liste des regions est vide alors on la rempli.
    if(searchresults.isEmpty) {
        setRegions(widget.config.get("regions"));
    }
    
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
                child: SearchBar(
                  controller: _searchController,
                  focusNode: searchBarHasFocus,
                  hintText: "Choisir une région",
                  padding: const MaterialStatePropertyAll<EdgeInsets>(
                      EdgeInsets.symmetric(horizontal: 16.0)),
                  onSubmitted: (value) {
                    // print("Submitting $value");
                    String regionCode = getCode(value);
                    String region = value;
                    print(value);
                    Navigator.push(context,
                      MaterialPageRoute(builder: (context) => DepartementPage(regionCode: regionCode, value: region)),
                    );
                  },
                  onChanged: (value) {
                    search(value);
                    // print('search has changed');
                  },
                  leading: const Icon(
                    Icons.search,
                    color: Color.fromARGB(255, 39, 108, 228),
                    size: 18,),
                  
                ),
              ),
            ),
          ],
        ), 
      
        Visibility(
          visible: sbHasFocus,
          maintainSize: false,
          child: Flexible(
            child: 
              (filteredItems.isNotEmpty || _query.isNotEmpty) 
            ?

              filteredItems.isEmpty 

            ? 
            Container(
              width: 400,
              decoration:  const BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20.0),
                  bottomRight: Radius.circular(20.0),
                ),
                color: Color.fromARGB(37, 4, 160, 232),
              ),
              child: const Center(
                child: Text(
                  'No Results Found',
                  style: TextStyle(fontSize: 18),
                ),
              )
            )
            
            :

            Container(
              width: 400,
              decoration:  const BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20.0),
                  bottomRight: Radius.circular(20.0),
                ),
                color: Color.fromARGB(37, 4, 160, 232),
              ),
              child: ListView.builder(
                itemCount: filteredItems.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTapDown: (detail) {
                      updateSearchQuery(filteredItems[index]);
                    },
                    child: Container(
                      decoration:  const BoxDecoration(
                        border: Border( // Bordure supérieure
                          bottom: BorderSide(width: 1.0, color: Colors.white), // Bordure inférieure
                        ),
                      ),
                      child: ListTile(
                        title: Text(filteredItems[index]),
                      ),
                    ),
                  );
                },
              )
            )
            
            :

            Container(
              width: 400,
              decoration:  const BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20.0),
                  bottomRight: Radius.circular(20.0),
                ),
                color: Color.fromARGB(37, 4, 160, 232),
              ),
              child: ListView.builder(
                itemCount: searchresults.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTapDown: (detail) {
                      updateSearchQuery(searchresults[index]);
                      searchBarHasFocus.requestFocus();  // Demander le focus à la searchBar
                      search(_searchController.text);  // Filtrer la liste avec le contenu actuel de la searchBar
                      
                    },
                    
                    child: Container(
                      decoration:  const BoxDecoration(
                        border: Border( // Bordure supérieure
                          bottom: BorderSide(width: 1.0, color: Colors.white), // Bordure inférieure
                        ),
                      ),
                      child: ListTile(
                        title: Text(searchresults[index]),
                      ),
                    ),
                  );
                },
              )
            ),
          )
        )
      ],
    );    
  }
}