class Affichage{
  int id;
  String semestre;

  Affichage({
    required this.id,
    required this.semestre,
  });

  factory Affichage.fromJson(Map<String, dynamic> json) {
    return Affichage(
      id: json['id'],
      semestre: json['semestre'].toString(),
    );
  }
}