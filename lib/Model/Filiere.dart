class Filiere{
  int id;
  String libelle;


  Filiere({
    required this.id,
    required this.libelle,
  });

  factory Filiere.fromJson(Map<String, dynamic> json) {
    return Filiere(
      id: json['id'],
      libelle: json['libelle'].toString(),
    );
  }
}