import 'package:portal_ckc/api/model/admin_chuong_trinh_dao_tao.dart';
import 'package:portal_ckc/api/model/admin_lop.dart';
import 'package:portal_ckc/api/model/admin_thoi_khoa_bieu.dart';
import 'package:portal_ckc/api/model/admin_thong_tin.dart';
import 'package:portal_ckc/presentation/sections/card/schedule_management_detail_model.dart';

class LopHocPhan {
  int id;
  String tenHocPhan;
  int idGiangVien;
  int idChuongTrinhDaoTao;
  int idLop;
  int loaiLopHocPhan;
  int soLuongDangKy;
  int loaiMon;
  int trangThai;
  int? trangThaiNopBangDiem;
  Lop lop;
  User? gv;
  ChuongTrinhDaoTao chuongTrinhDaoTao;
  List<ThoiKhoaBieu> thoiKhoaBieu;
  LopHocPhan({
    required this.id,
    required this.tenHocPhan,
    required this.idGiangVien,
    required this.idChuongTrinhDaoTao,
    required this.idLop,
    required this.loaiLopHocPhan,
    required this.soLuongDangKy,
    required this.loaiMon,
    required this.trangThaiNopBangDiem,
    required this.trangThai,
    required this.lop,
    required this.chuongTrinhDaoTao,
    required this.gv,
    required this.thoiKhoaBieu,
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
    trangThaiNopBangDiem: json['trang_thai_nop_bang_diem'] ?? 0,
    lop: json['lop'] != null ? Lop.fromJson(json['lop']) : Lop.empty(),
    gv: json['giang_vien'] != null ? User.fromJson(json['giang_vien']) : null,
    chuongTrinhDaoTao: json['chuong_trinh_dao_tao'] != null
        ? ChuongTrinhDaoTao.fromJson(json['chuong_trinh_dao_tao'])
        : ChuongTrinhDaoTao.empty(),
    thoiKhoaBieu:
        (json['thoi_khoa_bieu'] as List<dynamic>?)
            ?.map((e) => ThoiKhoaBieu.fromJson(e))
            .toList() ??
        [],
  );
  static LopHocPhan empty() => LopHocPhan(
    id: 0,
    tenHocPhan: '',
    idGiangVien: 0,
    idChuongTrinhDaoTao: 0,
    idLop: 0,
    loaiLopHocPhan: 0,
    soLuongDangKy: 0,
    loaiMon: 0,
    trangThai: 0,
    trangThaiNopBangDiem: 0,
    lop: Lop.empty(),
    chuongTrinhDaoTao: ChuongTrinhDaoTao.empty(),
    gv: null,
    thoiKhoaBieu: [],
  );
}

extension LopHocPhanExtension on LopHocPhan {
  ScheduleDetail get details {
    final schedules = thoiKhoaBieu.map((tkb) {
      final date = DateTime.tryParse(tkb.ngay);
      final thu = date != null ? _getThuFromDate(date) : 'Không xác định';
      return ScheduleTime(
        id: id,
        thu: thu,
        ngay: tkb.ngay,
        tietBatDau: tkb.tietBatDau,
        tietKetThuc: tkb.tietKetThuc,
        phong: tkb.phong.ten,
      );
    }).toList();

    final room = schedules.isNotEmpty ? schedules.first.phong : '';

    return ScheduleDetail(room: room, schedules: schedules);
  }
}

String _getThuFromDate(DateTime date) {
  switch (date.weekday) {
    case DateTime.monday:
      return 'Thứ 2';
    case DateTime.tuesday:
      return 'Thứ 3';
    case DateTime.wednesday:
      return 'Thứ 4';
    case DateTime.thursday:
      return 'Thứ 5';
    case DateTime.friday:
      return 'Thứ 6';
    case DateTime.saturday:
      return 'Thứ 7';
    case DateTime.sunday:
      return 'Chủ nhật';
    default:
      return 'Không xác định';
  }
}

class ScheduleDetail {
  String room;
  List<ScheduleTime> schedules;

  ScheduleDetail({required this.room, required this.schedules});
}

class ScheduleTime {
  int? id;
  String ngay;
  String thu;
  int tietBatDau;
  int tietKetThuc;
  String phong;

  ScheduleTime({
    required this.id,
    required this.ngay,
    required this.thu,
    required this.tietBatDau,
    required this.tietKetThuc,
    required this.phong,
  });
}
