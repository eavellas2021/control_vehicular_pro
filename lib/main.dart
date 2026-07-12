import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'controllers/vehicle_controller.dart';
import 'repositories/vehicle_repository.dart';
import 'screens/dashboard_screen.dart';
import 'services/xml_service.dart';
import 'utils/app_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const ControlVehicularApp());
}

class ControlVehicularApp extends StatelessWidget {
  const ControlVehicularApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<VehicleController>(
          create: (_) => VehicleController(VehicleRepository(XmlService())),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Control Vehicular Pro',
        theme: AppTheme.darkTheme,
        home: const DashboardScreen(),
      ),
    );
  }
}
