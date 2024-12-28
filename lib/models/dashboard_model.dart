class ActivityCategoryModel {
  List<DataActivityCategoryModel> listData;
  List<DataChartActivityCategoryModel> dataChart;

  ActivityCategoryModel({required this.dataChart, required this.listData});

  factory ActivityCategoryModel.fromJson(Map<String, dynamic> json) {
    return ActivityCategoryModel(
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
