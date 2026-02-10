import 'package:equatable/equatable.dart';
import '../data/models/employee.dart';

class AttendanceState extends Equatable {
  final List<Employee> employees;
  final int nextId;

  const AttendanceState({required this.employees, this.nextId = 1});

  AttendanceState copyWith({List<Employee>? employees, int? nextId}) {
    return AttendanceState(
      employees: employees ?? this.employees,
      nextId: nextId ?? this.nextId,
    );
  }

  Map<String, dynamic> toJson() => {
    'employees': employees.map((e) => e.toJson()).toList(),
    'nextId': nextId,
  };

  factory AttendanceState.fromJson(Map<String, dynamic> json) {
    final list =
        (json['employees'] as List<dynamic>?)
            ?.map((e) => Employee.fromJson(e as Map<String, dynamic>))
            .toList() ??
        [];
    return AttendanceState(
      employees: list,
      nextId: json['nextId'] as int? ?? (list.isEmpty ? 1 : list.length + 1),
    );
  }

  @override
  List<Object?> get props => [employees, nextId];
}
