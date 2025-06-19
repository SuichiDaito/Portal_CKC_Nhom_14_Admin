class NienKhoa {
  final int id;
  final String tenNienKhoa;
  final String namBatDau;
  final String namKetThuc;
  final int trangThai;

  NienKhoa({
    required this.id,
    required this.tenNienKhoa,
    required this.namBatDau,
    required this.namKetThuc,
    required this.trangThai,
  });

  factory NienKhoa.fromJson(Map<String, dynamic> json) {
    return NienKhoa(
      id: json['id'],
      tenNienKhoa: json['ten_nien_khoa'],
      namBatDau: json['nam_bat_dau'],
      namKetThuc: json['nam_ket_thuc'],
      trangThai: json['trang_thai'],
    );
  }
}
