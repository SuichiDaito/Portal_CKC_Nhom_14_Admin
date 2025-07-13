import 'package:portal_ckc/api/model/admin_hoc_ky.dart';
import 'package:portal_ckc/api/model/admin_mon_hoc.dart';

class ChuongTrinhDaoTao {
  final int id;
  final int idChuyenNganh;
  final String tenChuongTrinhDaoTao;
  final int tongTinChi;
  final int trangThai;
  final int thoiGian;
  final List<ChiTietChuongTrinhDaoTao> chiTiet;
  ChuongTrinhDaoTao({
    required this.id,
    required this.idChuyenNganh,
    required this.tenChuongTrinhDaoTao,
    required this.tongTinChi,
    required this.trangThai,
    required this.thoiGian,
    required this.chiTiet,
  });

  factory ChuongTrinhDaoTao.fromJson(Map<String, dynamic> json) {
    return ChuongTrinhDaoTao(
      id: json['id'] ?? 0,
      idChuyenNganh: json['id_chuyen_nganh'] ?? 0,
      tenChuongTrinhDaoTao: json['ten_chuong_trinh_dao_tao'] ?? '',
      tongTinChi: int.tryParse(json['tong_tin_chi']?.toString() ?? '') ?? 0,
      trangThai: int.tryParse(json['trang_thai']?.toString() ?? '') ?? 0,
      thoiGian: int.tryParse(json['thoi_gian']?.toString() ?? '') ?? 0,
      chiTiet:
          (json['chi_tiet_chuong_trinh_dao_tao'] as List?)
              ?.map((e) => ChiTietChuongTrinhDaoTao.fromJson(e))
              .toList() ??
          [],
    );
  }

  List<ChuongTrinhDaoTao> parseChuongTrinhDaoTao(Map<String, dynamic> json) {
    final ctdtList = json['ctdt'] as List;
    final ctChiTietMap = json['ct_ctdt'] as Map<String, dynamic>;

    return ctdtList.map<ChuongTrinhDaoTao>((ctdtJson) {
      final id = ctdtJson['id'];
      final chiTietListRaw = ctChiTietMap[id.toString()] ?? [];

      final chiTietList = (chiTietListRaw as List)
          .map((e) => ChiTietChuongTrinhDaoTao.fromJson(e))
          .toList();

      return ChuongTrinhDaoTao(
        id: ctdtJson['id'] ?? 0,
        idChuyenNganh: ctdtJson['id_chuyen_nganh'] ?? 0,
        tenChuongTrinhDaoTao: ctdtJson['ten_chuong_trinh_dao_tao'] ?? '',
        tongTinChi: ctdtJson['tong_tin_chi'] ?? 0,
        trangThai: ctdtJson['trang_thai'] ?? 0,
        thoiGian: ctdtJson['thoi_gian'] ?? 0,
        chiTiet: chiTietList,
      );
    }).toList();
  }

  factory ChuongTrinhDaoTao.empty() => ChuongTrinhDaoTao(
    id: 0,
    idChuyenNganh: 0,
    tenChuongTrinhDaoTao: '',
    tongTinChi: 0,
    trangThai: 0,
    thoiGian: 0,
    chiTiet: [],
  );
}

class ChiTietChuongTrinhDaoTao {
  final int id;
  final int idChuongTrinhDaoTao;
  final int idMonHoc;
  final int? idBoMon;
  final int idHocKy;
  final int soTiet;
  final int soTinChi;
  final MonHoc? monHoc;
  final HocKy? hocKy;
  ChiTietChuongTrinhDaoTao({
    required this.id,
    required this.idChuongTrinhDaoTao,
    required this.idMonHoc,
    required this.idBoMon,
    required this.idHocKy,
    required this.soTiet,
    required this.soTinChi,
    required this.hocKy,
    required this.monHoc,
  });

  factory ChiTietChuongTrinhDaoTao.fromJson(Map<String, dynamic> json) {
    return ChiTietChuongTrinhDaoTao(
      id: json['id'] ?? 0,
      idChuongTrinhDaoTao: json['id_chuong_trinh_dao_tao'] ?? 0,
      idMonHoc: json['id_mon_hoc'] ?? 0,
      idBoMon: json['id_bo_mon'] ?? 0,
      idHocKy: json['id_hoc_ky'] ?? 0,
      soTiet: int.tryParse(json['so_tiet'].toString() ?? '') ?? 0,
      soTinChi: int.tryParse(json['so_tin_chi'].toString() ?? "") ?? 0,
      monHoc: json['mon_hoc'] != null ? MonHoc.fromJson(json['mon_hoc']) : null,
      hocKy: json['hoc_ky'] != null ? HocKy.fromJson(json['hoc_ky']) : null,
    );
  }
}
