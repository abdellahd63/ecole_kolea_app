class ClasseChat{
  int id;
  String filiere;
  String groupe;
  String type;
  String? section;

  ClasseChat({
    required this.id,
    required this.filiere,
    required this.groupe,
    required this.section,
    required this.type,
  });

  factory ClasseChat.fromJson(Map<String, dynamic> json) {
    return ClasseChat(
      id: json['id'],
      filiere: json['filiere'].toString(),
      groupe: json['groupe'].toString(),
      section: json['section'].toString(),
      type: 'classe',
    );
  }}