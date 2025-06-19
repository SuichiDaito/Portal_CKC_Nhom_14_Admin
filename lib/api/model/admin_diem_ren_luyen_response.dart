import 'package:portal_ckc/api/model/admin_lop.dart';
import 'package:portal_ckc/api/model/admin_sinh_vien.dart';

class DiemRenLuyenResponse {
  final Lop lop;
  final int thoiGian;
  final List<SinhVien> sinhViens;

  DiemRenLuyenResponse({
    required this.lop,
    required this.thoiGian,
    required this.sinhViens,
  });

  factory DiemRenLuyenResponse.fromJson(Map<String, dynamic> json) {
    return DiemRenLuyenResponse(
      lop: Lop.fromJson(json['lop']),
      thoiGian: json['thoi_gian'],
      sinhViens: (json['sinh_viens'] as List)
          .map((e) => SinhVien.fromJson(e))
          .toList(),
    );
  }
}

class DiemRenLuyen {
  final int id;
  final String diem;

  DiemRenLuyen({required this.id, required this.diem});

  factory DiemRenLuyen.fromJson(Map<String, dynamic> json) {
    return DiemRenLuyen(id: json['id'], diem: json['diem']);
  }
}
