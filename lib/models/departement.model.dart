class Departement 
{
  Departement (
    this.nom,
    this.code,
    this.codeRegion,
  );

  final String nom;
  final String code;
  final String codeRegion;

  factory Departement.fromJson(Map<String, dynamic> json) {
    return Departement(
      json['nom'], 
      json['code'], 
      json['codeRegion'],
      
      );
  }

  String get getNom => nom;
  String get getCode => code;
  String get getCodeRegion => codeRegion;
}


class DepartementList
{
  // constructeur
  DepartementList({required this.departements});

  // propriété requise par le constructeur
  final List<Departement> departements;

  factory DepartementList.fromJson(List<dynamic> parseJson){
     List<Departement> departements = <Departement>[];

     departements = parseJson.map((p) => Departement.fromJson(p)).toList();

     return DepartementList(departements: departements);
  }
}