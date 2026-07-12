import 'package:xml/xml.dart';

import '../models/vehicle.dart';
import '../services/xml_service.dart';

abstract class IVehicleRepository {
  Future<List<Vehicle>> loadVehicles();

  Future<void> saveVehicles(List<Vehicle> vehicles);

  Future<void> addVehicle(Vehicle vehicle);

  Future<void> updateVehicle(Vehicle vehicle);

  Future<void> deleteVehicle(String id);
}

class VehicleRepository implements IVehicleRepository {
  final XmlService _xmlService;

  VehicleRepository(this._xmlService);

  @override
  Future<List<Vehicle>> loadVehicles() async {
    final xmlString = await _xmlService.readXml();

    final document = XmlDocument.parse(xmlString);

    final vehiclesNode = document.rootElement.getElement('Vehicles');

    if (vehiclesNode == null) {
      return [];
    }

    return vehiclesNode.findElements('Vehicle').map(Vehicle.fromXml).toList();
  }

  @override
  Future<void> saveVehicles(List<Vehicle> vehicles) async {
    final builder = XmlBuilder();

    builder.processing('xml', 'version="1.0" encoding="UTF-8"');

    builder.element(
      'App',
      attributes: {'Version': '2.0'},
      nest: () {
        builder.element(
          'Vehicles',
          nest: () {
            for (final vehicle in vehicles) {
              builder.xml(vehicle.toXml().toXmlString(pretty: true));
            }
          },
        );
      },
    );

    final document = builder.buildDocument();

    await _xmlService.writeXml(document.toXmlString(pretty: true));
  }

  @override
  Future<void> addVehicle(Vehicle vehicle) async {
    final vehicles = await loadVehicles();

    vehicles.add(vehicle);

    await saveVehicles(vehicles);
  }

  @override
  Future<void> updateVehicle(Vehicle vehicle) async {
    final vehicles = await loadVehicles();

    final index = vehicles.indexWhere((v) => v.id == vehicle.id);

    if (index == -1) return;

    vehicles[index] = vehicle;

    await saveVehicles(vehicles);
  }

  @override
  Future<void> deleteVehicle(String id) async {
    final vehicles = await loadVehicles();

    vehicles.removeWhere((v) => v.id == id);

    await saveVehicles(vehicles);
  }
}
