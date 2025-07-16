import 'package:portal_ckc/api/model/admin_ho_so.dart';
import 'package:portal_ckc/api/model/admin_phong_khoa.dart';
import 'package:portal_ckc/api/model/admin_role.dart';

class User {
  final int id;
  final int? idHoSo;
  final int? idBoMon;
  final String taiKhoan;
  final int trangThai;
  final HoSo? hoSo;
  final BoMon? boMon;
  final List<Role> roles;

  User({
    required this.id,
    this.idHoSo,
    this.idBoMon,
    required this.taiKhoan,
    required this.trangThai,
    this.hoSo,
    this.boMon,
    required this.roles,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      idHoSo: json['id_ho_so'] is int ? json['id_ho_so'] : null,
      idBoMon: json['id_bo_mon'],
      taiKhoan: json['tai_khoan'] ?? '',
      trangThai: json['trang_thai'] ?? 0,
      hoSo: json['ho_so'] != null ? HoSo.fromJson(json['ho_so']) : null,
      boMon: json['bo_mon'] != null ? BoMon.fromJson(json['bo_mon']) : null,
      roles: (json['roles'] ?? []).map<Role>((e) => Role.fromJson(e)).toList(),
    );
  }
}

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
}

class LoginResponse {
  final String token;
  final User user;
  final String message;

  LoginResponse({
    required this.token,
    required this.user,
    required this.message,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      token: json['token'] ?? '',
      user: User.fromJson(json['user']),
      message: json['message'] ?? '',
    );
  }
}
