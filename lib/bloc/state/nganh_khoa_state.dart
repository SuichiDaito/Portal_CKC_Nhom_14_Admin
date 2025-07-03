import 'package:portal_ckc/api/model/admin_chuong_trinh_dao_tao.dart';
import 'package:portal_ckc/api/model/admin_phong_khoa.dart';

abstract class NganhKhoaState {}

/// Trạng thái khởi tạo
class NganhKhoaInitial extends NganhKhoaState {}

/// Trạng thái đang tải dữ liệu
class NganhKhoaLoading extends NganhKhoaState {}

/// Tải thành công danh sách khoa
class KhoaLoaded extends NganhKhoaState {
  final List<Khoa> danhSachKhoa;

  KhoaLoaded(this.danhSachKhoa);
}

/// Tải thành công danh sách ngành học
class NganhHocLoaded extends NganhKhoaState {
  final List<NganhHoc> danhSachNganh;

  NganhHocLoaded(this.danhSachNganh);
}

/// Tải thành công cả ngành học và khoa
class KhoaNganhLoaded extends NganhKhoaState {
  final List<Khoa> danhSachKhoa;
  final List<NganhHoc> danhSachNganh;

  KhoaNganhLoaded({required this.danhSachKhoa, required this.danhSachNganh});
}

/// Trạng thái lỗi
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
