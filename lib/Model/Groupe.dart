class Groupe{
  int id;
  String libelle;
  int section;

  Groupe({
    required this.id,
    required this.libelle,
    required this.section
  });

  factory Groupe.fromJson(Map<String, dynamic> json) {
    return Groupe(
      id: json['id'],
      libelle: json['libelle'].toString(),
      section: json['section']
    );
  }
}