class AuthModelDaum {
  final String sId;
  final String name;
  final String token;

  AuthModelDaum({
    required this.sId,
    required this.name,
    required this.token,
  });

  factory AuthModelDaum.fromJson(Map<String, dynamic> json) {
    return AuthModelDaum(
      sId: json['_id'],
      name: json['name'],
      token: json['token'],
    );
  }
}

class AuthModelProps {
  bool success;
  String message;
  AuthModelDaum data;

  AuthModelProps({
    required this.success,
    required this.message,
    required this.data,
  });

  factory AuthModelProps.fromJson(Map<String, dynamic> json) {
    return AuthModelProps(
      success: json["success"],
      message: json["message"],
      data: AuthModelDaum.fromJson(json["data"]),
    );
  }
}
