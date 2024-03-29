class NoteModule {
  int module;
  int affichage;
  int note;
  String remarque;
  String NomModule;
  NoteModule({
    required this.module,
    required this.affichage,
    required this.note,
    required this.remarque,
    required this.NomModule
  });

  factory NoteModule.fromJson(Map<String, dynamic> json) {
    return NoteModule(
      module: json['module'],
      affichage: json['affichage'],
      note: json["note"],
      remarque: json["remarque"].toString(),
      NomModule: json["NomModule"].toString()
    );
  }
}