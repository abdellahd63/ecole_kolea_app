class Creneau{
  int id;
  String jour;
  String horaire_debut;
  String horaire_fin;
  int module;
  int enseignant;
  int? groupe;
  String libelle;
  int emploi_du_temps;
  String? moduleName;
  String? enseignantName;

  Creneau({
    required this.id,
    required this.jour,
    required this.horaire_debut,
    required this.horaire_fin,
    required this.module,
    required this.enseignant,
    required this.groupe,
    required this.libelle,
    required this.emploi_du_temps,
    this.moduleName,
    this.enseignantName
  });

  factory Creneau.fromJson(Map<String, dynamic> json) {
    return Creneau(
      id: json['id'],
      jour: json['jour'].toString(),
      horaire_debut: json['horaire_debut'].toString(),
      horaire_fin: json['horaire_fin'].toString(),
      module: json['module'],
      enseignant: json['enseignant'],
      groupe: json['groupe'],
      libelle: json['libelle'].toString(),
      emploi_du_temps: json['emploi_du_temps'],
      moduleName: json['moduleName'].toString(),
      enseignantName: json['enseignantName'],
    );
  }
}