class MonthlyReportModel {
  final int totalCases;
  final int totalInvestigations;
  final int totalDeaths;
  final int totalRecoveries;

  MonthlyReportModel({
    required this.totalCases,
    required this.totalInvestigations,
    required this.totalDeaths,
    required this.totalRecoveries,
  });

  factory MonthlyReportModel.fromJson(Map<String, dynamic> json) {
    return MonthlyReportModel(
      totalCases: json['totalCases'],
      totalInvestigations: json['totalInvestigations'],
      totalDeaths: json['totalDeaths'],
      totalRecoveries: json['totalRecoveries'],
    );
  }
}
