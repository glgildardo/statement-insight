import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/localization/app_strings.dart';
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
    state = state.copyWith(isUnlocked: isUnlocked, errorMessage: null);
  }

  Future<void> restorePurchases() async {
    state = state.copyWith(loading: true, errorMessage: null);
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
        errorMessage: AppStrings.restorePurchaseError,
      );
    }
  }
}
