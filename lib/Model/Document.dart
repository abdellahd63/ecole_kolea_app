class Document{
  int id;
  String? chemin_document;
  String nom_document;
  int disponibilite;
  int categorie;

  Document({
    required this.id,
    required this.nom_document,
    required this.disponibilite,
    required this.categorie,
    this.chemin_document
  });

  factory Document.fromJson(Map<String, dynamic> json) {
    return Document(
      id: json['id'],
      nom_document: json['nom_document'].toString(),
      disponibilite: json['disponibilité'],
      categorie: json['categorie'],
      chemin_document: json['chemin_document'].toString() ?? '',
    );
  }
}