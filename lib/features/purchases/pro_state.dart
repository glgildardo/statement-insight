import '../../app/localization/message_key.dart';

class ProState {
  const ProState({
    required this.loading,
    required this.isUnlocked,
    this.errorKey,
  });

  const ProState.initial()
      : loading = false,
        isUnlocked = false,
        errorKey = null;

  final bool loading;
  final bool isUnlocked;
  final MessageKey? errorKey;

  ProState copyWith({
    bool? loading,
    bool? isUnlocked,
    MessageKey? errorKey,
  }) {
    return ProState(
      loading: loading ?? this.loading,
      isUnlocked: isUnlocked ?? this.isUnlocked,
      errorKey: errorKey,
    );
  }
}
