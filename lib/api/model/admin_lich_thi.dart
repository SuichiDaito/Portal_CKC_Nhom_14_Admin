import 'package:portal_ckc/api/model/admin_lop_hoc_phan.dart';
import 'package:portal_ckc/api/model/admin_phong.dart';
import 'package:portal_ckc/api/model/admin_thong_tin.dart';

class ExamSchedule {
  final int id;
  final int idLopHocPhan;
  final int idGiamThi1;
  final int idGiamThi2;
  final String ngayThi;
  final String gioBatDau;
  final int thoiGianThi;
  final int idPhongThi;
  final int lanThi;
  final int trangThai;
  final LopHocPhan lopHocPhan;
  final User giamThi1;
  final User giamThi2;
  final Room? phong;

  ExamSchedule({
    required this.id,
    required this.idLopHocPhan,
    required this.idGiamThi1,
    required this.idGiamThi2,
    required this.ngayThi,
    required this.gioBatDau,
    required this.thoiGianThi,
    required this.idPhongThi,
    required this.lanThi,
    required this.trangThai,
    required this.lopHocPhan,
    required this.giamThi1,
    required this.giamThi2,
    this.phong,
  });

  factory ExamSchedule.fromJson(Map<String, dynamic> json) {
    return ExamSchedule(
      id: json['id'],
      idLopHocPhan: json['id_lop_hoc_phan'],
      idGiamThi1: json['id_giam_thi_1'],
      idGiamThi2: json['id_giam_thi_2'],
      ngayThi: json['ngay_thi'],
      gioBatDau: json['gio_bat_dau'],
      thoiGianThi: json['thoi_gian_thi'],
      idPhongThi: json['id_phong_thi'],
      lanThi: json['lan_thi'],
      trangThai: json['trang_thai'],
      lopHocPhan: LopHocPhan.fromJson(json['lop_hoc_phan']),
      giamThi1: User.fromJson(json['giam_thi1']),
      giamThi2: User.fromJson(json['giam_thi2']),
      phong: json['phong'] != null ? Room.fromJson(json['phong']) : null,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id_lop_hoc_phan': idLopHocPhan,
      'id_giam_thi_1': idGiamThi1,
      'id_giam_thi_2': idGiamThi2,
      'ngay_thi': ngayThi,
      'gio_bat_dau': gioBatDau,
      'thoi_gian_thi': thoiGianThi,
      'id_phong_thi': idPhongThi,
      'lan_thi': lanThi,
      'trang_thai': trangThai,
    };
  }

  ExamSchedule copyWith({
    int? id,
    int? idLopHocPhan,
    int? idGiamThi1,
    int? idGiamThi2,
    String? ngayThi,
    String? gioBatDau,
    int? thoiGianThi,
    int? idPhongThi,
    int? lanThi,
    int? trangThai,
    LopHocPhan? lopHocPhan,
    User? giamThi1,
    User? giamThi2,
    Room? phong,
  }) {
    return ExamSchedule(
      id: id ?? this.id,
      idLopHocPhan: idLopHocPhan ?? this.idLopHocPhan,
      idGiamThi1: idGiamThi1 ?? this.idGiamThi1,
      idGiamThi2: idGiamThi2 ?? this.idGiamThi2,
      ngayThi: ngayThi ?? this.ngayThi,
      gioBatDau: gioBatDau ?? this.gioBatDau,
      thoiGianThi: thoiGianThi ?? this.thoiGianThi,
      idPhongThi: idPhongThi ?? this.idPhongThi,
      lanThi: lanThi ?? this.lanThi,
      trangThai: trangThai ?? this.trangThai,
      lopHocPhan: lopHocPhan ?? this.lopHocPhan,
      giamThi1: giamThi1 ?? this.giamThi1,
      giamThi2: giamThi2 ?? this.giamThi2,
      phong: phong ?? this.phong,
    );
  }
}
