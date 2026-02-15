class ReportState {
  const ReportState({
    required this.loading,
    required this.exporting,
    required this.isProUnlocked,
    this.errorMessage,
    this.pdfBytes,
  });

  const ReportState.initial()
      : loading = false,
        exporting = false,
        isProUnlocked = false,
        errorMessage = null,
        pdfBytes = null;

  final bool loading;
  final bool exporting;
  final bool isProUnlocked;
  final String? errorMessage;
  final List<int>? pdfBytes;

  ReportState copyWith({
    bool? loading,
    bool? exporting,
    bool? isProUnlocked,
    String? errorMessage,
    List<int>? pdfBytes,
  }) {
    return ReportState(
      loading: loading ?? this.loading,
      exporting: exporting ?? this.exporting,
      isProUnlocked: isProUnlocked ?? this.isProUnlocked,
      errorMessage: errorMessage,
      pdfBytes: pdfBytes ?? this.pdfBytes,
    );
  }
}
