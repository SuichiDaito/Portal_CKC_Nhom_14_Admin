import 'package:portal_ckc/api/model/admin_lop.dart';
import 'package:portal_ckc/api/model/admin_sinh_vien.dart';

class DiemRenLuyen {
  final int id;
  final String diem;

  DiemRenLuyen({required this.id, required this.diem});

  factory DiemRenLuyen.fromJson(Map<String, dynamic> json) {
    return DiemRenLuyen(id: json['id'], diem: json['diem']);
  }
}

class NhapDiemRLResponse {
  final Lop lop;
  final String thoiGian;
  final List<SinhVien> sinhViens;

  NhapDiemRLResponse({
    required this.lop,
    required this.thoiGian,
    required this.sinhViens,
  });

  factory NhapDiemRLResponse.fromJson(Map<String, dynamic> json) {
    return NhapDiemRLResponse(
      lop: Lop.fromJson(json['lop']),
      thoiGian: json['thoi_gian'].toString(),
      sinhViens: (json['sinh_viens'] as List)
          .map((e) => SinhVien.fromJson(e))
          .toList(),
    );
  }
}
