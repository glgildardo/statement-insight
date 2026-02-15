class ProState {
  const ProState({
    required this.loading,
    required this.isUnlocked,
    this.errorMessage,
  });

  const ProState.initial()
      : loading = false,
        isUnlocked = false,
        errorMessage = null;

  final bool loading;
  final bool isUnlocked;
  final String? errorMessage;

  ProState copyWith({
    bool? loading,
    bool? isUnlocked,
    String? errorMessage,
  }) {
    return ProState(
      loading: loading ?? this.loading,
      isUnlocked: isUnlocked ?? this.isUnlocked,
      errorMessage: errorMessage,
    );
  }
}
