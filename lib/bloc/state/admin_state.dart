import 'package:portal_ckc/api/model/admin_lop.dart';
import 'package:portal_ckc/api/model/admin_sinh_vien.dart';
import 'package:portal_ckc/api/model/admin_thong_tin.dart';

abstract class AdminState {}

class StudentListLoaded extends AdminState {
  final List<StudentWithRole> students;
  StudentListLoaded(this.students);
}

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

class ClassListLoaded extends AdminState {
  final List<Lop> lops;
  ClassListLoaded(this.lops);
}

// class StudentListLoaded extends AdminState {
//   final List<SinhVien> sinhViens;

//   StudentListLoaded(this.sinhViens);
// }

class AdminLoginSuccess extends AdminState {
  final User user;
  final String token;

  AdminLoginSuccess(this.user, this.token);
}

class AdminError extends AdminState {
  final String message;
  AdminError(this.message);
}

class AdminSuccessMessage extends AdminState {
  final String message;

  AdminSuccessMessage(this.message);
}

class ForgotPasswordLoading extends AdminState {}

class ForgotPasswordSuccess extends AdminState {
  final String hoTen;
  final String email;
  ForgotPasswordSuccess({required this.hoTen, required this.email});
}

class ForgotPasswordFailure extends AdminState {
  final String message;
  ForgotPasswordFailure(this.message);
}
