import 'package:flutter/material.dart';

import '../models/vehicle_document.dart';

class DocumentDialog extends StatefulWidget {
  final VehicleDocument? document;

  const DocumentDialog({super.key, this.document});

  @override
  State<DocumentDialog> createState() => _DocumentDialogState();
}

class _DocumentDialogState extends State<DocumentDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Documento'),
      content: const Text('DocumentDialog en construcción...'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cerrar'),
        ),
      ],
    );
  }
}
