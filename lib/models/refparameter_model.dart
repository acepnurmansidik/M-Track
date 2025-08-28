class ReffParamModelProps {
  bool success;
  String message;
  List<ReffParamDaum> data;

  ReffParamModelProps({
    required this.success,
    required this.message,
    required this.data,
  });

  factory ReffParamModelProps.fromJson(Map<String, dynamic> json) {
    return ReffParamModelProps(
      success: json["success"],
      message: json["message"],
      data: (json["data"] as List<dynamic>)
          .map((item) => ReffParamDaum.fromJson(item))
          .toList(),
    );
  }
}

class ReffParamDaum {
  final String sId;
  final String value;
  final String type;
  final String description;
  final String createdAt;
  final List<ChildrenDaum> children;

  ReffParamDaum({
    required this.sId,
    required this.value,
    required this.type,
    required this.description,
    required this.createdAt,
    required this.children,
  });

  factory ReffParamDaum.fromJson(Map<String, dynamic> json) {
    return ReffParamDaum(
      sId: json['_id'],
      value: json['value'],
      type: json['type'],
      description: json['description'],
      createdAt: json['createdAt'],
      children: (json["children"] as List<dynamic>)
          .map((item) => ChildrenDaum.fromJson(item))
          .toList(),
    );
  }
}

class ChildrenDaum {
  final String sId;
  final String value;
  final String type;

  ChildrenDaum({
    required this.sId,
    required this.value,
    required this.type,
  });

  factory ChildrenDaum.fromJson(Map<String, dynamic> json) {
    return ChildrenDaum(
      sId: json['_id'],
      value: json['value'],
      type: json['type'],
    );
  }
}
