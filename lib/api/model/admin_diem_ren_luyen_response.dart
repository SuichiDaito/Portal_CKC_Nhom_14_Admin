import 'package:portal_ckc/api/model/admin_lop.dart';
import 'package:portal_ckc/api/model/admin_sinh_vien.dart';

class DiemRenLuyen {
  final int id;
  final int idGvcn;
  final int idSinhVien;
  final int idNam;
  final int xepLoai;
  final int thoiGian;
  DiemRenLuyen({
    required this.id,
    required this.idGvcn,
    required this.idSinhVien,
    required this.idNam,
    required this.xepLoai,
    required this.thoiGian,
  });
  Map<String, dynamic> toJson() => {
    'id': id,
    'id_gvcn': idGvcn,
    'id_sinh_vien': idSinhVien,
    'id_nam': idNam,
    'xep_loai': xepLoai,
    'thoi_gian': thoiGian,
  };
  factory DiemRenLuyen.fromJson(Map<String, dynamic> json) {
    return DiemRenLuyen(
      id: json['id'],
      idGvcn: json['id_gvcn'],
      idSinhVien: json['id_sinh_vien'],
      idNam: json['id_nam'],
      xepLoai: json['xep_loai'],
      thoiGian: int.parse(json['thoi_gian'].toString() ?? '') ?? 0,
    );
  }

  factory DiemRenLuyen.empty() {
    return DiemRenLuyen(
      id: 0,
      idNam: 0,
      thoiGian: 0,
      xepLoai: 0,
      idGvcn: 0,
      idSinhVien: 0,
    );
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

