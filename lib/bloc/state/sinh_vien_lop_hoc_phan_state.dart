import 'package:portal_ckc/api/model/admin_lop_hoc_phan.dart';
import 'package:portal_ckc/api/model/admin_sinh_vien_lhp.dart';

abstract class SinhVienLhpState {}

class SinhVienLhpInitial extends SinhVienLhpState {}

class SinhVienLhpLoading extends SinhVienLhpState {}

class SinhVienLhpLoaded extends SinhVienLhpState {
  final LopHocPhan? lopHocPhan; // <-- cho phép null
  final List<SinhVienLopHocPhan> danhSach;

  SinhVienLhpLoaded({this.lopHocPhan, required this.danhSach});
}

class SinhVienLhpError extends SinhVienLhpState {
  final String message;
  SinhVienLhpError(this.message);
}
