import '../../core/models/app_error.dart';
import '../../core/models/transaction_category.dart';

class DashboardState {
  const DashboardState({
    required this.loading,
    required this.totalSpent,
    required this.totalIncome,
    required this.netBalance,
    required this.categoryBreakdown,
    this.error,
  });

  const DashboardState.initial()
      : loading = false,
        totalSpent = 0,
        totalIncome = 0,
        netBalance = 0,
        categoryBreakdown = const <TransactionCategory, double>{},
        error = null;

  final bool loading;
  final double totalSpent;
  final double totalIncome;
  final double netBalance;
  final Map<TransactionCategory, double> categoryBreakdown;
  final AppError? error;

  DashboardState copyWith({
    bool? loading,
    double? totalSpent,
    double? totalIncome,
    double? netBalance,
    Map<TransactionCategory, double>? categoryBreakdown,
    AppError? error,
  }) {
    return DashboardState(
      loading: loading ?? this.loading,
      totalSpent: totalSpent ?? this.totalSpent,
      totalIncome: totalIncome ?? this.totalIncome,
      netBalance: netBalance ?? this.netBalance,
      categoryBreakdown: categoryBreakdown ?? this.categoryBreakdown,
      error: error ?? this.error,
    );
  }
}
