class User {
  final int id;
  final int idHoSo;
  final int idBoMon;

  User({required this.id, required this.idHoSo, required this.idBoMon});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      idHoSo: json['id_ho_so'],
      idBoMon: json['id_bo_mon'],
    );
  }
}

class HoSo {
  final int id;
  final String hoTen;
  final String email;
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
      soDienThoai: json['so_dien_thoai'] ?? '',
      ngaySinh: json['ngay_sinh'] ?? '',
      gioiTinh: json['gioi_tinh'] ?? '',
      cccd: json['cccd'] ?? '',
      diaChi: json['dia_chi'] ?? '',
      anh: json['anh'] ?? '',
    );
  }
}

class BoMon {
  final String tenBoMon;
  final NganhHoc? nganhHoc;

  BoMon({required this.tenBoMon, this.nganhHoc});

  factory BoMon.fromJson(Map<String, dynamic> json) {
    return BoMon(
      tenBoMon: json['ten_bo_mon'] ?? '',
      nganhHoc: json['nganhHoc'] != null
          ? NganhHoc.fromJson(json['nganhHoc'])
          : null,
    );
  }
}

class NganhHoc {
  final String tenNganh;
  final Khoa? khoa;

  NganhHoc({required this.tenNganh, this.khoa});

  factory NganhHoc.fromJson(Map<String, dynamic> json) {
    return NganhHoc(
      tenNganh: json['ten_nganh'] ?? '',
      khoa: json['khoa'] != null ? Khoa.fromJson(json['khoa']) : null,
    );
  }
}

class Khoa {
  final String tenKhoa;

  Khoa({required this.tenKhoa});

  factory Khoa.fromJson(Map<String, dynamic> json) {
    return Khoa(tenKhoa: json['ten_khoa'] ?? '');
  }
}

// class AdminLoginResponse {
//   final String token;
//   final User user;
//   final String message;

//   AdminLoginResponse({
//     required this.token,
//     required this.user,
//     required this.message,
//   });

//   factory AdminLoginResponse.fromJson(Map<String, dynamic> json) {
//     return AdminLoginResponse(
//       token: json['token'] ?? '',
//       user: User.fromJson(json['user']),
//       message: json['message'] ?? '',
//     );
//   }
// }

// class LoginResponse {
//   final String token;
//   final User user;

//   LoginResponse({required this.token, required this.user});

//   factory LoginResponse.fromJson(Map<String, dynamic> json) {
//     return LoginResponse(
//       token: json['token'],
//       user: User.fromJson(json['user']),
//     );
//   }
// }
