class NotificationModel{
  String Title;
  String Content;


  NotificationModel({
    required this.Title,
    required this.Content,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      Title: json['titre'],
      Content: json['contenu'].toString(),
    );
  }
}