class ActivityCategoryModel {
  final Map<String, dynamic> income;
  final Map<String, dynamic> outcome;
  final List<DataActivityCategoryModel> listData;
  final List<DataChartActivityCategoryModel> dataChart;

  ActivityCategoryModel({
    required this.dataChart,
    required this.listData,
    required this.outcome,
    required this.income,
  });

  factory ActivityCategoryModel.fromJson(Map<String, dynamic> json) {
    return ActivityCategoryModel(
      income: json["income"],
      outcome: json["outcome"],
      dataChart: (json["data_chart"] as List<dynamic>)
          .map((item) => DataChartActivityCategoryModel.fromJson(item))
          .toList(),
      listData: (json["list_data"] as List<dynamic>)
          .map((item) => DataActivityCategoryModel.fromJson(item))
          .toList(),
    );
  }
}

class DataActivityCategoryModel {
  final String id;
  final String name;
  final int totalCategory;
  final int totalCount;
  final String imageUrl;

  DataActivityCategoryModel({
    required this.id,
    required this.name,
    required this.totalCategory,
    required this.totalCount,
    required this.imageUrl,
  });

  factory DataActivityCategoryModel.fromJson(Map<String, dynamic> json) {
    return DataActivityCategoryModel(
      id: json['_id'],
      name: json['name'],
      totalCategory: json['total_category'],
      totalCount: json['total_count'],
      imageUrl: json['image_url'],
    );
  }
}

class DataChartActivityCategoryModel {
  final String date;
  final int income;
  final int outcome;
  final String month;

  DataChartActivityCategoryModel({
    required this.date,
    required this.income,
    required this.outcome,
    required this.month,
  });

  factory DataChartActivityCategoryModel.fromJson(Map<String, dynamic> json) {
    return DataChartActivityCategoryModel(
      date: json['date'],
      income: json['income'],
      outcome: json['outcome'],
      month: json['month'],
    );
  }
}

class CategoryActivityResponse {
  int code;
  bool status;
  String message;
  List<CategoryActivityDataModel> data;

  CategoryActivityResponse({
    required this.code,
    required this.status,
    required this.message,
    required this.data,
  });

  factory CategoryActivityResponse.fromJson(Map<String, dynamic> json) {
    return CategoryActivityResponse(
      code: json['_id'],
      status: json['description'],
      message: json['icon'],
      data: (json['list_data'] as List<dynamic>)
          .map((e) => CategoryActivityDataModel.fromJson(e))
          .toList(),
    );
  }
}

class CategoryActivityDataModel {
  final String id;
  final String name;
  final int totalCategory;
  final int totalCount;
  final String imageUrl;

  CategoryActivityDataModel({
    required this.id,
    required this.name,
    required this.totalCategory,
    required this.totalCount,
    required this.imageUrl,
  });

  factory CategoryActivityDataModel.fromJson(Map<String, dynamic> json) {
    return CategoryActivityDataModel(
      id: json['_id'],
      name: json['name'],
      totalCategory: json['total_category'],
      totalCount: json['total_count'],
      imageUrl: json['image_url'],
    );
  }
}
