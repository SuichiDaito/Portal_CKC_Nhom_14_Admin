import 'package:portal_ckc/api/model/admin_nien_khoa.dart';

abstract class NienKhoaHocKyState {}

class NienKhoaHocKyInitial extends NienKhoaHocKyState {}

class NienKhoaHocKyLoading extends NienKhoaHocKyState {}

class NienKhoaHocKyLoaded extends NienKhoaHocKyState {
  final List<NienKhoa> nienKhoas;

  NienKhoaHocKyLoaded(this.nienKhoas);
}

class NienKhoaHocKyError extends NienKhoaHocKyState {
  final String message;

  NienKhoaHocKyError(this.message);
}
