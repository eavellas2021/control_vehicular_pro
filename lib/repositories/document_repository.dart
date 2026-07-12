import '../models/vehicle.dart';
import '../models/vehicle_document.dart';
import 'vehicle_repository.dart';

abstract class IDocumentRepository {
  Future<List<VehicleDocument>> getDocuments(String vehicleId);

  Future<void> addDocument(String vehicleId, VehicleDocument document);

  Future<void> updateDocument(String vehicleId, VehicleDocument document);

  Future<void> deleteDocument(String vehicleId, String documentId);
}

class DocumentRepository implements IDocumentRepository {
  final IVehicleRepository _vehicleRepository;

  DocumentRepository(this._vehicleRepository);

  @override
  Future<List<VehicleDocument>> getDocuments(String vehicleId) async {
    final vehicles = await _vehicleRepository.loadVehicles();

    try {
      final vehicle = vehicles.firstWhere((v) => v.id == vehicleId);

      return List.unmodifiable(vehicle.documents);
    } catch (_) {
      return [];
    }
  }

  @override
  Future<void> addDocument(String vehicleId, VehicleDocument document) async {
    final vehicles = await _vehicleRepository.loadVehicles();

    final index = vehicles.indexWhere((v) => v.id == vehicleId);

    if (index == -1) {
      return;
    }

    final vehicle = vehicles[index];

    final documents = List<VehicleDocument>.from(vehicle.documents);

    documents.add(document);

    vehicles[index] = vehicle.copyWith(documents: documents);

    await _vehicleRepository.saveVehicles(vehicles);
  }

  @override
  Future<void> updateDocument(
    String vehicleId,
    VehicleDocument document,
  ) async {
    final vehicles = await _vehicleRepository.loadVehicles();

    final vehicleIndex = vehicles.indexWhere((v) => v.id == vehicleId);

    if (vehicleIndex == -1) {
      return;
    }

    final vehicle = vehicles[vehicleIndex];

    final documents = List<VehicleDocument>.from(vehicle.documents);

    final documentIndex = documents.indexWhere((d) => d.id == document.id);

    if (documentIndex == -1) {
      return;
    }

    documents[documentIndex] = document;

    vehicles[vehicleIndex] = vehicle.copyWith(documents: documents);

    await _vehicleRepository.saveVehicles(vehicles);
  }

  @override
  Future<void> deleteDocument(String vehicleId, String documentId) async {
    final vehicles = await _vehicleRepository.loadVehicles();

    final vehicleIndex = vehicles.indexWhere((v) => v.id == vehicleId);

    if (vehicleIndex == -1) {
      return;
    }

    final vehicle = vehicles[vehicleIndex];

    final documents = List<VehicleDocument>.from(vehicle.documents);

    documents.removeWhere((d) => d.id == documentId);

    vehicles[vehicleIndex] = vehicle.copyWith(documents: documents);

    await _vehicleRepository.saveVehicles(vehicles);
  }

  //==================================================
  // MÉTODOS AUXILIARES
  //==================================================

  Future<Vehicle?> findVehicle(String vehicleId) async {
    final vehicles = await _vehicleRepository.loadVehicles();

    try {
      return vehicles.firstWhere((v) => v.id == vehicleId);
    } catch (_) {
      return null;
    }
  }

  Future<bool> vehicleExists(String vehicleId) async {
    return await findVehicle(vehicleId) != null;
  }

  Future<bool> documentExists(String vehicleId, String documentId) async {
    final vehicle = await findVehicle(vehicleId);

    if (vehicle == null) {
      return false;
    }

    return vehicle.documents.any((d) => d.id == documentId);
  }

  Future<VehicleDocument?> findDocument(
    String vehicleId,
    String documentId,
  ) async {
    final vehicle = await findVehicle(vehicleId);

    if (vehicle == null) {
      return null;
    }

    try {
      return vehicle.documents.firstWhere((d) => d.id == documentId);
    } catch (_) {
      return null;
    }
  }

  Future<int> countDocuments(String vehicleId) async {
    final docs = await getDocuments(vehicleId);

    return docs.length;
  }
}
