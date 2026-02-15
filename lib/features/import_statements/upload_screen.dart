import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../app/localization/app_strings.dart';

class UploadScreen extends StatelessWidget {
  const UploadScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.uploadTitle)),
      body: Center(
        child: ElevatedButton(
          onPressed: () => context.goNamed('analyzing'),
          child: const Text(AppStrings.continueAction),
        ),
      ),
    );
  }
}
