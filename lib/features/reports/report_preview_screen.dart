import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:printing/printing.dart';

import '../../app/localization/localization_mapper.dart';
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
    final l10n = AppLocalizations.of(context)!;
    final reportState = ref.watch(reportControllerProvider);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.reportPreviewTitle)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (!reportState.isProUnlocked) Text(l10n.proRequired),
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
                  reportState.exporting ? l10n.generatingPdf : l10n.exportPdf,
                ),
              ),
            if (reportState.errorKey != null) ...<Widget>[
              const SizedBox(height: 12),
              Text(l10n.message(reportState.errorKey!)),
            ],
          ],
        ),
      ),
    );
  }
}
