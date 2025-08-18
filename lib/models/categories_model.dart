class CategoriesModelProps {
  bool success;
  String message;
  List<CategoryDaum> data;

  CategoriesModelProps({
    required this.success,
    required this.message,
    required this.data,
  });

  factory CategoriesModelProps.fromJson(Map<String, dynamic> json) {
    return CategoriesModelProps(
      success: json["success"],
      message: json["message"],
      data: (json["data"] as List<dynamic>)
          .map((item) => CategoryDaum.fromJson(item))
          .toList(),
    );
  }
}

class CategoryDaum {
  int totalAmount;
  String category;
  String typeName;

  CategoryDaum({
    required this.totalAmount,
    required this.category,
    required this.typeName,
  });

  factory CategoryDaum.fromJson(Map<String, dynamic> json) {
    return CategoryDaum(
      totalAmount: json["total_amount"],
      category: json["category"],
      typeName: json["type_name"],
    );
  }
}
