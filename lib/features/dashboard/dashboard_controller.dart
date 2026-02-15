import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/localization/message_key.dart';
import '../../app/providers.dart';
import '../../core/models/app_error.dart';
import 'dashboard_state.dart';

final dashboardControllerProvider =
    NotifierProvider<DashboardController, DashboardState>(
  DashboardController.new,
);

class DashboardController extends Notifier<DashboardState> {
  @override
  DashboardState build() => const DashboardState.initial();

  Future<void> load({required DateTime from, required DateTime to}) async {
    state = state.copyWith(loading: true, error: null);

    try {
      final aggregate = await ref
          .read(transactionRepositoryProvider)
          .aggregateForPeriod(from: from, to: to);

      state = state.copyWith(
        loading: false,
        totalSpent: aggregate.totalSpent,
        totalIncome: aggregate.totalIncome,
        netBalance: aggregate.netBalance,
        categoryBreakdown: aggregate.byCategory,
      );
    } catch (_) {
      state = state.copyWith(
        loading: false,
        error: const AppError(
          code: 'dashboard_load_error',
          messageKey: MessageKey.dashboardLoadError,
        ),
      );
    }
  }
}
