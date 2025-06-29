import 'package:portal_ckc/api/model/admin_phong.dart';

abstract class PhongEvent {}

class FetchRoomsEvent extends PhongEvent {}

class CreateRoomEvent extends PhongEvent {
  final Room room;
  CreateRoomEvent(this.room);
}

class UpdateRoomEvent extends PhongEvent {
  final int id;
  final Room room;
  UpdateRoomEvent({required this.id, required this.room});
}

class FetchRoomDetailEvent extends PhongEvent {
  final int id;
  FetchRoomDetailEvent(this.id);
}
