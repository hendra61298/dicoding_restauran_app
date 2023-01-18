import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'config/theme/app_theme.dart';
import 'core/router/app_router.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);
  static final GoRouter appRouter = AppRouter().router();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routeInformationProvider: appRouter.routeInformationProvider,
      routeInformationParser: appRouter.routeInformationParser,
      routerDelegate: appRouter.routerDelegate,
      theme: AppTheme.themeData,
    );
  }
}
