import 'package:portal_ckc/presentation/sections/card/create_academic_year_bottom_sheet.dart';

class TuanModel {
  final int id;
  final int tuan;
  final DateTime ngayBatDau;
  final DateTime ngayKetThuc;

  TuanModel({
    required this.id,
    required this.tuan,
    required this.ngayBatDau,
    required this.ngayKetThuc,
  });

  factory TuanModel.fromJson(Map<String, dynamic> json) {
    return TuanModel(
      id: json['id'],
      tuan: int.parse(json['tuan'].toString() ?? '') ?? 0,
      ngayBatDau: DateTime.parse(json['ngay_bat_dau']),
      ngayKetThuc: DateTime.parse(json['ngay_ket_thuc']),
    );
  }
}

enum AcademicYearStatus { notInitialized, inProgress, completed }

class AcademicYear {
  final String id;
  final String cohort;
  final AcademicTerm term;
  final int year;
  final DateTime startDate;
  final AcademicYearStatus status;

  AcademicYear({
    required this.id,
    required this.cohort,
    required this.term,
    required this.year,
    required this.startDate,
    required this.status,
  });

  factory AcademicYear.fromJson(Map<String, dynamic> json) {
    return AcademicYear(
      id: json['id'],
      cohort: json['cohort'],
      term: AcademicTerm.values.firstWhere(
        (e) => e.toString() == 'AcademicTerm.${json['term']}',
        orElse: () => AcademicTerm.term1,
      ),
      year: json['year'],
      startDate: DateTime.parse(json['startDate']),
      status: AcademicYearStatus.values.firstWhere(
        (e) => e.toString() == 'AcademicYearStatus.${json['status']}',
        orElse: () => AcademicYearStatus.notInitialized,
      ),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'cohort': cohort,
    'term': term.name,
    'year': year,
    'startDate': startDate.toIso8601String(),
    'status': status.name,
  };
}
