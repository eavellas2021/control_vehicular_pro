import 'vehicle.dart';

/// Modelo utilizado únicamente por el formulario de creación y edición
/// de vehículos.
///
/// La idea es que el diálogo trabaje sobre este modelo y únicamente al
/// presionar "Guardar" se genere un objeto Vehicle.
class VehicleFormModel {
  String id;

  String name;

  String brand;

  String line;

  String modelName;

  String plate;

  int year;

  String color;

  String vin;

  String engine;

  String fuelType;

  int currentKm;

  DateTime? purchaseDate;

  double purchaseValue;

  String imagePath;

  String notes;

  VehicleFormModel({
    this.id = '',
    this.name = '',
    this.brand = '',
    this.line = '',
    this.modelName = '',
    this.plate = '',
    this.year = 0,
    this.color = '',
    this.vin = '',
    this.engine = '',
    this.fuelType = '',
    this.currentKm = 0,
    this.purchaseDate,
    this.purchaseValue = 0,
    this.imagePath = '',
    this.notes = '',
  });

  /// Crea el formulario a partir de un vehículo existente.
  factory VehicleFormModel.fromVehicle(Vehicle vehicle) {
    return VehicleFormModel(
      id: vehicle.id,
      name: vehicle.name,
      brand: vehicle.brand,
      line: vehicle.line,
      modelName: vehicle.model,
      plate: vehicle.plate,
      year: vehicle.year,
      color: vehicle.color,
      vin: vehicle.vin,
      engine: vehicle.engine,
      fuelType: vehicle.fuelType,
      currentKm: vehicle.currentKm,
      purchaseDate: vehicle.purchaseDate,
      purchaseValue: vehicle.purchaseValue,
      imagePath: vehicle.imagePath,
      notes: vehicle.notes,
    );
  }

  /// Convierte el formulario nuevamente en un Vehicle.
  Vehicle toVehicle() {
    final now = DateTime.now();

    return Vehicle(
      id: id,
      name: name.trim(),
      brand: brand.trim(),
      line: line.trim(),
      model: modelName.trim(),
      plate: plate.trim().toUpperCase(),
      year: year,
      color: color.trim(),
      vin: vin.trim().toUpperCase(),
      engine: engine.trim(),
      fuelType: fuelType.trim(),
      currentKm: currentKm,
      purchaseDate: purchaseDate,
      purchaseValue: purchaseValue,
      imagePath: imagePath,
      notes: notes.trim(),
      createdAt: now,
      updatedAt: now,
    );
  }

  bool get isEditing => id.isNotEmpty;

  bool get isNew => id.isEmpty;

  bool get isValidName => name.trim().isNotEmpty;

  bool get isValidBrand => brand.trim().isNotEmpty;

  bool get isValidPlate => plate.trim().isNotEmpty;

  bool get isValidYear => year > 1900;

  bool get isValid =>
      isValidName && isValidBrand && isValidPlate && isValidYear;

  void clear() {
    id = '';
    name = '';
    brand = '';
    line = '';
    modelName = '';
    plate = '';
    year = 0;
    color = '';
    vin = '';
    engine = '';
    fuelType = '';
    currentKm = 0;
    purchaseDate = null;
    purchaseValue = 0;
    imagePath = '';
    notes = '';
  }
}
