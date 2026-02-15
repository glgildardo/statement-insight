import '../../app/localization/message_key.dart';

class AppError {
  const AppError(
      {required this.code, required this.messageKey, this.debugDetails});

  final String code;
  final MessageKey messageKey;
  final String? debugDetails;
}
