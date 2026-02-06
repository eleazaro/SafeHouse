import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'config/theme/app_theme.dart';
import 'data/repositories/property_repository.dart';
import 'routing/app_router.dart';

void main() {
  runApp(const SafeHouseApp());
}

class SafeHouseApp extends StatelessWidget {
  const SafeHouseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<PropertyRepository>(
          create: (_) => MockPropertyRepository(),
        ),
      ],
      child: MaterialApp.router(
        title: 'SafeHouse',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.darkTheme,
        routerConfig: AppRouter.router,
      ),
    );
  }
}
