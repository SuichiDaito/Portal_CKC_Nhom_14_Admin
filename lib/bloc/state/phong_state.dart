import '../../api/model/admin_phong.dart';

abstract class PhongState {}

class PhongInitial extends PhongState {}

class PhongLoading extends PhongState {}

class PhongLoaded extends PhongState {
  final List<Room> rooms;

  PhongLoaded(this.rooms);
}

class PhongError extends PhongState {
  final String message;

  PhongError(this.message);
}

class PhongDetailLoaded extends PhongState {
  final Room room;
  PhongDetailLoaded(this.room);
}

class PhongSuccess extends PhongState {
  final String message;
  final Room room;
  PhongSuccess(this.message, this.room);
}
