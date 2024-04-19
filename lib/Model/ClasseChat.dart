class ClasseChat{
  int id;
  String filiere;
  String groupe;
  String type;
  String section;
  String groupeName;
  String filiereName;
  String sectionName;

  ClasseChat({
    required this.id,
    required this.filiere,
    required this.groupe,
    required this.section,
    required this.type,
    required this.filiereName,
    required this.groupeName,
    required this.sectionName
  });

  factory ClasseChat.fromJson(Map<String, dynamic> json) {
    return ClasseChat(
      id: json['id'],
      filiere: json['filiere'].toString(),
      groupe: json['groupe'].toString(),
      section: json['section'].toString(),
      filiereName: json['filiereName'].toString(),
      groupeName: json['groupeName'].toString(),
      sectionName: json['sectionName'].toString(),
      type: 'classe',
    );
  }
}