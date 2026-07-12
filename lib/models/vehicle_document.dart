import 'package:xml/xml.dart';

enum DocumentStatus { valid, warning, expired }

class VehicleDocument {
  final String id;

  /// Tipo parametrizable
  final String type;

  /// Número del documento
  final String number;

  /// Fecha de expedición
  final DateTime issueDate;

  /// Fecha de vencimiento
  final DateTime expirationDate;

  /// Días antes para generar alerta
  final int alertDays;

  /// Ruta del archivo PDF o imagen
  final String filePath;

  /// Observaciones
  final String notes;

  /// Fecha de creación
  final DateTime createdAt;

  /// Fecha de modificación
  final DateTime updatedAt;

  const VehicleDocument({
    required this.id,
    required this.type,
    required this.number,
    required this.issueDate,
    required this.expirationDate,
    required this.alertDays,
    required this.filePath,
    required this.notes,
    required this.createdAt,
    required this.updatedAt,
  });

  VehicleDocument copyWith({
    String? id,
    String? type,
    String? number,
    DateTime? issueDate,
    DateTime? expirationDate,
    int? alertDays,
    String? filePath,
    String? notes,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return VehicleDocument(
      id: id ?? this.id,
      type: type ?? this.type,
      number: number ?? this.number,
      issueDate: issueDate ?? this.issueDate,
      expirationDate: expirationDate ?? this.expirationDate,
      alertDays: alertDays ?? this.alertDays,
      filePath: filePath ?? this.filePath,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  //====================================================
  // PROPIEDADES CALCULADAS
  //====================================================

  int get daysRemaining {
    return expirationDate.difference(DateTime.now()).inDays;
  }

  bool get isExpired {
    return daysRemaining < 0;
  }

  bool get isNearExpiration {
    return !isExpired && daysRemaining <= alertDays;
  }

  DocumentStatus get status {
    if (isExpired) {
      return DocumentStatus.expired;
    }

    if (isNearExpiration) {
      return DocumentStatus.warning;
    }

    return DocumentStatus.valid;
  }

  //====================================================
  // XML
  //====================================================

  XmlElement toXml() {
    return XmlElement(XmlName('Document'), [], [
      _node('Id', id),
      _node('Type', type),
      _node('Number', number),
      _node('IssueDate', issueDate.toIso8601String()),
      _node('ExpirationDate', expirationDate.toIso8601String()),
      _node('AlertDays', alertDays.toString()),
      _node('FilePath', filePath),
      _node('Notes', notes),
      _node('CreatedAt', createdAt.toIso8601String()),
      _node('UpdatedAt', updatedAt.toIso8601String()),
    ]);
  }

  factory VehicleDocument.fromXml(XmlElement xml) {
    return VehicleDocument(
      id: _value(xml, 'Id'),
      type: _value(xml, 'Type'),
      number: _value(xml, 'Number'),
      issueDate: DateTime.parse(_value(xml, 'IssueDate')),
      expirationDate: DateTime.parse(_value(xml, 'ExpirationDate')),
      alertDays: int.tryParse(_value(xml, 'AlertDays')) ?? 30,
      filePath: _value(xml, 'FilePath'),
      notes: _value(xml, 'Notes'),
      createdAt: DateTime.parse(_value(xml, 'CreatedAt')),
      updatedAt: DateTime.parse(_value(xml, 'UpdatedAt')),
    );
  }

  static XmlElement _node(String tag, String value) {
    return XmlElement(XmlName(tag), [], [XmlText(value)]);
  }

  static String _value(XmlElement xml, String tag) {
    final node = xml.getElement(tag);

    if (node == null) {
      return '';
    }

    return node.innerText;
  }

  @override
  String toString() {
    return '$type - $number';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is VehicleDocument &&
            runtimeType == other.runtimeType &&
            id == other.id;
  }

  @override
  int get hashCode => id.hashCode;
}
