import 'package:equatable/equatable.dart';

abstract class AdminEvent {}

class AdminLoginEvent extends AdminEvent {
  final String taiKhoan;
  final String password;

  AdminLoginEvent({required this.taiKhoan, required this.password});
}

class FetchAdminDetail extends AdminEvent {
  final int userId;

  FetchAdminDetail({required this.userId});
}
