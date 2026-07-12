import 'package:xml/xml.dart';

class DocumentType {
  /// Identificador único
  final String id;

  /// Nombre visible
  final String name;

  /// Descripción
  final String description;

  /// Días por defecto para alerta
  final int defaultAlertDays;

  /// Indica si el sistema lo creó
  final bool system;

  /// Activo/Inactivo
  final bool active;

  /// Fecha creación
  final DateTime createdAt;

  /// Última modificación
  final DateTime updatedAt;

  const DocumentType({
    required this.id,
    required this.name,
    required this.description,
    required this.defaultAlertDays,
    required this.system,
    required this.active,
    required this.createdAt,
    required this.updatedAt,
  });

  DocumentType copyWith({
    String? id,
    String? name,
    String? description,
    int? defaultAlertDays,
    bool? system,
    bool? active,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return DocumentType(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      defaultAlertDays: defaultAlertDays ?? this.defaultAlertDays,
      system: system ?? this.system,
      active: active ?? this.active,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  //==================================================
  // XML
  //==================================================

  XmlElement toXml() {
    return XmlElement(XmlName("DocumentType"), [], [
      _node("Id", id),
      _node("Name", name),
      _node("Description", description),
      _node("DefaultAlertDays", defaultAlertDays.toString()),
      _node("System", system.toString()),
      _node("Active", active.toString()),
      _node("CreatedAt", createdAt.toIso8601String()),
      _node("UpdatedAt", updatedAt.toIso8601String()),
    ]);
  }

  factory DocumentType.fromXml(XmlElement xml) {
    return DocumentType(
      id: _value(xml, "Id"),
      name: _value(xml, "Name"),
      description: _value(xml, "Description"),
      defaultAlertDays: int.tryParse(_value(xml, "DefaultAlertDays")) ?? 30,
      system: _value(xml, "System") == "true",
      active: _value(xml, "Active") != "false",
      createdAt: DateTime.parse(_value(xml, "CreatedAt")),
      updatedAt: DateTime.parse(_value(xml, "UpdatedAt")),
    );
  }

  static XmlElement _node(String tag, String value) {
    return XmlElement(XmlName(tag), [], [XmlText(value)]);
  }

  static String _value(XmlElement xml, String tag) {
    final node = xml.getElement(tag);

    if (node == null) {
      return "";
    }

    return node.innerText;
  }

  @override
  String toString() => name;

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is DocumentType && other.id == id;

  @override
  int get hashCode => id.hashCode;
}
