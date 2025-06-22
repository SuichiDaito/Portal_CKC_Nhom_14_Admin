class HocKy {
  final int id;
  final int idNienKhoa;
  final String tenHocKy;
  final String ngayBatDau;
  final String ngayKetThuc;

  HocKy({
    required this.id,
    required this.idNienKhoa,
    required this.tenHocKy,
    required this.ngayBatDau,
    required this.ngayKetThuc,
  });

  factory HocKy.fromJson(Map<String, dynamic> json) {
    return HocKy(
      id: json['id'],
      idNienKhoa: json['id_nien_khoa'],
      tenHocKy: json['ten_hoc_ky'],
      ngayBatDau: json['ngay_bat_dau'],
      ngayKetThuc: json['ngay_ket_thuc'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'id_nien_khoa': idNienKhoa,
      'ten_hoc_ky': tenHocKy,
      'ngay_bat_dau': ngayBatDau,
      'ngay_ket_thuc': ngayKetThuc,
    };
  }
}
