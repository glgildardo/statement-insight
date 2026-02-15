import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/localization/message_key.dart';
import '../../app/providers.dart';
import 'pro_state.dart';

final proControllerProvider = NotifierProvider<ProController, ProState>(
  ProController.new,
);

class ProController extends Notifier<ProState> {
  @override
  ProState build() {
    Future<void>.microtask(loadProStatus);
    return const ProState.initial();
  }

  Future<void> loadProStatus() async {
    final isUnlocked =
        await ref.read(settingsRepositoryProvider).isProUnlocked();
    state = state.copyWith(isUnlocked: isUnlocked, errorKey: null);
  }

  Future<void> restorePurchases() async {
    state = state.copyWith(loading: true, errorKey: null);
    try {
      final restored =
          await ref.read(purchaseGatewayProvider).restorePurchases();
      if (restored) {
        await ref.read(settingsRepositoryProvider).setProUnlocked(true);
      }
      final isUnlocked =
          await ref.read(settingsRepositoryProvider).isProUnlocked();
      state = state.copyWith(loading: false, isUnlocked: isUnlocked);
    } catch (_) {
      state = state.copyWith(
        loading: false,
        errorKey: MessageKey.restorePurchaseError,
      );
    }
  }
}
