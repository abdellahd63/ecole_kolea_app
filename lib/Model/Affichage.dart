class Affichage{
  int id;
  int semestreID;
  int anneeID;
  String semestre;
  String annee;

  Affichage({
    required this.id,
    required this.semestreID,
    required this.anneeID,
    required this.semestre,
    required this.annee,
  });

  factory Affichage.fromJson(Map<String, dynamic> json) {
    return Affichage(
      id: json['id'],
      semestreID: json['semestre'],
      anneeID: json['annee_universitaire'],
      semestre: json['Nomsemester'].toString(),
      annee: json['NomAnneeUniversitaire'].toString(),
    );
  }
}