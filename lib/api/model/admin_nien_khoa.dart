
import 'package:portal_ckc/api/model/admin_hoc_ky.dart';

class NienKhoa {
  final int id;
  final String tenNienKhoa;
  final String namBatDau;
  final String namKetThuc;
  final int trangThai;
  final List<HocKy> hocKys;

  NienKhoa({
    required this.id,
    required this.tenNienKhoa,
    required this.namBatDau,
    required this.namKetThuc,
    required this.trangThai,
<<<<<<< HEAD
    required this.hocKys,
  });
  factory NienKhoa.fromJson(Map<String, dynamic> json) {
    return NienKhoa(
      id: json['id'],
      tenNienKhoa: json['ten_nien_khoa'] ?? '',
      namBatDau: json['nam_bat_dau'] ?? '',
      namKetThuc: json['nam_ket_thuc'] ?? '',
      trangThai: int.tryParse(json['trang_thai'].toString() ?? '') ?? 0,
      hocKys:
          (json['hoc_kys'] as List?)?.map((e) => HocKy.fromJson(e)).toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'ten_nien_khoa': tenNienKhoa,
      'nam_bat_dau': namBatDau,
      'nam_ket_thuc': namKetThuc,
      'trang_thai': trangThai,
      'hoc_kys': hocKys.map((e) => e.toJson()).toList(),
    };
  }

  factory NienKhoa.empty() {
    return NienKhoa(
      id: 0,
      tenNienKhoa: '',
      namBatDau: '',
      namKetThuc: '',
      trangThai: 0,
      hocKys: [],
    );
  }
}
