import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/providers.dart';

final reportControllerProvider = NotifierProvider<ReportController, bool>(
  ReportController.new,
);

class ReportController extends Notifier<bool> {
  @override
  bool build() => false;

  Future<void> canExport() async {
    final isPro = await ref.read(settingsRepositoryProvider).isProUnlocked();
    state = isPro;
  }
}
