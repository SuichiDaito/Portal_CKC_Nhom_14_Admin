class AdminLogin {
  final String taiKhoan;
  final String password;

  AdminLogin({required this.taiKhoan, required this.password});

  Map<String, dynamic> toJson() {
    return {'tai_khoan': taiKhoan, 'password': password};
  }
}
