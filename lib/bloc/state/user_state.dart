import 'package:portal_ckc/api/model/admin_thong_tin.dart';

abstract class UserState {}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserLoaded extends UserState {
  final List<User> users;
  UserLoaded(this.users);
}

class UserError extends UserState {
  final String message;
  UserError(this.message);
}
