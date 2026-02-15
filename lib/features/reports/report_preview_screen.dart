import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:printing/printing.dart';

import '../../app/localization/app_strings.dart';
import 'report_controller.dart';

class ReportPreviewScreen extends ConsumerStatefulWidget {
  const ReportPreviewScreen({super.key});

  @override
  ConsumerState<ReportPreviewScreen> createState() =>
      _ReportPreviewScreenState();
}

class _ReportPreviewScreenState extends ConsumerState<ReportPreviewScreen> {
  @override
  void initState() {
    super.initState();
    Future<void>.microtask(() {
      ref.read(reportControllerProvider.notifier).loadAccess();
    });
  }

  @override
  Widget build(BuildContext context) {
    final reportState = ref.watch(reportControllerProvider);

    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.reportPreviewTitle)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (!reportState.isProUnlocked) const Text(AppStrings.proRequired),
            if (reportState.isProUnlocked)
              ElevatedButton(
                onPressed: reportState.exporting
                    ? null
                    : () async {
                        await ref
                            .read(reportControllerProvider.notifier)
                            .exportCurrentMonthReport();
                        final bytes =
                            ref.read(reportControllerProvider).pdfBytes;
                        if (bytes != null && context.mounted) {
                          await Printing.sharePdf(
                            bytes: bytes,
                            filename: 'reporte-financiero.pdf',
                          );
                        }
                      },
                child: Text(
                  reportState.exporting
                      ? AppStrings.generatingPdf
                      : AppStrings.exportPdf,
                ),
              ),
            if (reportState.errorMessage != null) ...<Widget>[
              const SizedBox(height: 12),
              Text(reportState.errorMessage!),
            ],
          ],
        ),
      ),
    );
  }
}
