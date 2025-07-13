import 'package:portal_ckc/api/model/admin_sinh_vien.dart';

abstract class SinhVienState {}

class SinhVienInitial extends SinhVienState {}

class SinhVienLoading extends SinhVienState {}

class SinhVienLoaded extends SinhVienState {
  final List<SinhVien> danhSach;

  SinhVienLoaded(this.danhSach);
}

class SinhVienError extends SinhVienState {
  final String message;

  SinhVienError(this.message);
}
