import 'package:portal_ckc/api/model/admin_room.dart';

abstract class RoomState {}

class RoomInitial extends RoomState {}

class RoomLoading extends RoomState {}

class RoomLoaded extends RoomState {
  final List<Room> rooms;

  RoomLoaded(this.rooms);
}

class RoomError extends RoomState {
  final String message;

  RoomError(this.message);
}
