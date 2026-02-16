import 'dart:typed_data';

import '../../app/localization/message_key.dart';

class ReportState {
  const ReportState({
    required this.loading,
    required this.exporting,
    required this.isProUnlocked,
    this.errorKey,
    this.pdfBytes,
  });

  const ReportState.initial()
      : loading = false,
        exporting = false,
        isProUnlocked = false,
        errorKey = null,
        pdfBytes = null;

  final bool loading;
  final bool exporting;
  final bool isProUnlocked;
  final MessageKey? errorKey;
  final Uint8List? pdfBytes;

  ReportState copyWith({
    bool? loading,
    bool? exporting,
    bool? isProUnlocked,
    MessageKey? errorKey,
    Uint8List? pdfBytes,
  }) {
    return ReportState(
      loading: loading ?? this.loading,
      exporting: exporting ?? this.exporting,
      isProUnlocked: isProUnlocked ?? this.isProUnlocked,
      errorKey: errorKey,
      pdfBytes: pdfBytes ?? this.pdfBytes,
    );
  }
}
