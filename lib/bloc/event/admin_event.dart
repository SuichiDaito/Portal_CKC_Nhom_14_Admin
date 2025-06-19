import 'package:equatable/equatable.dart';

abstract class AdminEvent {}

//login
class AdminLoginEvent extends AdminEvent {
  final String taiKhoan;
  final String password;

  AdminLoginEvent({required this.taiKhoan, required this.password});
}

//lấy thông tin gv theo id
class FetchAdminDetail extends AdminEvent {
  final int userId;

  FetchAdminDetail(this.userId); // ✅ constructor đúng
}

//lấy danh sách lớp chủ nhiệm
class FetchClassList extends AdminEvent {
  final int gvcnId;
  FetchClassList(this.gvcnId);
}

//Lấy danh sách sinh viên theo id lớp
class FetchStudentList extends AdminEvent {
  final int lopId;

  FetchStudentList(this.lopId);
}
