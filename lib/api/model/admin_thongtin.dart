import 'package:portal_ckc/api/model/admin_ho_so.dart';
import 'package:portal_ckc/api/model/admin_phong_khoa.dart';
import 'package:portal_ckc/api/model/admin_vaitro.dart';

class User {
  final int id;
  final int? idHoSo; // ✅ Cho phép null
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
