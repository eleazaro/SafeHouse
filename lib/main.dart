import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'config/strings/app_strings.dart';
import 'config/theme/app_theme.dart';
import 'data/repositories/auth_repository.dart';
import 'data/repositories/property_repository.dart';
import 'routing/app_router.dart';
import 'ui/auth/view_models/auth_view_model.dart';

void main() {
  runApp(const SafeHouseApp());
}

class SafeHouseApp extends StatelessWidget {
  const SafeHouseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<PropertyRepository>(create: (_) => MockPropertyRepository()),
        Provider<AuthRepository>(create: (_) => MockAuthRepository()),
        ChangeNotifierProvider<AuthViewModel>(
          create: (context) => AuthViewModel(context.read<AuthRepository>()),
        ),
      ],
      child: Builder(
        builder: (context) {
          final authViewModel = context.watch<AuthViewModel>();
          return MaterialApp.router(
            title: AppStrings.appName,
            debugShowCheckedModeBanner: false,
            theme: AppTheme.darkTheme,
            routerConfig: AppRouter.router(authViewModel),
          );
        },
      ),
    );
  }
}
