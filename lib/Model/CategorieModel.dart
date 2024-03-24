class CategorieModel {
  int id;
  String libelle;
  int bibliotheque;

  CategorieModel({
    required this.id,
    required this.libelle,
    required this.bibliotheque
  });

  factory CategorieModel.fromJson(Map<String, dynamic> json) {
    return CategorieModel(
      id: json['id'],
      libelle: json['libelle'].toString(),
      bibliotheque: json['bibliotheque'],
    );
  }
}