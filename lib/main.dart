import 'package:flutter/material.dart';

import 'utils/app_theme.dart';
import 'utils/constants.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const VehicleControlApp());
}

class VehicleControlApp extends StatelessWidget {
  const VehicleControlApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppConstants.appName,
      theme: AppTheme.darkTheme,
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Control Vehicular Pro")),

      body: const Center(
        child: Text(
          "Versión 0.2.0\n\nArquitectura iniciada",

          textAlign: TextAlign.center,

          style: TextStyle(fontSize: 22),
        ),
      ),
    );
  }
}
