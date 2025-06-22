import 'package:portal_ckc/api/model/admin_nien_khoa.dart';
import 'package:portal_ckc/api/model/admin_thongtin.dart';

class Lop {
  final int id;
  final String tenLop;
  final int idNienKhoa;
  final int idGvcn;
  final int siSo;
  final NienKhoa nienKhoa;
  final User giangVien;

  Lop({
    required this.id,
    required this.tenLop,
    required this.idNienKhoa,
    required this.idGvcn,
    required this.siSo,
    required this.nienKhoa,
    required this.giangVien,
  });

  factory Lop.fromJson(Map<String, dynamic> json) {
    return Lop(
      id: json['id'],
      tenLop: json['ten_lop'],
      idNienKhoa: json['id_nien_khoa'],
      idGvcn: json['id_gvcn'],
      siSo: json['si_so'],
      nienKhoa: NienKhoa.fromJson(json['nien_khoa']),
      giangVien: User.fromJson(json['giang_vien']),
    );
  }
}
