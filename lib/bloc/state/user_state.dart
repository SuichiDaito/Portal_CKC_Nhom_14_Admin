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

class UserRoleUpdating extends UserState {}

class UserRoleUpdated extends UserState {
  final String message;

  UserRoleUpdated(this.message);
}

class UserRoleUpdateError extends UserState {
  final String error;

  UserRoleUpdateError(this.error);
}
