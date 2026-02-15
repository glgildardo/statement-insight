class AppError {
  const AppError({
    required this.code,
    required this.messageEs,
    this.debugDetails,
  });

  final String code;
  final String messageEs;
  final String? debugDetails;
}
