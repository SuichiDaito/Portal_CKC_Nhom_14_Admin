import 'package:portal_ckc/api/model/admin_ho_so.dart';
import 'package:portal_ckc/api/model/admin_phong_khoa.dart';
import 'package:portal_ckc/api/model/admin_vai_tro.dart';

enum TeacherPosition {
  admin,
  truongPhongDaoTao,
  truongPhongCongTacCT,
  giangVienBoMon,
  giangVienChuNhiem,
  truongKhoa,
}

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
      roles: (json['roles'] as List<dynamic>? ?? [])
          .map((e) => Role.fromJson(e))
          .toList(),
    );
  }
  User copyWith({
    int? id,
    int? idHoSo,
    int? idBoMon,
    String? taiKhoan,
    int? trangThai,
    HoSo? hoSo,
    BoMon? boMon,
    List<Role>? roles,
  }) {
    return User(
      id: id ?? this.id,
      idHoSo: idHoSo ?? this.idHoSo,
      idBoMon: idBoMon ?? this.idBoMon,
      taiKhoan: taiKhoan ?? this.taiKhoan,
      trangThai: trangThai ?? this.trangThai,
      hoSo: hoSo ?? this.hoSo,
      boMon: boMon ?? this.boMon,
      roles: roles ?? this.roles,
    );
  }

  factory User.empty() {
    return User(
      id: 0,
      idHoSo: null,
      idBoMon: null,
      taiKhoan: '',
      trangThai: 0,
      hoSo: null,
      boMon: null,
      roles: [],
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
