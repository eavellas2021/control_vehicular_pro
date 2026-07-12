import 'package:flutter/foundation.dart';

import '../models/vehicle_document.dart';
import '../repositories/document_repository.dart';

class DocumentController extends ChangeNotifier {
  final IDocumentRepository _repository;

  DocumentController(this._repository);

  final List<VehicleDocument> _documents = [];

  bool _isLoading = false;

  String _searchText = '';

  bool get isLoading => _isLoading;

  String get searchText => _searchText;

  List<VehicleDocument> get documents {
    if (_searchText.isEmpty) {
      return List.unmodifiable(_documents);
    }

    final filter = _searchText.toLowerCase();

    return _documents.where((document) {
      return document.type.toLowerCase().contains(filter) ||
          document.number.toLowerCase().contains(filter) ||
          document.notes.toLowerCase().contains(filter);
    }).toList();
  }

  Future<void> loadDocuments(String vehicleId) async {
    _isLoading = true;
    notifyListeners();

    _documents.clear();

    _documents.addAll(await _repository.getDocuments(vehicleId));

    _isLoading = false;
    notifyListeners();
  }

  Future<void> addDocument(String vehicleId, VehicleDocument document) async {
    await _repository.addDocument(vehicleId, document);

    _documents.add(document);

    notifyListeners();
  }

  Future<void> updateDocument(
    String vehicleId,
    VehicleDocument document,
  ) async {
    await _repository.updateDocument(vehicleId, document);

    final index = _documents.indexWhere((d) => d.id == document.id);

    if (index != -1) {
      _documents[index] = document;
    }

    notifyListeners();
  }

  Future<void> deleteDocument(String vehicleId, String documentId) async {
    await _repository.deleteDocument(vehicleId, documentId);

    _documents.removeWhere((d) => d.id == documentId);

    notifyListeners();
  }

  void search(String value) {
    _searchText = value.trim();

    notifyListeners();
  }

  void clearSearch() {
    _searchText = '';

    notifyListeners();
  }

  VehicleDocument? findById(String id) {
    try {
      return _documents.firstWhere((d) => d.id == id);
    } catch (_) {
      return null;
    }
  }

  int get totalDocuments => _documents.length;

  int get validDocuments =>
      _documents.where((d) => d.status == DocumentStatus.valid).length;

  int get warningDocuments =>
      _documents.where((d) => d.status == DocumentStatus.warning).length;

  int get expiredDocuments =>
      _documents.where((d) => d.status == DocumentStatus.expired).length;
}
