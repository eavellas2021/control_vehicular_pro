import 'dart:io';

import 'package:flutter/material.dart';

import '../models/vehicle.dart';

class VehicleCard extends StatelessWidget {
  final Vehicle vehicle;

  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  final VoidCallback? onDocuments;
  final VoidCallback? onMaintenance;

  const VehicleCard({
    super.key,
    required this.vehicle,
    this.onEdit,
    this.onDelete,
    this.onDocuments,
    this.onMaintenance,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                _photo(),

                const SizedBox(width: 16),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        vehicle.name,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 4),

                      Text("${vehicle.brand} ${vehicle.line}"),

                      Text("Modelo ${vehicle.model}"),

                      Text("Placa ${vehicle.plate}"),

                      Text("${vehicle.currentKm} km"),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: onEdit,
                    icon: const Icon(Icons.edit),
                    label: const Text("Editar"),
                  ),
                ),

                const SizedBox(width: 8),

                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: onDocuments,
                    icon: const Icon(Icons.description),
                    label: const Text("Documentos"),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 8),

            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: onMaintenance,
                    icon: const Icon(Icons.build),
                    label: const Text("Mantto"),
                  ),
                ),

                const SizedBox(width: 8),

                Expanded(
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                    onPressed: onDelete,
                    icon: const Icon(Icons.delete),
                    label: const Text("Eliminar"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _photo() {
    if (vehicle.imagePath.isNotEmpty && File(vehicle.imagePath).existsSync()) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.file(
          File(vehicle.imagePath),
          width: 90,
          height: 90,
          fit: BoxFit.cover,
        ),
      );
    }

    return Container(
      width: 90,
      height: 90,
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Icon(Icons.directions_car, size: 42),
    );
  }
}
