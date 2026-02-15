import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:statement_insight/app/l10n/app_localizations.dart';

class AnalyzingScreen extends StatelessWidget {
  const AnalyzingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.analyzingTitle)),
      body: Center(
        child: ElevatedButton(
          onPressed: () => context.goNamed('dashboard'),
          child: Text(l10n.viewDashboard),
        ),
      ),
    );
  }
}
