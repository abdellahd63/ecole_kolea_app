class Section{
  int id;
  String libelle;
  int filiere;

  Section({
    required this.id,
    required this.libelle,
    required this.filiere
  });

  factory Section.fromJson(Map<String, dynamic> json) {
    return Section(
      id: json['id'],
      libelle: json['libelle'].toString(),
      filiere: json['filiere']
    );
  }
}