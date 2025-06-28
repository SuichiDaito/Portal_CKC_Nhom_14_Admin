class TuanModel {
  final int id;
  final int tuan;
  final DateTime ngayBatDau;
  final DateTime ngayKetThuc;

  TuanModel({
    required this.id,
    required this.tuan,
    required this.ngayBatDau,
    required this.ngayKetThuc,
  });

  factory TuanModel.fromJson(Map<String, dynamic> json) {
    return TuanModel(
      id: json['id'],
      tuan: json['tuan'],
      ngayBatDau: DateTime.parse(json['ngay_bat_dau']),
      ngayKetThuc: DateTime.parse(json['ngay_ket_thuc']),
    );
  }
}
