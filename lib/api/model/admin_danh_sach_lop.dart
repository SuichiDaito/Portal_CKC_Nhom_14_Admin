import 'package:portal_ckc/api/model/admin_lop.dart';
import 'package:portal_ckc/api/model/admin_sinh_vien.dart';

class LopChiTietResponse {
  final bool success;
  final Lop lop;
  final List<StudentWithRole> sinhViens;

  LopChiTietResponse({
    required this.success,
    required this.lop,
    required this.sinhViens,
  });

  factory LopChiTietResponse.fromJson(Map<String, dynamic> json) {
    return LopChiTietResponse(
      success: json['success'],
      lop: Lop.fromJson(json['lop']),
      sinhViens: (json['sinh_viens'] as List)
          .map((e) => StudentWithRole.fromJson(e))
          .toList(),
    );
  }
}

class StudentWithRole {
  final int id;
  final int idLop;
  final int idSinhVien;
  final int chucVu;
  final SinhVien sinhVien;

  StudentWithRole({
    required this.id,
    required this.idLop,
    required this.idSinhVien,
    required this.chucVu,
    required this.sinhVien,
  });
  StudentWithRole.empty()
    : id = -1,
      idLop = -1,
      idSinhVien = -1,
      chucVu = 0,
      sinhVien = SinhVien.empty();
  factory StudentWithRole.fromJson(Map<String, dynamic> json) {
    return StudentWithRole(
      id: json['id'],
      idLop: json['id_lop'],
      idSinhVien: json['id_sinh_vien'],
      chucVu: json['chuc_vu'],
      sinhVien: SinhVien.fromJson(json['sinh_vien']),
    );
  }
}
