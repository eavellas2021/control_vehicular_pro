import 'package:flutter/material.dart';

import '../models/vehicle_document.dart';

class DocumentCard extends StatelessWidget {
  final VehicleDocument document;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  final VoidCallback? onTap;

  const DocumentCard({
    super.key,
    required this.document,
    this.onEdit,
    this.onDelete,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Color statusColor;

    IconData statusIcon;

    String statusText;

    switch (document.status) {
      case DocumentStatus.valid:
        statusColor = Colors.green;
        statusIcon = Icons.check_circle;
        statusText = 'Vigente';
        break;

      case DocumentStatus.warning:
        statusColor = Colors.orange;
        statusIcon = Icons.warning;
        statusText = 'Próximo a vencer';
        break;

      case DocumentStatus.expired:
        statusColor = Colors.red;
        statusIcon = Icons.cancel;
        statusText = 'Vencido';
        break;
    }

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(statusIcon, color: statusColor),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      document.type,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Text(
                    statusText,
                    style: TextStyle(
                      color: statusColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              Text("Número: ${document.number}"),

              const SizedBox(height: 4),

              Text(
                "Expedición: ${document.issueDate.day}/${document.issueDate.month}/${document.issueDate.year}",
              ),

              const SizedBox(height: 4),

              Text(
                "Vence: ${document.expirationDate.day}/${document.expirationDate.month}/${document.expirationDate.year}",
              ),

              const SizedBox(height: 4),

              Text("Días restantes: ${document.daysRemaining}"),

              if (document.notes.isNotEmpty) ...[
                const SizedBox(height: 10),
                Text(
                  document.notes,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],

              const Divider(),

              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    tooltip: 'Editar',
                    icon: const Icon(Icons.edit),
                    onPressed: onEdit,
                  ),
                  IconButton(
                    tooltip: 'Eliminar',
                    icon: const Icon(Icons.delete),
                    onPressed: onDelete,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
