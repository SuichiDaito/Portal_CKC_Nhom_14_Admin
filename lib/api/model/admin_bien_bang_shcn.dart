import 'package:portal_ckc/api/model/admin_danh_sach_lop.dart';
import 'package:portal_ckc/api/model/admin_lop.dart';
import 'package:portal_ckc/api/model/admin_phieu_len_lop.dart';
import 'package:portal_ckc/api/model/admin_sinh_vien.dart';
import 'package:portal_ckc/api/model/admin_thong_tin.dart';

class BienBanSHCN {
  final int id;
  final String tieuDe;
  final String noiDung;
  final DateTime thoiGianBatDau;
  final DateTime thoiGianKetThuc;
  final int soLuongSinhVien;
  final int vangMat;
  final int trangThai;
  final int idLop;
  final Lop lop;
  final Tuan tuan;
  final SinhVien thuky;
  final User gvcn;
  final List<ChiTietBienBan> chiTiet;
  BienBanSHCN({
    required this.id,
    required this.idLop,
    required this.tieuDe,
    required this.noiDung,
    required this.thoiGianBatDau,
    required this.thoiGianKetThuc,
    required this.soLuongSinhVien,
    required this.vangMat,
    required this.trangThai,
    required this.lop,
    required this.tuan,
    required this.thuky,
    required this.gvcn,
    required this.chiTiet,
  });

  factory BienBanSHCN.fromJson(Map<String, dynamic> json) {
    return BienBanSHCN(
      id: json['id'],
      idLop: json['id_lop'] ?? 0,
      tieuDe: json['tieu_de'] ?? '',
      noiDung: json['noi_dung'] ?? '',
      thoiGianBatDau: json['thoi_gian_bat_dau'] != null
          ? DateTime.parse(json['thoi_gian_bat_dau'])
          : DateTime.now(),
      thoiGianKetThuc: json['thoi_gian_ket_thuc'] != null
          ? DateTime.parse(json['thoi_gian_ket_thuc'])
          : DateTime.now(),
      soLuongSinhVien: json['so_luong_sinh_vien'] ?? 0,
      vangMat: json['vang_mat'] ?? 0,
      trangThai: json['trang_thai'] ?? 0,
      lop: json['lop'] != null ? Lop.fromJson(json['lop']) : Lop.empty(),
      tuan: json['tuan'] != null ? Tuan.fromJson(json['tuan']) : Tuan.empty(),
      thuky: json['thuky'] != null
          ? SinhVien.fromJson(json['thuky'])
          : SinhVien.empty(),
      gvcn: json['gvcn'] != null ? User.fromJson(json['gvcn']) : User.empty(),
      chiTiet:
          (json['chi_tiet_bien_ban_s_h_c_n'] as List<dynamic>?)
              ?.map((e) => ChiTietBienBan.fromJson(e))
              .toList() ??
          [],
    );
  }

  static List<BienBanSHCN> fromJsonList(List<dynamic> jsonList) {
    return jsonList
        .map((json) => BienBanSHCN.fromJson(json as Map<String, dynamic>))
        .toList();
  }
}

class ChiTietBienBan {
  final int id;
  final int idBienBanShcn;
  final String lyDo;
  final int loai; // 1 = có phép, 0 = không phép
  final SinhVien sinhVien;

  ChiTietBienBan({
    required this.id,
    required this.idBienBanShcn,
    required this.lyDo,
    required this.loai,
    required this.sinhVien,
  });

  factory ChiTietBienBan.fromJson(Map<String, dynamic> json) {
    return ChiTietBienBan(
      id: json['id'],
      idBienBanShcn: json['id_bien_ban_shcn'],
      lyDo: json['ly_do'] ?? '',
      loai: json['loai'] ?? 0,
      sinhVien: SinhVien.fromJson(json['sinh_vien']),
    );
  }
}

class MeetingMinutesCreateData {
  final Lop lop;
  final List<StudentWithRole> thuKy;
  final List<Tuan> tuans;
  final List<StudentWithRole> sinhViens;

  MeetingMinutesCreateData({
    required this.lop,
    required this.thuKy,
    required this.tuans,
    required this.sinhViens,
  });

  factory MeetingMinutesCreateData.fromJson(Map<String, dynamic> json) {
    return MeetingMinutesCreateData(
      lop: Lop.fromJson(json['lop']),
      thuKy: (json['thuKy'] as List)
          .map((e) => StudentWithRole.fromJson(e))
          .toList(),
      tuans: (json['tuans'] as List).map((e) => Tuan.fromJson(e)).toList(),
      sinhViens: (json['sinhViens'] as List)
          .map((e) => StudentWithRole.fromJson(e))
          .toList(),
    );
  }
}
