class ReffParameterModel {
  final String id;
  final String name;
  final String description;
  final Map<String, dynamic> icon;

  ReffParameterModel({
    required this.id,
    required this.description,
    required this.icon,
    required this.name,
  });

  factory ReffParameterModel.fromJson(Map<String, dynamic> json) {
    return ReffParameterModel(
      id: json['id'],
      description: json['description'],
      icon: json['icon'],
      name: json['name'],
    );
  }
}

class ItemsReffParamCustomModel {
  final String id;
  final int key;
  final String name;
  final String description;
  List? items;

  ItemsReffParamCustomModel({
    required this.id,
    required this.key,
    required this.name,
    required this.description,
    this.items,
  });

  factory ItemsReffParamCustomModel.fromJson(Map<String, dynamic> json) {
    return ItemsReffParamCustomModel(
      id: json['_id'],
      key: json['key'],
      name: json['name'],
      description: json['description'],
    );
  }
}

class ReffGroupParameterModel {
  final String id;
  final String type;
  final String name;
  final List<ItemsReffParamCustomModel> items;

  const ReffGroupParameterModel({
    this.id = "",
    required this.name,
    required this.type,
    required this.items,
  });

  factory ReffGroupParameterModel.fromJson(Map<String, dynamic> json) =>
      ReffGroupParameterModel(
        id: json['parent_id'],
        name: json['name'],
        type: json['type'],
        items: (json['items'] as List<dynamic>)
            .map((item) => ItemsReffParamCustomModel.fromJson(item))
            .toList(),
      );
}
