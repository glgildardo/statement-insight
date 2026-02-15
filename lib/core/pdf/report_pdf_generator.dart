abstract class ReportPdfGenerator {
  Future<List<int>> generate({
    required DateTime periodStart,
    required DateTime periodEnd,
    required double totalSpent,
    required double totalIncome,
    required double net,
    required Map<String, double> categoryBreakdown,
    required List<String> topExpenses,
  });
}
