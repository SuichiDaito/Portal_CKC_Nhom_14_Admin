import 'package:portal_ckc/api/model/admin_chuong_trinh_dao_tao.dart';
import 'package:portal_ckc/api/model/admin_phong_khoa.dart';

abstract class NganhKhoaState {}

class NganhKhoaInitial extends NganhKhoaState {}

class NganhKhoaLoading extends NganhKhoaState {}

class KhoaLoaded extends NganhKhoaState {
  final List<Khoa> danhSachKhoa;

  KhoaLoaded(this.danhSachKhoa);
}

class NganhHocLoaded extends NganhKhoaState {
  final List<ChuyenNganh> danhSachNganh;

  NganhHocLoaded(this.danhSachNganh);
}

class KhoaNganhLoaded extends NganhKhoaState {
  final List<Khoa> danhSachKhoa;
  final List<ChuyenNganh> danhSachNganh;

  KhoaNganhLoaded({required this.danhSachKhoa, required this.danhSachNganh});
}

class NganhKhoaError extends NganhKhoaState {
  final String message;

  NganhKhoaError(this.message);
}

class BoMonLoaded extends NganhKhoaState {
  final List<BoMon> boMons;
  BoMonLoaded(this.boMons);
}

class CTCTDTLoaded extends NganhKhoaState {
  final List<ChiTietChuongTrinhDaoTao> chiTiet;

  CTCTDTLoaded(this.chiTiet);
}
