import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'localization/app_strings.dart';
import 'router.dart';

class StatementInsightApp extends ConsumerWidget {
  const StatementInsightApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appRouter = ref.watch(appRouterProvider);

    return MaterialApp.router(
      title: AppStrings.dashboardTitle,
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter,
      supportedLocales: const <Locale>[Locale('es')],
      localizationsDelegates: GlobalMaterialLocalizations.delegates,
      themeMode: ThemeMode.system,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF15616D)),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF15616D),
          brightness: Brightness.dark,
        ),
      ),
    );
  }
}
