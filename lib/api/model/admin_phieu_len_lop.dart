import 'package:portal_ckc/api/model/admin_lop_hoc_phan.dart';
import 'package:portal_ckc/api/model/admin_phong.dart';

class PhieuLenLop {
  final int id;
  final int idLopHocPhan;
  final int tietBatDau;
  final int soTiet;
  final String? ngay;
  final int? idPhong;
  final int? siSo;
  final int? hienDien;
  final String? noiDung;
  final LopHocPhan? lopHocPhan;
  final Room? phong;
  final Tuan? tuan;

  PhieuLenLop({
    required this.id,
    required this.idLopHocPhan,
    required this.tietBatDau,
    required this.soTiet,
    required this.ngay,
    required this.idPhong,
    required this.siSo,
    required this.hienDien,
    required this.noiDung,
    this.lopHocPhan,
    this.phong,
    this.tuan,
  });

  factory PhieuLenLop.fromJson(Map<String, dynamic> json) {
    return PhieuLenLop(
      id: json['id'],
      idLopHocPhan: json['id_lop_hoc_phan'],
      tietBatDau: json['tiet_bat_dau'],
      soTiet: json['so_tiet'],
      ngay: json['ngay'],
      idPhong: json['id_phong'],
      siSo: json['si_so'],
      hienDien: json['hien_dien'],
      noiDung: json['noi_dung'],
      lopHocPhan: json['lop_hoc_phan'] != null
          ? LopHocPhan.fromJson(json['lop_hoc_phan'])
          : null,
      phong: json['phong'] != null ? Room.fromJson(json['phong']) : null,
      tuan: json['tuan'] != null ? Tuan.fromJson(json['tuan']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_lop_hoc_phan': idLopHocPhan,
      'tiet_bat_dau': tietBatDau,
      'so_tiet': soTiet,
      'ngay': ngay,
      'id_phong': idPhong,
      'si_so': siSo,
      'hien_dien': hienDien,
      'noi_dung': noiDung,
    };
  }
}

class Tuan {
  final int id;
  final int tuan;

  Tuan({required this.id, required this.tuan});

  factory Tuan.fromJson(Map<String, dynamic> json) {
    return Tuan(
      id: json['id'],
      tuan: int.parse(json['tuan'].toString() ?? "") ?? 0,
    );
  }
  static Tuan empty() => Tuan(id: 0, tuan: 0);
}
