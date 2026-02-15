import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

class UploadScreen extends StatelessWidget {
  const UploadScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.uploadTitle)),
      body: Center(
        child: ElevatedButton(
          onPressed: () => context.goNamed('analyzing'),
          child: Text(l10n.continueAction),
        ),
      ),
    );
  }
}
