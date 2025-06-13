import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portal_ckc/api/model/admin_room.dart';
import 'package:portal_ckc/api/services/admin_service.dart';
import 'package:portal_ckc/bloc/event/admin_room_event.dart';
import 'package:portal_ckc/bloc/state/admin_room_state.dart';

class RoomBloc extends Bloc<RoomEvent, RoomState> {
  final AdminService adminService;

  RoomBloc(this.adminService) : super(RoomInitial()) {
    on<FetchRooms>(_onFetchRooms);
  }
  Future<void> _onFetchRooms(FetchRooms event, Emitter<RoomState> emit) async {
    emit(RoomLoading());
    try {
      final response = await adminService.getRooms();

      if (response.isSuccessful && response.body != null) {
        final body = response.body!;
        final List<dynamic> roomsJson = body['rooms'];
        final rooms = roomsJson.map((e) => Room.fromJson(e)).toList();
        emit(RoomLoaded(rooms));
      } else {
        emit(RoomError('Lỗi tải dữ liệu: ${response.statusCode}'));
      }
    } catch (e) {
      emit(RoomError('Lỗi: $e'));
    }
  }
}
