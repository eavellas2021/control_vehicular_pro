import 'dart:convert';

class Vehicle {
  String id;

  String name;

  String brand;

  String model;

  String plate;

  int year;

  String color;

  int currentKm;

  String imagePath;

  String notes;

  DateTime createdAt;

  Vehicle({
    required this.id,

    required this.name,

    required this.brand,

    required this.model,

    required this.plate,

    required this.year,

    required this.color,

    required this.currentKm,

    required this.imagePath,

    required this.notes,

    required this.createdAt,
  });

  Vehicle copyWith({
    String? id,

    String? name,

    String? brand,

    String? model,

    String? plate,

    int? year,

    String? color,

    int? currentKm,

    String? imagePath,

    String? notes,

    DateTime? createdAt,
  }) {
    return Vehicle(
      id: id ?? this.id,
      name: name ?? this.name,
      brand: brand ?? this.brand,
      model: model ?? this.model,
      plate: plate ?? this.plate,
      year: year ?? this.year,
      color: color ?? this.color,
      currentKm: currentKm ?? this.currentKm,
      imagePath: imagePath ?? this.imagePath,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'brand': brand,
      'model': model,
      'plate': plate,
      'year': year,
      'color': color,
      'currentKm': currentKm,
      'imagePath': imagePath,
      'notes': notes,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory Vehicle.fromMap(Map<String, dynamic> map) {
    return Vehicle(
      id: map['id'],
      name: map['name'],
      brand: map['brand'],
      model: map['model'],
      plate: map['plate'],
      year: map['year'],
      color: map['color'],
      currentKm: map['currentKm'],
      imagePath: map['imagePath'],
      notes: map['notes'],
      createdAt: DateTime.parse(map['createdAt']),
    );
  }

  String toJson() => jsonEncode(toMap());

  factory Vehicle.fromJson(String source) =>
      Vehicle.fromMap(jsonDecode(source));
}
