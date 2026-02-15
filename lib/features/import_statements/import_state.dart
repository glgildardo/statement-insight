import '../../core/models/app_error.dart';

enum ImportStatus { idle, loading, success, failure }

class ImportState {
  const ImportState({required this.status, this.messageEs, this.error});

  const ImportState.initial()
      : status = ImportStatus.idle,
        messageEs = null,
        error = null;

  final ImportStatus status;
  final String? messageEs;
  final AppError? error;

  ImportState copyWith({
    ImportStatus? status,
    String? messageEs,
    AppError? error,
  }) {
    return ImportState(
      status: status ?? this.status,
      messageEs: messageEs ?? this.messageEs,
      error: error ?? this.error,
    );
  }
}
