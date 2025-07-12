import 'package:portal_ckc/api/model/admin_lop.dart';

class HoSo {
  final int id;
  final String hoTen;
  final String email;
  final String password;
  final String soDienThoai;
  final String ngaySinh;
  final String gioiTinh;
  final String cccd;
  final String diaChi;
  final String anh;

  HoSo({
    required this.id,
    required this.hoTen,
    required this.email,
    required this.password,
    required this.soDienThoai,
    required this.ngaySinh,
    required this.gioiTinh,
    required this.cccd,
    required this.diaChi,
    required this.anh,
  });

  factory HoSo.fromJson(Map<String, dynamic> json) {
    return HoSo(
      id: json['id'],
      hoTen: json['ho_ten'] ?? '',
      email: json['email'] ?? '',
      password: json['password'] ?? '',
      soDienThoai: json['so_dien_thoai'] ?? '',
      ngaySinh: json['ngay_sinh'] ?? '',
      gioiTinh: json['gioi_tinh'] ?? '',
      cccd: json['cccd'] ?? '',
      diaChi: json['dia_chi'] ?? '',
      anh: json['anh'] ?? '',
    );
  }
  factory HoSo.empty() {
    return HoSo(
      hoTen: '',
      email: '',
      soDienThoai: '',
      ngaySinh: '',
      id: 0,
      password: '',
      gioiTinh: '',
      cccd: '',
      diaChi: '',
      anh: '',
    );
  }
  Map<String, dynamic> toJson() => {
    'id': id,
    'ho_ten': hoTen,
    'email': email,
    'password': password,
    'so_dien_thoai': soDienThoai,
    'ngay_sinh': ngaySinh,
    'gioi_tinh': gioiTinh,
    'cccd': cccd,
    'dia_chi': diaChi,
    'anh': anh,
  };
}
