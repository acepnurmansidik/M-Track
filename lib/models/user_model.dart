class UserModelProps {
  bool success;
  String message;
  UserModelDaum data;

  UserModelProps({
    required this.success,
    required this.message,
    required this.data,
  });

  factory UserModelProps.fromJson(Map<String, dynamic> json) {
    return UserModelProps(
      success: json["success"],
      message: json["message"],
      data: UserModelDaum.fromJson(json["data"]),
    );
  }
}

class UserModelDaum {
  final String sId;
  final String name;
  final String deviceToken;
  final String email;
  final String joinedAt;

  UserModelDaum({
    required this.sId,
    required this.name,
    required this.deviceToken,
    required this.email,
    required this.joinedAt,
  });

  factory UserModelDaum.fromJson(Map<String, dynamic> json) {
    return UserModelDaum(
      sId: json['_id'],
      name: json['name'],
      deviceToken: json['device_token'],
      email: json['email'],
      joinedAt: json['joined_at'],
    );
  }
}
