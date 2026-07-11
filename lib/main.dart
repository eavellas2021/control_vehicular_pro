import 'package:flutter/material.dart';

import 'screens/dashboard_screen.dart';
import 'utils/app_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const ControlVehicularApp());
}

class ControlVehicularApp extends StatelessWidget {
  const ControlVehicularApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Control Vehicular Pro',
      theme: AppTheme.darkTheme,
      home: const DashboardScreen(),
    );
  }
}
