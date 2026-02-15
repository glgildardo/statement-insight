import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/localization/app_strings.dart';
import 'pro_controller.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isPro = ref.watch(proControllerProvider);

    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.settingsTitle)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(isPro ? AppStrings.proEnabled : AppStrings.proDisabled),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {
                ref.read(proControllerProvider.notifier).restorePurchases();
              },
              child: const Text(AppStrings.restorePurchases),
            ),
          ],
        ),
      ),
    );
  }
}
