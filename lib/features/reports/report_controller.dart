import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'dart:typed_data';

import '../../app/localization/message_key.dart';
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
    state = state.copyWith(loading: true, errorKey: null);
    final isPro = await ref.read(settingsRepositoryProvider).isProUnlocked();
    state = state.copyWith(loading: false, isProUnlocked: isPro);
  }

  Future<void> exportCurrentMonthReport() async {
    if (!state.isProUnlocked) {
      state = state.copyWith(
        errorKey: MessageKey.proRequired,
      );
      return;
    }

    state = state.copyWith(exporting: true, errorKey: null, pdfBytes: null);
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

      state = state.copyWith(
        exporting: false,
        pdfBytes: Uint8List.fromList(pdf),
      );
    } catch (_) {
      state = state.copyWith(
        exporting: false,
        errorKey: MessageKey.reportGenerateError,
      );
    }
  }
}
