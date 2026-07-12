import 'package:flutter/foundation.dart';

import '../models/vehicle.dart';
import '../repositories/vehicle_repository.dart';

class VehicleController extends ChangeNotifier {
  final IVehicleRepository _repository;

  VehicleController(this._repository);

  final List<Vehicle> _vehicles = [];

  bool _isLoading = false;

  String _searchText = '';

  bool get isLoading => _isLoading;

  String get searchText => _searchText;

  List<Vehicle> get vehicles {
    if (_searchText.isEmpty) {
      return List.unmodifiable(_vehicles);
    }

    final filter = _searchText.toLowerCase();

    return _vehicles.where((v) {
      return v.name.toLowerCase().contains(filter) ||
          v.brand.toLowerCase().contains(filter) ||
          v.line.toLowerCase().contains(filter) ||
          v.model.toLowerCase().contains(filter) ||
          v.plate.toLowerCase().contains(filter);
    }).toList();
  }

  Future<void> initialize() async {
    await loadVehicles();
  }

  Future<void> loadVehicles() async {
    _isLoading = true;
    notifyListeners();

    _vehicles
      ..clear()
      ..addAll(await _repository.loadVehicles());

    _isLoading = false;
    notifyListeners();
  }

  Future<void> addVehicle(Vehicle vehicle) async {
    await _repository.addVehicle(vehicle);

    await loadVehicles();
  }

  Future<void> updateVehicle(Vehicle vehicle) async {
    await _repository.updateVehicle(vehicle);

    await loadVehicles();
  }

  Future<void> deleteVehicle(String id) async {
    await _repository.deleteVehicle(id);

    await loadVehicles();
  }

  void search(String value) {
    _searchText = value.trim();

    notifyListeners();
  }

  void clearSearch() {
    _searchText = '';

    notifyListeners();
  }

  void sortByPlate() {
    _vehicles.sort((a, b) => a.plate.compareTo(b.plate));

    notifyListeners();
  }

  void sortByBrand() {
    _vehicles.sort((a, b) => a.brand.compareTo(b.brand));

    notifyListeners();
  }

  void sortByYear() {
    _vehicles.sort((a, b) => b.year.compareTo(a.year));

    notifyListeners();
  }

  Future<void> refreshVehicleStatus() async {
    notifyListeners();
  }
}
