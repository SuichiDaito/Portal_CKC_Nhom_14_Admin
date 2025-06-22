import 'package:portal_ckc/api/model/admin_ho_so.dart';
import 'package:portal_ckc/api/model/admin_lop.dart';

enum StudentStatus { active, inactive, graduated, suspended }

class SinhVien {
  final int id;
  final String maSv;
  final int? idLop;
  final int? idHoSo;
  final int? chucVu;
  final int trangThai;
  final HoSo hoSo;
  final Lop lop;

  SinhVien({
    required this.id,
    required this.maSv,
    this.idLop,
    this.idHoSo,
    this.chucVu,
    required this.trangThai,
    required this.hoSo,
    required this.lop,
  });

  factory SinhVien.fromJson(Map<String, dynamic> json) {
    return SinhVien(
      id: json['id'] ?? 0,
      maSv: json['ma_sv'] ?? '',
      idLop: json['id_lop'],
      idHoSo: json['id_ho_so'],
      chucVu: json['chuc_vu'],
      trangThai: json['trang_thai'] ?? 0,
      hoSo: json['ho_so'] != null ? HoSo.fromJson(json['ho_so']) : HoSo.empty(),
      lop: json['lop'] != null ? Lop.fromJson(json['lop']) : Lop.empty(),
    );
  }
}
