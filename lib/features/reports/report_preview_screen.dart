import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/localization/app_strings.dart';
import 'report_controller.dart';

class ReportPreviewScreen extends ConsumerWidget {
  const ReportPreviewScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final canExport = ref.watch(reportControllerProvider);

    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.reportPreviewTitle)),
      body: Center(
        child: canExport
            ? const Text(AppStrings.exportPdf)
            : const Text(AppStrings.proRequired),
      ),
    );
  }
}
