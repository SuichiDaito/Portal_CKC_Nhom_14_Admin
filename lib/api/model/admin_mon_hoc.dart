class MonHoc {
  final int id;
  final String tenMon;
  final int loaiMonHoc;

  MonHoc({required this.id, required this.tenMon, required this.loaiMonHoc});

  factory MonHoc.fromJson(Map<String, dynamic> json) {
    return MonHoc(
      id: json['id'] ?? 0,
      tenMon: json['ten_mon'] ?? '',
      loaiMonHoc: json['loai_mon_hoc'] ?? 0,
    );
  }
}
