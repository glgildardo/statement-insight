import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../app/localization/app_strings.dart';
import '../../app/providers.dart';
import 'report_state.dart';

final reportControllerProvider =
    NotifierProvider<ReportController, ReportState>(
  ReportController.new,
);

class ReportController extends Notifier<ReportState> {
  @override
  ReportState build() => const ReportState.initial();

  Future<void> loadAccess() async {
    state = state.copyWith(loading: true, errorMessage: null);
    final isPro = await ref.read(settingsRepositoryProvider).isProUnlocked();
    state = state.copyWith(loading: false, isProUnlocked: isPro);
  }

  Future<void> exportCurrentMonthReport() async {
    if (!state.isProUnlocked) {
      state = state.copyWith(
        errorMessage: AppStrings.proRequired,
      );
      return;
    }

    state = state.copyWith(exporting: true, errorMessage: null, pdfBytes: null);
    try {
      final now = DateTime.now();
      final start = DateTime(now.year, now.month, 1);
      final end = now;

      final transactionRepository = ref.read(transactionRepositoryProvider);
      final aggregate = await transactionRepository.aggregateForPeriod(
        from: start,
        to: end,
      );
      final topExpenses = await transactionRepository.topExpensesForPeriod(
        from: start,
        to: end,
      );
      final generator = ref.read(reportPdfGeneratorProvider);

      final formatter = NumberFormat.currency(locale: 'es_GT', symbol: 'Q');
      final pdf = await generator.generate(
        periodStart: start,
        periodEnd: end,
        totalSpent: aggregate.totalSpent,
        totalIncome: aggregate.totalIncome,
        net: aggregate.netBalance,
        categoryBreakdown: aggregate.byCategory.map(
          (key, value) => MapEntry(key.name, value),
        ),
        topExpenses: topExpenses
            .map((item) =>
                '${item.description}: ${formatter.format(item.amount)}')
            .toList(),
      );

      state = state.copyWith(exporting: false, pdfBytes: pdf);
    } catch (_) {
      state = state.copyWith(
        exporting: false,
        errorMessage: AppStrings.reportGenerateError,
      );
    }
  }
}
