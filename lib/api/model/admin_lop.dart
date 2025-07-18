import 'package:portal_ckc/api/model/admin_nien_khoa.dart';
import 'package:portal_ckc/api/model/admin_thong_tin.dart';

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
      id: json['id'] is int
          ? json['id']
          : int.tryParse(json['id'].toString()) ?? 0,
      tenLop: json['ten_lop'] ?? '',
      idNienKhoa: json['id_nien_khoa'] is int
          ? json['id_nien_khoa']
          : int.tryParse(json['id_nien_khoa'].toString()) ?? 0,
      idGvcn: json['id_gvcn'] is int
          ? json['id_gvcn']
          : int.tryParse(json['id_gvcn'].toString()) ?? 0,
      siSo: json['si_so'] is int
          ? json['si_so']
          : int.tryParse(json['si_so'].toString()) ?? 0,
      nienKhoa: json['nien_khoa'] != null
          ? NienKhoa.fromJson(json['nien_khoa'])
          : NienKhoa.empty(),
      giangVien: json['giang_vien'] != null
          ? User.fromJson(json['giang_vien'])
          : User(id: 0, taiKhoan: "", trangThai: 0, roles: []),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'ten_lop': tenLop,
    'id_nien_khoa': idNienKhoa,
    'id_gvcn': idGvcn,
    'si_so': siSo,
    'nien_khoa': nienKhoa.toJson(),
    'giang_vien': giangVien.toJson(),
  };

  factory Lop.empty() {
    return Lop(
      id: -1,
      tenLop: 'Không rõ',
      idNienKhoa: 0,
      idGvcn: 0,
      siSo: 0,
      nienKhoa: NienKhoa.empty(),
      giangVien: User(id: 0, taiKhoan: "", trangThai: 0, roles: []),
    );
  }
}
