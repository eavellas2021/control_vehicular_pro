import 'package:xml/xml.dart';

import '../models/vehicle.dart';
import '../services/xml_service.dart';
import 'package:uuid/uuid.dart';

class VehicleRepository {
  final Uuid _uuid = const Uuid();
  final XmlService _xmlService;

  VehicleRepository(this._xmlService);

  Future<List<Vehicle>> getAll() async {
    final document = await _xmlService.loadDocument();

    final vehiclesNode = document.rootElement.getElement("Vehicles");

    if (vehiclesNode == null) {
      return [];
    }

    return vehiclesNode.findElements("Vehicle").map(Vehicle.fromXml).toList();
  }

  Future<Vehicle?> getById(String id) async {
    final vehicles = await getAll();

    try {
      return vehicles.firstWhere((e) => e.id == id);
    } catch (_) {
      return null;
    }
  }

  Future<bool> existsPlate(String plate) async {
    final vehicles = await getAll();

    return vehicles.any((v) => v.plate.toUpperCase() == plate.toUpperCase());
  }

  Future<bool> existsVin(String vin) async {
    final vehicles = await getAll();

    return vehicles.any((v) => v.vin.toUpperCase() == vin.toUpperCase());
  }

  Future<void> add(Vehicle vehicle) async {
    final document = await _xmlService.loadDocument();

    final vehiclesNode = document.rootElement.getElement("Vehicles");

    if (vehiclesNode == null) {
      throw Exception("Nodo Vehicles no encontrado.");
    }

    final newVehicle = vehicle.copyWith(
      id: _uuid.v4(),
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    vehiclesNode.children.add(newVehicle.toXml());

    await _xmlService.saveDocument(document);
  }

  Future<void> update(Vehicle vehicle) async {
    final document = await _xmlService.loadDocument();

    final vehiclesNode = document.rootElement.getElement("Vehicles");

    if (vehiclesNode == null) {
      throw Exception("Nodo Vehicles no encontrado.");
    }

    final element = vehiclesNode
        .findElements("Vehicle")
        .firstWhere((e) => e.getElement("Id")?.innerText == vehicle.id);

    element.replace(vehicle.copyWith(updatedAt: DateTime.now()).toXml());

    await _xmlService.saveDocument(document);
  }

  Future<void> delete(String id) async {
    final document = await _xmlService.loadDocument();

    final vehiclesNode = document.rootElement.getElement("Vehicles");

    if (vehiclesNode == null) {
      throw Exception("Nodo <Vehicles> no encontrado.");
    }

    final element = vehiclesNode
        .findElements("Vehicle")
        .firstWhere(
          (e) => e.getElement("Id")?.innerText == id,
          orElse: () => throw Exception("Vehículo no encontrado"),
        );

    element.parent?.children.remove(element);

    await _xmlService.saveDocument(document);
  }
}
