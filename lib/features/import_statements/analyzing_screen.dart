import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../app/localization/app_strings.dart';

class AnalyzingScreen extends StatelessWidget {
  const AnalyzingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.analyzingTitle)),
      body: Center(
        child: ElevatedButton(
          onPressed: () => context.goNamed('dashboard'),
          child: const Text(AppStrings.viewDashboard),
        ),
      ),
    );
  }
}
