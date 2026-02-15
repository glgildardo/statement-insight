import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/localization/localization_mapper.dart';
import 'pro_controller.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final proState = ref.watch(proControllerProvider);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.settingsTitle)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              proState.isUnlocked ? l10n.proEnabled : l10n.proDisabled,
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: proState.loading
                  ? null
                  : () {
                      ref
                          .read(proControllerProvider.notifier)
                          .restorePurchases();
                    },
              child: Text(
                proState.loading
                    ? l10n.restoringPurchases
                    : l10n.restorePurchases,
              ),
            ),
            if (proState.errorKey != null) ...<Widget>[
              const SizedBox(height: 12),
              Text(l10n.message(proState.errorKey!)),
            ],
          ],
        ),
      ),
    );
  }
}
