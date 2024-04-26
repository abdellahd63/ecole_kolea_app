class Document{
  int id;
  String nom_document;
  String lien_document;
  int categorie;

  Document({
    required this.id,
    required this.nom_document,
    required this.lien_document,
    required this.categorie,
  });

  factory Document.fromJson(Map<String, dynamic> json) {
    return Document(
      id: json['id'],
      nom_document: json['nom_document'].toString(),
      lien_document: json['lien_document'].toString(),
      categorie: json['categorie'],
    );
  }
}