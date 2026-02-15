import '../../app/localization/message_key.dart';
import '../../core/models/app_error.dart';

enum ImportStatus { idle, loading, success, failure }

class ImportState {
  const ImportState({required this.status, this.messageKey, this.error});

  const ImportState.initial()
      : status = ImportStatus.idle,
        messageKey = null,
        error = null;

  final ImportStatus status;
  final MessageKey? messageKey;
  final AppError? error;

  ImportState copyWith({
    ImportStatus? status,
    MessageKey? messageKey,
    AppError? error,
  }) {
    return ImportState(
      status: status ?? this.status,
      messageKey: messageKey ?? this.messageKey,
      error: error ?? this.error,
    );
  }
}
