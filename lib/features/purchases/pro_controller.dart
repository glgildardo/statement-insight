import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/providers.dart';

final proControllerProvider = NotifierProvider<ProController, bool>(
  ProController.new,
);

class ProController extends Notifier<bool> {
  @override
  bool build() => false;

  Future<void> restorePurchases() async {
    final isUnlocked =
        await ref.read(settingsRepositoryProvider).isProUnlocked();
    state = isUnlocked;
  }
}
