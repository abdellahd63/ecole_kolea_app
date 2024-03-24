class Bibliotheque{
  int id;
  String libelle;


  Bibliotheque({
    required this.id,
    required this.libelle,
  });

  factory Bibliotheque.fromJson(Map<String, dynamic> json) {
    return Bibliotheque(
      id: json['id'],
      libelle: json['libelle'].toString(),
    );
  }
}