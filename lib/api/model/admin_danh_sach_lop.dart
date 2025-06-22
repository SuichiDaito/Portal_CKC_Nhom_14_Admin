import 'package:portal_ckc/api/model/admin_lop.dart';
import 'package:portal_ckc/api/model/admin_sinh_vien.dart';

class LopChiTietResponse {
  final bool success;
  final Lop lop;
  final List<SinhVien> sinhViens;

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
          .map((e) => SinhVien.fromJson(e))
          .toList(),
    );
  }
}

class LopListResponse {
  final List<Lop> data;

  LopListResponse({required this.data});

  factory LopListResponse.fromJson(Map<String, dynamic> json) {
    return LopListResponse(
      data: (json['data'] as List).map((item) => Lop.fromJson(item)).toList(),
    );
  }
}
