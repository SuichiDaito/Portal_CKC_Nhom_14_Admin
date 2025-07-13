abstract class UserEvent {}

class FetchUsersEvent extends UserEvent {}

class UpdateUserRoleEvent extends UserEvent {
  final int userId;
  final int roleId;

  UpdateUserRoleEvent({required this.userId, required this.roleId});
}
