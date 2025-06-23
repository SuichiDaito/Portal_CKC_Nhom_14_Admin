import 'package:portal_ckc/api/model/admin_chuong_trinh_dao_tao.dart';
import 'package:portal_ckc/api/model/admin_lop.dart';

class LopHocPhan {
  final int id;
  final String tenHocPhan;
  final int idGiangVien;
  final int idChuongTrinhDaoTao;
  final int idLop;
  final int loaiLopHocPhan;
  final int soLuongDangKy;
  final int loaiMon;
  final int trangThai;
  final Lop lop;
  final ChuongTrinhDaoTao chuongTrinhDaoTao;
  LopHocPhan({
    required this.id,
    required this.tenHocPhan,
    required this.idGiangVien,
    required this.idChuongTrinhDaoTao,
    required this.idLop,
    required this.loaiLopHocPhan,
    required this.soLuongDangKy,
    required this.loaiMon,
    required this.trangThai,
    required this.lop,
    required this.chuongTrinhDaoTao,
  });
  factory LopHocPhan.fromJson(Map<String, dynamic> json) => LopHocPhan(
    id: json['id'] ?? 0,
    tenHocPhan: json['ten_hoc_phan'] ?? '',
    idGiangVien: json['id_giang_vien'] ?? 0,
    idChuongTrinhDaoTao: json['id_chuong_trinh_dao_tao'] ?? 0,
    idLop: json['id_lop'] ?? 0,
    loaiLopHocPhan: json['loai_lop_hoc_phan'] ?? 0,
    soLuongDangKy: json['so_luong_dang_ky'] ?? 0,
    loaiMon: json['loai_mon'] ?? 0,
    trangThai: json['trang_thai'] ?? 0,
    lop: json['lop'] != null
        ? Lop.fromJson(json['lop'])
        : Lop.empty(), // xử lý null
    chuongTrinhDaoTao: json['chuong_trinh_dao_tao'] != null
        ? ChuongTrinhDaoTao.fromJson(json['chuong_trinh_dao_tao'])
        : ChuongTrinhDaoTao.empty(), // xử lý null
  );
}
