class Khoa {
  final int id;
  final String tenKhoa;

  Khoa({required this.id, required this.tenKhoa});

  factory Khoa.fromJson(Map<String, dynamic> json) {
    return Khoa(id: json['id'], tenKhoa: json['ten_khoa'] ?? '');
  }
}

class ChuyenNganh {
  final int id;
  final String tenChuyenNganh;
  final Khoa? khoa;

  ChuyenNganh({required this.id, required this.tenChuyenNganh, this.khoa});

  factory ChuyenNganh.fromJson(Map<String, dynamic> json) {
    return ChuyenNganh(
      id: json['id'],
      tenChuyenNganh: json['ten_chuyen_nganh'] ?? '',
      khoa: json['khoa'] != null ? Khoa.fromJson(json['khoa']) : null,
    );
  }
}

class BoMon {
  final int id;
  final String tenBoMon;
  final ChuyenNganh? chuyenNganh;

  BoMon({required this.id, required this.tenBoMon, this.chuyenNganh});

  factory BoMon.fromJson(Map<String, dynamic> json) {
    return BoMon(
      id: json['id'],
      tenBoMon: json['ten_bo_mon'] ?? '',
      chuyenNganh: json['chuyen_nganh'] != null
          ? ChuyenNganh.fromJson(json['chuyen_nganh'])
          : null,
    );
  }
}
