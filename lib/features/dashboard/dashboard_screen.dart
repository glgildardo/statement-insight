import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:statement_insight/app/l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/models/transaction_category.dart';
import 'dashboard_controller.dart';

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  @override
  void initState() {
    super.initState();
    Future<void>.microtask(() {
      final now = DateTime.now();
      ref
          .read(dashboardControllerProvider.notifier)
          .load(from: DateTime(now.year, now.month, 1), to: now);
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final state = ref.watch(dashboardControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.dashboardTitle),
        actions: <Widget>[
          IconButton(
            onPressed: () => context.goNamed('report-preview'),
            icon: const Icon(Icons.picture_as_pdf_outlined),
          ),
          IconButton(
            onPressed: () => context.goNamed('settings'),
            icon: const Icon(Icons.settings_outlined),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _MetricCard(label: l10n.totalSpent, value: state.totalSpent),
            _MetricCard(label: l10n.totalIncome, value: state.totalIncome),
            _MetricCard(label: l10n.netBalance, value: state.netBalance),
            const SizedBox(height: 12),
            Expanded(
              child: PieChart(
                PieChartData(
                    sections: _toSections(l10n, state.categoryBreakdown)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<PieChartSectionData> _toSections(
    AppLocalizations l10n,
    Map<TransactionCategory, double> values,
  ) {
    if (values.isEmpty) {
      return <PieChartSectionData>[
        PieChartSectionData(
          color: Colors.grey,
          title: l10n.noData,
          value: 1,
        ),
      ];
    }

    return values.entries
        .map(
          (entry) =>
              PieChartSectionData(value: entry.value, title: entry.key.name),
        )
        .toList();
  }
}

class _MetricCard extends StatelessWidget {
  const _MetricCard({required this.label, required this.value});

  final String label;
  final double value;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(label),
        trailing: Text(value.toStringAsFixed(2)),
      ),
    );
  }
}
