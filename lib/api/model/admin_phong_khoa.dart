class Khoa {
  final int id;
  final String tenKhoa;

  Khoa({required this.id, required this.tenKhoa});

  factory Khoa.fromJson(Map<String, dynamic> json) {
    return Khoa(id: json['id'], tenKhoa: json['ten_khoa'] ?? '');
  }
}

class NganhHoc {
  final int id;
  final String tenNganh;
  final Khoa? khoa;

  NganhHoc({required this.id, required this.tenNganh, this.khoa});

  factory NganhHoc.fromJson(Map<String, dynamic> json) {
    return NganhHoc(
      id: json['id'],
      tenNganh: json['ten_nganh'] ?? '',
      khoa: json['khoa'] != null ? Khoa.fromJson(json['khoa']) : null,
    );
  }
}

class BoMon {
  final int id;
  final String tenBoMon;
  final NganhHoc? nganhHoc;

  BoMon({required this.id, required this.tenBoMon, this.nganhHoc});

  factory BoMon.fromJson(Map<String, dynamic> json) {
    return BoMon(
      id: json['id'],
      tenBoMon: json['ten_bo_mon'] ?? '',
      nganhHoc: json['nganh_hoc'] != null
          ? NganhHoc.fromJson(json['nganh_hoc'])
          : null,
    );
  }
}
