import 'package:equatable/equatable.dart';

class WorkModel extends Equatable {
  final int? empId;
  final String? empName;
  final String? empMob1;
  final String? empMob2;
  final int? empSalary;
  final String? empAdd;
  final String? empJob;
  final String? empNote;
  final DateTime? startDateWork;
  final String? idJob;
  final String? idPayType;
  final int? minQty;

  const WorkModel({
    this.empId,
    this.empName,
    this.empMob1,
    this.empMob2,
    this.empSalary,
    this.empAdd,
    this.empJob,
    this.empNote,
    this.startDateWork,
    this.idJob,
    this.idPayType,
    this.minQty,
  });

  factory WorkModel.fromJson(Map<String, dynamic> json) => WorkModel(
    empId: json['Emp_id'] as int?,
    empName: json['Emp_name'] as String?,
    empMob1: json['Emp_mob1'] as String?,
    empMob2: json['Emp_mob2'] as String?,
    empSalary: json['Emp_Salary'] as int?,
    empAdd: json['Emp_add'] as String?,
    empJob: json['Emp_job'] as String?,
    empNote: json['Emp_note'] as String?,
    startDateWork: json['Start_Date_Work'] == null
        ? null
        : DateTime.parse(json['Start_Date_Work'] as String),
    idJob: json['id_job'] as String?,
    idPayType: json['id_PayType'] as String?,
    minQty: json['min_qty'] as int?,
  );

  Map<String, dynamic> toJson() => {
    'Emp_id': empId,
    'Emp_name': empName,
    'Emp_mob1': empMob1,
    'Emp_mob2': empMob2,
    'Emp_Salary': empSalary,
    'Emp_add': empAdd,
    'Emp_job': empJob,
    'Emp_note': empNote,
    'Start_Date_Work': startDateWork?.toIso8601String(),
    'id_job': idJob,
    'id_PayType': idPayType,
    'min_qty': minQty,
  };

  @override
  List<Object?> get props {
    return [
      empId,
      empName,
      empMob1,
      empMob2,
      empSalary,
      empAdd,
      empJob,
      empNote,
      startDateWork,
      idJob,
      idPayType,
      minQty,
    ];
  }
}
