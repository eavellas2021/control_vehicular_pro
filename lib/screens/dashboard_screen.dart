import 'package:flutter/material.dart';

import 'vehicles_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = const [
    VehiclesScreen(),

    Center(
      child: Text('Documentos\n(Próximamente)', textAlign: TextAlign.center),
    ),

    Center(
      child: Text(
        'Mantenimientos\n(Próximamente)',
        textAlign: TextAlign.center,
      ),
    ),

    Center(child: Text('Alertas\n(Próximamente)', textAlign: TextAlign.center)),

    Center(
      child: Text('Configuración\n(Próximamente)', textAlign: TextAlign.center),
    ),
  ];

  final List<String> _titles = [
    'Vehículos',

    'Documentos',

    'Mantenimientos',

    'Alertas',

    'Configuración',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_titles[_selectedIndex]), centerTitle: true),

      body: _pages[_selectedIndex],

      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,

        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.directions_car),
            label: 'Vehículos',
          ),

          NavigationDestination(icon: Icon(Icons.description), label: 'Docs'),

          NavigationDestination(icon: Icon(Icons.build), label: 'Mant.'),

          NavigationDestination(icon: Icon(Icons.warning), label: 'Alertas'),

          NavigationDestination(icon: Icon(Icons.settings), label: 'Config.'),
        ],

        onDestinationSelected: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
