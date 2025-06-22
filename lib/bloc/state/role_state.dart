import 'package:portal_ckc/api/model/admin_vai_tro.dart';

abstract class RoleState {}

class RoleInitial extends RoleState {}

class RoleLoading extends RoleState {}

class RoleLoaded extends RoleState {
  final List<Role> roles;
  RoleLoaded(this.roles);
}

class RoleError extends RoleState {
  final String message;
  RoleError(this.message);
}
