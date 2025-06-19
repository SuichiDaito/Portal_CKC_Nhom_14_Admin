import 'package:portal_ckc/api/model/admin_ho_so.dart';
import 'package:portal_ckc/api/model/admin_lop.dart';

class SinhVien {
  final int id;
  final String maSv;
  final int idLop;
  final int idHoSo;
  final int chucVu;
  final String matKhau;
  final int trangThai;
  final HoSo hoSo;
  final Lop lop;

  SinhVien({
    required this.id,
    required this.maSv,
    required this.idLop,
    required this.idHoSo,
    required this.chucVu,
    required this.matKhau,
    required this.trangThai,
    required this.hoSo,
    required this.lop,
  });

  factory SinhVien.fromJson(Map<String, dynamic> json) {
    return SinhVien(
      id: json['id'],
      maSv: json['ma_sv'],
      idLop: json['id_lop'],
      idHoSo: json['id_ho_so'],
      chucVu: json['chuc_vu'],
      matKhau: json['mat_khau'],
      trangThai: json['trang_thai'],
      hoSo: HoSo.fromJson(json['ho_so']),
      lop: Lop.fromJson(json['lop']),
    );
  }
}
