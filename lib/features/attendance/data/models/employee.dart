// employee.dart
// ─────────────────────────────────────────────────────────────────────────────
// Domain model representing an attendee in the attendance system.
// Includes role, timestamp, and JSON serialization for Hive persistence.
// ─────────────────────────────────────────────────────────────────────────────
import 'package:equatable/equatable.dart';

class Employee extends Equatable {
  final int id;
  final String name;
  final String role;
  final bool isPresent;
  final String addedAt; // ISO-8601 timestamp

  const Employee({
    required this.id,
    required this.name,
    this.role = '',
    this.isPresent = false,
    this.addedAt = '',
  });

  Employee copyWith({
    int? id,
    String? name,
    String? role,
    bool? isPresent,
    String? addedAt,
  }) {
    return Employee(
      id: id ?? this.id,
      name: name ?? this.name,
      role: role ?? this.role,
      isPresent: isPresent ?? this.isPresent,
      addedAt: addedAt ?? this.addedAt,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'role': role,
    'isPresent': isPresent,
    'addedAt': addedAt,
  };

  factory Employee.fromJson(Map<String, dynamic> json) => Employee(
    id: json['id'] as int,
    name: json['name'] as String,
    role: json['role'] as String? ?? '',
    isPresent: json['isPresent'] as bool? ?? false,
    addedAt: json['addedAt'] as String? ?? '',
  );

  // Initials for avatar (first letter of first + last name).
  String get initials {
    final parts = name.trim().split(' ');
    if (parts.length >= 2) {
      return '${parts.first[0]}${parts.last[0]}'.toUpperCase();
    }
    return name.isNotEmpty ? name[0].toUpperCase() : '?';
  }

  @override
  List<Object?> get props => [id, name, role, isPresent, addedAt];
}
