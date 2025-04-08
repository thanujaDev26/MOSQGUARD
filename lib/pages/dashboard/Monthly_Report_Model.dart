class MonthlyReport {
  final int totalCases;
  final int totalInvestigations;
  final int totalDeaths;
  final int totalRecoveries;

  MonthlyReport({
    required this.totalCases,
    required this.totalInvestigations,
    required this.totalDeaths,
    required this.totalRecoveries,
  });

  factory MonthlyReport.fromJson(Map<String, dynamic> json) {
    return MonthlyReport(
      totalCases: json['totalCases'],
      totalInvestigations: json['totalInvestigations'],
      totalDeaths: json['totalDeaths'],
      totalRecoveries: json['totalRecoveries'],
    );
  }
}
