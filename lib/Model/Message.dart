class Message {
  String? expediteurID;
  String text;
  DateTime date;
  String type;
  String? expediteurName;

  Message({
    required this.text,
    required this.date,
    required this.type,
    this.expediteurID,
    this.expediteurName
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      text: json['texte'],
      date: DateTime.parse(json['date_envoi']),
      type: json['expediteur'],
      expediteurID: json['expediteurID'],
        expediteurName: json['expediteurName']
    );
  }
}
