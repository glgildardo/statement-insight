import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../features/dashboard/dashboard_screen.dart';
import '../features/import_statements/analyzing_screen.dart';
import '../features/import_statements/upload_screen.dart';
import '../features/purchases/settings_screen.dart';
import '../features/reports/report_preview_screen.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/upload',
    routes: <RouteBase>[
      GoRoute(
        path: '/upload',
        name: 'upload',
        builder: (context, state) => const UploadScreen(),
      ),
      GoRoute(
        path: '/analyzing',
        name: 'analyzing',
        builder: (context, state) => const AnalyzingScreen(),
      ),
      GoRoute(
        path: '/dashboard',
        name: 'dashboard',
        builder: (context, state) => const DashboardScreen(),
      ),
      GoRoute(
        path: '/settings',
        name: 'settings',
        builder: (context, state) => const SettingsScreen(),
      ),
      GoRoute(
        path: '/report-preview',
        name: 'report-preview',
        builder: (context, state) => const ReportPreviewScreen(),
      ),
    ],
  );
});
