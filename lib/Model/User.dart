class User{
  int id;
  String nom;
  String prenom;
  String type;
  String? section;

  User({
    required this.id,
    required this.nom,
    required this.prenom,
    required this.type,
    this.section
  });
}