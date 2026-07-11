import 'package:flutter/material.dart';

class VehiclesScreen extends StatelessWidget {
  const VehiclesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: Text(
          'No hay vehículos registrados',
          style: TextStyle(fontSize: 18),
        ),
      ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Aquí conectaremos el VehicleDialog
          // en la siguiente entrega.
        },

        icon: const Icon(Icons.add),

        label: const Text("Nuevo"),
      ),
    );
  }
}
