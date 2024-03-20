class UserAdmin{
  int id;
  String role;
  String? type;

  UserAdmin({
    required this.id,
    required this.role,
    this.type
  });

  factory UserAdmin.fromJson(Map<String, dynamic> json, String type) {
    return UserAdmin(
      id: json['id'],
      role: json['role'],
      type : type
    );
  }}