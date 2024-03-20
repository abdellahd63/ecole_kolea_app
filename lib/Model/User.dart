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

  factory User.fromJson(Map<String, dynamic> json, String type) {
    return User(
      id: json['id'],
      nom: json['nom'],
      prenom: json['prenom'],
      type: type,
    );
  }}