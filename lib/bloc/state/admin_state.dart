import 'package:portal_ckc/api/model/admin_lop.dart';
import 'package:portal_ckc/api/model/admin_sinh_vien.dart';
import 'package:portal_ckc/api/model/admin_thong_tin.dart';

abstract class AdminState {}

class AdminInitial extends AdminState {}

class AdminLoading extends AdminState {}

class AdminLoaded extends AdminState {
  final User user;
  AdminLoaded(this.user);
}

class AdminSuccess extends AdminState {
  final User user;
  AdminSuccess(this.user);
}

//Load danh sách lớp chủ nhiệm
class ClassListLoaded extends AdminState {
  final List<Lop> lops;
  ClassListLoaded(this.lops);
}

//load danh sách sv lớp cn
class StudentListLoaded extends AdminState {
  final List<SinhVien> sinhViens;

  StudentListLoaded(this.sinhViens);
}

class AdminLoginSuccess extends AdminState {
  final User user;
  final String token;

  AdminLoginSuccess(this.user, this.token);
}

class AdminError extends AdminState {
  final String message;
  AdminError(this.message);
}
