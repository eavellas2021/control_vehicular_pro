import 'package:xml/xml.dart';

class Vehicle {
  final String id;

  final String name;

  final String brand;

  final String line;

  final String model;

  final String plate;

  final int year;

  final String color;

  final String vin;

  final String engine;

  final String fuelType;

  final int currentKm;

  final DateTime? purchaseDate;

  final double purchaseValue;

  final String imagePath;

  final String notes;

  final DateTime createdAt;

  final DateTime updatedAt;

  const Vehicle({
    required this.id,
    required this.name,
    required this.brand,
    required this.line,
    required this.model,
    required this.plate,
    required this.year,
    required this.color,
    required this.vin,
    required this.engine,
    required this.fuelType,
    required this.currentKm,
    this.purchaseDate,
    required this.purchaseValue,
    required this.imagePath,
    required this.notes,
    required this.createdAt,
    required this.updatedAt,
  });

  Vehicle copyWith({
    String? id,
    String? name,
    String? brand,
    String? line,
    String? model,
    String? plate,
    int? year,
    String? color,
    String? vin,
    String? engine,
    String? fuelType,
    int? currentKm,
    DateTime? purchaseDate,
    double? purchaseValue,
    String? imagePath,
    String? notes,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Vehicle(
      id: id ?? this.id,
      name: name ?? this.name,
      brand: brand ?? this.brand,
      line: line ?? this.line,
      model: model ?? this.model,
      plate: plate ?? this.plate,
      year: year ?? this.year,
      color: color ?? this.color,
      vin: vin ?? this.vin,
      engine: engine ?? this.engine,
      fuelType: fuelType ?? this.fuelType,
      currentKm: currentKm ?? this.currentKm,
      purchaseDate: purchaseDate ?? this.purchaseDate,
      purchaseValue: purchaseValue ?? this.purchaseValue,
      imagePath: imagePath ?? this.imagePath,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  //=========================
  // GETTERS
  //=========================

  String get displayName => "$brand $line - $plate";

  bool get hasPhoto => imagePath.isNotEmpty;

  int get age => DateTime.now().year - year;

  String get formattedKm {
    return "$currentKm km";
  }

  //=========================
  // XML
  //=========================

  XmlElement toXml() {
    return XmlElement(XmlName("Vehicle"), [], [
      _node("Id", id),
      _node("Name", name),
      _node("Brand", brand),
      _node("Line", line),
      _node("Model", model),
      _node("Plate", plate),
      _node("Year", year.toString()),
      _node("Color", color),
      _node("Vin", vin),
      _node("Engine", engine),
      _node("FuelType", fuelType),
      _node("CurrentKm", currentKm.toString()),
      _node("PurchaseDate", purchaseDate?.toIso8601String() ?? ""),
      _node("PurchaseValue", purchaseValue.toString()),
      _node("ImagePath", imagePath),
      _node("Notes", notes),
      _node("CreatedAt", createdAt.toIso8601String()),
      _node("UpdatedAt", updatedAt.toIso8601String()),

      /// Se dejan preparados
      XmlElement(XmlName("Documents")),

      XmlElement(XmlName("Maintenances")),
    ]);
  }

  factory Vehicle.fromXml(XmlElement xml) {
    return Vehicle(
      id: _value(xml, "Id"),
      name: _value(xml, "Name"),
      brand: _value(xml, "Brand"),
      line: _value(xml, "Line"),
      model: _value(xml, "Model"),
      plate: _value(xml, "Plate"),
      year: int.tryParse(_value(xml, "Year")) ?? 0,
      color: _value(xml, "Color"),
      vin: _value(xml, "Vin"),
      engine: _value(xml, "Engine"),
      fuelType: _value(xml, "FuelType"),
      currentKm: int.tryParse(_value(xml, "CurrentKm")) ?? 0,
      purchaseDate: _value(xml, "PurchaseDate").isEmpty
          ? null
          : DateTime.parse(_value(xml, "PurchaseDate")),
      purchaseValue: double.tryParse(_value(xml, "PurchaseValue")) ?? 0,
      imagePath: _value(xml, "ImagePath"),
      notes: _value(xml, "Notes"),
      createdAt: DateTime.parse(_value(xml, "CreatedAt")),
      updatedAt: DateTime.parse(_value(xml, "UpdatedAt")),
    );
  }

  static XmlElement _node(String name, Object? value) {
    return XmlElement(XmlName(name), [], [XmlText(value?.toString() ?? '')]);
  }

  static String _value(XmlElement xml, String tag) {
    final node = xml.getElement(tag);

    if (node == null) {
      return "";
    }

    return node.innerText;
  }

  @override
  String toString() => displayName;

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is Vehicle && other.id == id;

  @override
  int get hashCode => id.hashCode;
}
