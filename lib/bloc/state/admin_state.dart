import 'package:portal_ckc/api/model/admin_thongtin.dart';

abstract class AdminState {}

class AdminInitial extends AdminState {}

class AdminLoading extends AdminState {}

class AdminSuccess extends AdminState {
  final User user;

  AdminSuccess(this.user);
}

class AdminLoaded extends AdminState {
  final User user;

  AdminLoaded(this.user);
}

class AdminError extends AdminState {
  final String message;

  AdminError(this.message);
}
