class ChartCategoriesPeriodeProps {
  bool success;
  String message;
  List<ChartCategoriesPeriodeDaum> data;

  ChartCategoriesPeriodeProps({
    required this.success,
    required this.message,
    required this.data,
  });

  factory ChartCategoriesPeriodeProps.fromJson(Map<String, dynamic> json) {
    return ChartCategoriesPeriodeProps(
      success: json["success"],
      message: json["message"],
      data: (json["data"] as List<dynamic>)
          .map((item) => ChartCategoriesPeriodeDaum.fromJson(item))
          .toList(),
    );
  }
}

class ChartCategoriesPeriodeDaum {
  String periode;
  int totalEntertaiment;
  int totalFoodDrink;
  int totalFreelance;
  int totalSalaryMonthly;

  ChartCategoriesPeriodeDaum({
    required this.periode,
    required this.totalEntertaiment,
    required this.totalFoodDrink,
    required this.totalFreelance,
    required this.totalSalaryMonthly,
  });

  factory ChartCategoriesPeriodeDaum.fromJson(Map<String, dynamic> json) {
    return ChartCategoriesPeriodeDaum(
      periode: json["periode"],
      totalEntertaiment: json["total_entertaiment"],
      totalFoodDrink: json["total_food&drink"],
      totalFreelance: json["total_freelance"],
      totalSalaryMonthly: json["total_salarymonthly"],
    );
  }
}
