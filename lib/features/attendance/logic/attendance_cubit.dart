import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../data/models/employee.dart';
import 'attendance_state.dart';

class AttendanceCubit extends Cubit<AttendanceState> {
  static const _boxName = 'attendance_box';
  static const _key = 'attendance_state';

  AttendanceCubit() : super(const AttendanceState(employees: [], nextId: 1)) {
    _loadFromHive();
  }

  Future<void> _loadFromHive() async {
    final box = await Hive.openBox(_boxName);
    final raw = box.get(_key);
    if (raw != null) {
      try {
        final json = Map<String, dynamic>.from(
          jsonDecode(raw as String) as Map,
        );
        emit(AttendanceState.fromJson(json));
      } catch (_) {}
    }
  }

  Future<void> _save() async {
    final box = await Hive.openBox(_boxName);
    await box.put(_key, jsonEncode(state.toJson()));
  }

  void addEmployee(String name, String role) {
    final employee = Employee(
      id: state.nextId,
      name: name,
      role: role,
      addedAt: DateTime.now().toIso8601String(),
    );
    emit(
      state.copyWith(
        employees: [...state.employees, employee],
        nextId: state.nextId + 1,
      ),
    );
    _save();
  }

  void removeEmployee(int id) {
    final updated = state.employees.where((e) => e.id != id).toList();
    emit(state.copyWith(employees: updated));
    _save();
  }

  void toggleAttendance(int id) {
    final updated = state.employees.map((e) {
      if (e.id == id) return e.copyWith(isPresent: !e.isPresent);
      return e;
    }).toList();
    emit(state.copyWith(employees: updated));
    _save();
  }

  void markAllPresent() {
    final updated = state.employees
        .map((e) => e.copyWith(isPresent: true))
        .toList();
    emit(state.copyWith(employees: updated));
    _save();
  }

  void markAllAbsent() {
    final updated = state.employees
        .map((e) => e.copyWith(isPresent: false))
        .toList();
    emit(state.copyWith(employees: updated));
    _save();
  }

  void clearAll() {
    emit(const AttendanceState(employees: [], nextId: 1));
    _save();
  }
}
