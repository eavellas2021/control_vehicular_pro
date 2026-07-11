import 'package:flutter/material.dart';

import '../models/vehicle.dart';
import '../models/vehicle_form_model.dart';

class VehicleDialog extends StatefulWidget {
  final Vehicle? vehicle;

  const VehicleDialog({super.key, this.vehicle});

  @override
  State<VehicleDialog> createState() => _VehicleDialogState();
}

class _VehicleDialogState extends State<VehicleDialog> {
  final _formKey = GlobalKey<FormState>();

  late VehicleFormModel form;

  late final TextEditingController nameController;
  late final TextEditingController brandController;
  late final TextEditingController lineController;
  late final TextEditingController modelController;
  late final TextEditingController plateController;
  late final TextEditingController yearController;
  late final TextEditingController colorController;
  late final TextEditingController vinController;
  late final TextEditingController engineController;
  late final TextEditingController fuelController;
  late final TextEditingController kmController;
  late final TextEditingController valueController;
  late final TextEditingController notesController;

  @override
  void initState() {
    super.initState();

    form = widget.vehicle == null
        ? VehicleFormModel()
        : VehicleFormModel.fromVehicle(widget.vehicle!);

    nameController = TextEditingController(text: form.name);
    brandController = TextEditingController(text: form.brand);
    lineController = TextEditingController(text: form.line);
    modelController = TextEditingController(text: form.modelName);
    plateController = TextEditingController(text: form.plate);
    yearController = TextEditingController(
      text: form.year == 0 ? '' : form.year.toString(),
    );
    colorController = TextEditingController(text: form.color);
    vinController = TextEditingController(text: form.vin);
    engineController = TextEditingController(text: form.engine);
    fuelController = TextEditingController(text: form.fuelType);
    kmController = TextEditingController(
      text: form.currentKm == 0 ? '' : form.currentKm.toString(),
    );
    valueController = TextEditingController(
      text: form.purchaseValue == 0 ? '' : form.purchaseValue.toString(),
    );
    notesController = TextEditingController(text: form.notes);
  }

  @override
  void dispose() {
    nameController.dispose();
    brandController.dispose();
    lineController.dispose();
    modelController.dispose();
    plateController.dispose();
    yearController.dispose();
    colorController.dispose();
    vinController.dispose();
    engineController.dispose();
    fuelController.dispose();
    kmController.dispose();
    valueController.dispose();
    notesController.dispose();

    super.dispose();
  }

  void _save() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    form.name = nameController.text;
    form.brand = brandController.text;
    form.line = lineController.text;
    form.modelName = modelController.text;
    form.plate = plateController.text.toUpperCase();
    form.year = int.tryParse(yearController.text) ?? 0;
    form.color = colorController.text;
    form.vin = vinController.text.toUpperCase();
    form.engine = engineController.text;
    form.fuelType = fuelController.text;
    form.currentKm = int.tryParse(kmController.text) ?? 0;
    form.purchaseValue =
        double.tryParse(valueController.text.replaceAll(',', '.')) ?? 0;
    form.notes = notesController.text;

    Navigator.pop(context, form.toVehicle());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.vehicle == null ? 'Nuevo vehículo' : 'Editar vehículo',
        ),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              _title("Información general"),

              _text(controller: nameController, label: "Nombre"),

              _text(controller: brandController, label: "Marca"),

              _text(controller: lineController, label: "Línea"),

              _text(controller: modelController, label: "Modelo"),

              _text(controller: plateController, label: "Placa"),

              _text(
                controller: yearController,
                label: "Año",
                keyboard: TextInputType.number,
              ),

              const SizedBox(height: 20),

              _title("Información técnica"),

              _text(controller: vinController, label: "VIN"),

              _text(controller: engineController, label: "Motor"),

              _text(controller: fuelController, label: "Combustible"),

              _text(controller: colorController, label: "Color"),

              _text(
                controller: kmController,
                label: "Kilometraje",
                keyboard: TextInputType.number,
              ),

              const SizedBox(height: 20),

              _title("Compra"),

              _text(
                controller: valueController,
                label: "Valor de compra",
                keyboard: const TextInputType.numberWithOptions(decimal: true),
              ),

              const SizedBox(height: 20),

              _title("Observaciones"),

              _text(
                controller: notesController,
                label: "Observaciones",
                maxLines: 4,
              ),

              const SizedBox(height: 30),

              FilledButton.icon(
                onPressed: _save,
                icon: const Icon(Icons.save),
                label: const Text("Guardar vehículo"),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _title(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10, top: 12),
      child: Text(text, style: Theme.of(context).textTheme.titleLarge),
    );
  }

  Widget _text({
    required TextEditingController controller,
    required String label,
    int maxLines = 1,
    TextInputType keyboard = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        keyboardType: keyboard,
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'Campo obligatorio';
          }
          return null;
        },
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}
