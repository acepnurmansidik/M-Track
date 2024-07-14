class ItemsModel {
  final String id;
  final int key;
  final String name;
  final String description;
  List? items;

  ItemsModel(
      {required this.id,
      required this.key,
      required this.name,
      required this.description,
      this.items});

  factory ItemsModel.fromJson(Map<String, dynamic> json) {
    return ItemsModel(
      id: json['_id'],
      key: json['key'],
      name: json['name'],
      description: json['description'],
    );
  }
}

class RefparameterModel {
  final String id;
  final String type;
  final String name;
  final List<ItemsModel> items;

  const RefparameterModel({
    this.id = "",
    required this.name,
    required this.type,
    required this.items,
  });

  factory RefparameterModel.fromJson(Map<String, dynamic> json) =>
      RefparameterModel(
        id: json['parent_id'],
        name: json['name'],
        type: json['type'],
        items: (json['items'] as List<dynamic>)
            .map((item) => ItemsModel.fromJson(item))
            .toList(),
      );
}
