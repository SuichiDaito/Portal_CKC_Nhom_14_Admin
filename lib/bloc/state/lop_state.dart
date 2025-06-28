import 'package:portal_ckc/api/model/admin_danh_sach_lop.dart';
import 'package:portal_ckc/api/model/admin_lop.dart';

abstract class LopDetailState {}

class LopDetailInitial extends LopDetailState {}

class LopDetailLoading extends LopDetailState {}

class LopDetailLoaded extends LopDetailState {
  final LopChiTietResponse data;
  LopDetailLoaded(this.data);
}

class LopDetailError extends LopDetailState {
  final String message;
  LopDetailError(this.message);
}

class AllLopLoaded extends LopDetailState {
  final List<Lop> danhSachLop;
  AllLopLoaded(this.danhSachLop);
}

class ChangeStudentRoleSuccess extends LopDetailState {
  final String message;
  ChangeStudentRoleSuccess(this.message);
}

class ChangeStudentRoleFailed extends LopDetailState {
  final String message;
  ChangeStudentRoleFailed(this.message);
}
