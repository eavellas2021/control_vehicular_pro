import 'package:flutter/foundation.dart';

import '../models/vehicle.dart';
import '../repositories/vehicle_repository.dart';

class VehicleController extends ChangeNotifier {
  VehicleController(this._repository);

  final VehicleRepository _repository;

  List<Vehicle> _vehicles = [];

  bool _loading = false;

  Vehicle? _selectedVehicle;

  List<Vehicle> get vehicles => List.unmodifiable(_vehicles);

  bool get isLoading => _loading;

  Vehicle? get selectedVehicle => _selectedVehicle;

  int get totalVehicles => _vehicles.length;

  //--------------------------------------------------
  // Inicializar
  //--------------------------------------------------

  Future<void> initialize() async {
    _loading = true;

    notifyListeners();

    _vehicles = await _repository.getAll();

    if (_vehicles.isNotEmpty) {
      _selectedVehicle = _vehicles.first;
    }

    _loading = false;

    notifyListeners();
  }

  //--------------------------------------------------
  // Seleccionar
  //--------------------------------------------------

  void selectVehicle(Vehicle vehicle) {
    _selectedVehicle = vehicle;

    notifyListeners();
  }

  //--------------------------------------------------
  // Crear
  //--------------------------------------------------

  Future<void> addVehicle(Vehicle vehicle) async {
    await _repository.add(vehicle);

    await initialize();
  }

  //--------------------------------------------------
  // Editar
  //--------------------------------------------------

  Future<void> updateVehicle(Vehicle vehicle) async {
    await _repository.update(vehicle);

    await initialize();
  }

  //--------------------------------------------------
  // Eliminar
  //--------------------------------------------------

  Future<void> deleteVehicle(String id) async {
    await _repository.delete(id);

    await initialize();
  }

  //--------------------------------------------------
  // Buscar
  //--------------------------------------------------

  Vehicle? getVehicle(String id) {
    try {
      return _vehicles.firstWhere((e) => e.id == id);
    } catch (_) {
      return null;
    }
  }

  //--------------------------------------------------
  // Validaciones
  //--------------------------------------------------

  Future<bool> existsPlate(String plate) {
    return _repository.existsPlate(plate);
  }

  Future<bool> existsVin(String vin) {
    return _repository.existsVin(vin);
  }

  //--------------------------------------------------
  // Recargar
  //--------------------------------------------------

  Future<void> refresh() async {
    await initialize();
  }
}
