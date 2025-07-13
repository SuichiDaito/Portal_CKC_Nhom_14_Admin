import 'package:portal_ckc/api/model/admin_phieu_len_lop.dart';

import 'admin_lop_hoc_phan.dart';
import 'admin_phong.dart';

class ThoiKhoaBieu {
  final int id;
  final int idTuan;
  final int idLopHocPhan;
  final int idPhong;
  final int tietBatDau;
  final int tietKetThuc;
  final String ngay;
  final Room phong;
  final LopHocPhan lopHocPhan;
  final Tuan tuan;

  ThoiKhoaBieu({
    required this.id,
    required this.idTuan,
    required this.idLopHocPhan,
    required this.idPhong,
    required this.tietBatDau,
    required this.tietKetThuc,
    required this.ngay,
    required this.phong,
    required this.lopHocPhan,
    required this.tuan,
  });

  factory ThoiKhoaBieu.fromJson(Map<String, dynamic> json) {
    return ThoiKhoaBieu(
      id: json['id'] ?? 0,
      idTuan: json['id_tuan'] ?? 0,
      idLopHocPhan: json['id_lop_hoc_phan'] ?? 0,
      idPhong: json['id_phong'] ?? 0,
      tietBatDau: int.parse(json['tiet_bat_dau'].toString() ?? "0") ?? 0,
      tietKetThuc: int.parse(json['tiet_ket_thuc'].toString() ?? "0") ?? 0,
      ngay: json['ngay'] ?? '',
      phong: json['phong'] != null
          ? Room.fromJson(json['phong'])
          : Room.empty(),
      lopHocPhan: json['lop_hoc_phan'] != null
          ? LopHocPhan.fromJson(json['lop_hoc_phan'])
          : LopHocPhan.empty(),
      tuan: json['tuan'] != null ? Tuan.fromJson(json['tuan']) : Tuan.empty(),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'id_tuan': idTuan,
    'id_lop_hoc_phan': idLopHocPhan,
    'id_phong': idPhong,
    'tiet_bat_dau': tietBatDau,
    'tiet_ket_thuc': tietKetThuc,
    'ngay': ngay,
  };
  ThoiKhoaBieu copyWith({
    int? id,
    int? idTuan,
    int? idLopHocPhan,
    int? idPhong,
    int? tietBatDau,
    int? tietKetThuc,
    String? ngay,
    Room? phong,
    LopHocPhan? lopHocPhan,
    Tuan? tuan,
  }) {
    return ThoiKhoaBieu(
      id: id ?? this.id,
      idTuan: idTuan ?? this.idTuan,
      idLopHocPhan: idLopHocPhan ?? this.idLopHocPhan,
      idPhong: idPhong ?? this.idPhong,
      tietBatDau: tietBatDau ?? this.tietBatDau,
      tietKetThuc: tietKetThuc ?? this.tietKetThuc,
      ngay: ngay ?? this.ngay,
      phong: phong ?? this.phong,
      lopHocPhan: lopHocPhan ?? this.lopHocPhan,
      tuan: tuan ?? this.tuan,
    );
  }
}
