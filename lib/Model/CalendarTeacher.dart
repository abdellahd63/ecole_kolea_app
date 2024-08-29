class CalendarTeacher {
  final int id;
  final String jour;
  final String horaireDebut;
  final String horaireFin;
  final int module;
  final int enseignant;
  final int? groupe;
  final String libelle;
  final int emploiDuTemps;
  final ModuleAssociation moduleAssociation;
  final GroupeAssociation? groupeAssociation;

  CalendarTeacher({
    required this.id,
    required this.jour,
    required this.horaireDebut,
    required this.horaireFin,
    required this.module,
    required this.enseignant,
    this.groupe,
    required this.libelle,
    required this.emploiDuTemps,
    required this.moduleAssociation,
    this.groupeAssociation,
  });

  factory CalendarTeacher.fromJson(Map<String, dynamic> json) {
    return CalendarTeacher(
      id: json['id'],
      jour: json['jour'],
      horaireDebut: json['horaire_debut'],
      horaireFin: json['horaire_fin'],
      module: json['module'],
      enseignant: json['enseignant'],
      groupe: json['groupe'],
      libelle: json['libelle'],
      emploiDuTemps: json['emploi_du_temps'],
      moduleAssociation: ModuleAssociation.fromJson(json['moduleAssociation']),
      groupeAssociation: json['groupeAssociation'] != null
          ? GroupeAssociation.fromJson(json['groupeAssociation'])
          : null,
    );
  }
}

class ModuleAssociation {
  final int id;
  final String libelle;
  final int filiere;
  final FiliereAssociation filiereAssociation;

  ModuleAssociation({
    required this.id,
    required this.libelle,
    required this.filiere,
    required this.filiereAssociation,
  });

  factory ModuleAssociation.fromJson(Map<String, dynamic> json) {
    return ModuleAssociation(
      id: json['id'],
      libelle: json['libelle'],
      filiere: json['filiere'],
      filiereAssociation: FiliereAssociation.fromJson(json['filiereAssociation']),
    );
  }
}

class FiliereAssociation {
  final int id;
  final String libelle;
  final String cycle;

  FiliereAssociation({
    required this.id,
    required this.libelle,
    required this.cycle,
  });

  factory FiliereAssociation.fromJson(Map<String, dynamic> json) {
    return FiliereAssociation(
      id: json['id'],
      libelle: json['libelle'],
      cycle: json['cycle'],
    );
  }
}

class GroupeAssociation {
  final int id;
  final String libelle;
  final int section;
  final SectionAssociation sectionAssociation;

  GroupeAssociation({
    required this.id,
    required this.libelle,
    required this.section,
    required this.sectionAssociation,
  });

  factory GroupeAssociation.fromJson(Map<String, dynamic> json) {
    return GroupeAssociation(
      id: json['id'],
      libelle: json['libelle'],
      section: json['section'],
      sectionAssociation: SectionAssociation.fromJson(json['sectionAssociation']),
    );
  }
}

class SectionAssociation {
  final int id;
  final String libelle;
  final int filiere;
  final int anneeAcademique;

  SectionAssociation({
    required this.id,
    required this.libelle,
    required this.filiere,
    required this.anneeAcademique,
  });

  factory SectionAssociation.fromJson(Map<String, dynamic> json) {
    return SectionAssociation(
      id: json['id'],
      libelle: json['libelle'],
      filiere: json['filiere'],
      anneeAcademique: json['annee_academique'],
    );
  }
}
