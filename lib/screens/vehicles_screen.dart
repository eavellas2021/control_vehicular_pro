import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controllers/vehicle_controller.dart';
import '../dialogs/vehicle_dialog.dart';
import '../models/vehicle.dart';
import '../widgets/confirm_dialog.dart';
import '../widgets/empty_state.dart';
import '../widgets/search_box.dart';
import '../widgets/vehicle_card.dart';

class VehiclesScreen extends StatelessWidget {
  const VehiclesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<VehicleController>(
      builder: (context, controller, child) {
        return Scaffold(
          appBar: AppBar(title: const Text("Vehículos")),
          body: Column(
            children: [
              SearchBox(onChanged: controller.search),
              Expanded(child: _buildBody(context, controller)),
            ],
          ),
          floatingActionButton: FloatingActionButton.extended(
            icon: const Icon(Icons.add),
            label: const Text("Nuevo"),
            onPressed: () => _openVehicleDialog(context),
          ),
        );
      },
    );
  }

  Widget _buildBody(BuildContext context, VehicleController controller) {
    if (controller.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (controller.vehicles.isEmpty) {
      return const EmptyState(
        icon: Icons.directions_car,
        title: "No existen vehículos",
        message: "Pulsa + para registrar el primero.",
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.only(bottom: 80),
      itemCount: controller.vehicles.length,
      itemBuilder: (context, index) {
        final vehicle = controller.vehicles[index];

        return VehicleCard(
          vehicle: vehicle,

          onEdit: () {
            _openVehicleDialog(context, vehicle: vehicle);
          },

          onDelete: () {
            _deleteVehicle(context, controller, vehicle);
          },

          onDocuments: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Módulo de documentos en desarrollo"),
              ),
            );
          },

          onMaintenance: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Módulo de mantenimientos en desarrollo"),
              ),
            );
          },
        );
      },
    );
  }

  Future<void> _openVehicleDialog(
    BuildContext context, {
    Vehicle? vehicle,
  }) async {
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => VehicleDialog(vehicle: vehicle),
    );
  }

  Future<void> _deleteVehicle(
    BuildContext context,
    VehicleController controller,
    Vehicle vehicle,
  ) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (_) => const ConfirmDialog(
        title: "Eliminar vehículo",
        message: "¿Está seguro que desea eliminar este vehículo?",
      ),
    );

    if (result == true) {
      await controller.deleteVehicle(vehicle.id);

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Vehículo eliminado correctamente")),
        );
      }
    }
  }
}
