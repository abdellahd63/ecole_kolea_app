class Semester{
  int id;
  String libelle;

  Semester({
    required this.id,
    required this.libelle,
  });

  factory Semester.fromJson(Map<String, dynamic> json) {
    return Semester(
        id: json['id'],
        libelle: json['libelle'].toString(),
    );
  }
}