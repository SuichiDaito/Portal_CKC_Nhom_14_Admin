import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portal_ckc/api/controller/call_api_admin.dart';
import 'package:portal_ckc/api/model/admin_phong.dart';
import 'package:portal_ckc/api/services/admin_service.dart';
import 'package:portal_ckc/bloc/event/phong_event.dart';
import 'package:portal_ckc/bloc/state/phong_state.dart';

class PhongBloc extends Bloc<PhongEvent, PhongState> {
  final AdminService service;

  PhongBloc() : service = CallApiAdmin.adminService, super(PhongInitial()) {
    on<FetchRoomsEvent>(_onFetchRooms);
    on<CreateRoomEvent>(_onCreateRoom);
    on<UpdateRoomEvent>(_onUpdateRoom);
    on<FetchRoomDetailEvent>(_onFetchRoomDetail);
  }

  Future<void> _onFetchRooms(
    FetchRoomsEvent event,
    Emitter<PhongState> emit,
  ) async {
    emit(PhongLoading());
    try {
      final response = await service.getRooms();
      if (response.isSuccessful && response.body != null) {
        final List<dynamic> roomList = response.body?['rooms'];
        final rooms = roomList.map((json) => Room.fromJson(json)).toList();
        emit(PhongLoaded(rooms));
      } else {
        emit(PhongError('Lỗi khi tải danh sách phòng'));
      }
    } catch (e) {
      emit(PhongError(e.toString()));
    }
  }

  Future<void> _onCreateRoom(
    CreateRoomEvent event,
    Emitter<PhongState> emit,
  ) async {
    emit(PhongLoading());
    try {
      final response = await service.createRoom(event.room.toJson());
      if (response.isSuccessful && response.body?['success'] == true) {
        final room = Room.fromJson(response.body?['room']);
        emit(PhongSuccess(response.body?['message'], room));
      } else {
        emit(PhongError(response.body?['message'] ?? 'Không thể tạo phòng'));
      }
    } catch (e) {
      emit(PhongError(e.toString()));
    }
  }

  Future<void> _onUpdateRoom(
    UpdateRoomEvent event,
    Emitter<PhongState> emit,
  ) async {
    emit(PhongLoading());
    try {
      final response = await service.updateRoom(event.id, event.room.toJson());
      if (response.isSuccessful && response.body?['success'] == true) {
        final room = Room.fromJson(response.body?['room']);
        emit(PhongSuccess(response.body?['message'], room));
      } else {
        emit(
          PhongError(response.body?['message'] ?? 'Không thể cập nhật phòng'),
        );
      }
    } catch (e) {
      emit(PhongError(e.toString()));
    }
  }

  Future<void> _onFetchRoomDetail(
    FetchRoomDetailEvent event,
    Emitter<PhongState> emit,
  ) async {
    emit(PhongLoading());
    try {
      final response = await service.getRoomDetail(event.id);
      if (response.isSuccessful && response.body?['success'] == true) {
        final room = Room.fromJson(response.body?['room']);
        emit(PhongDetailLoaded(room));
      } else {
        emit(PhongError(response.body?['message'] ?? 'Không tìm thấy phòng'));
      }
    } catch (e) {
      emit(PhongError(e.toString()));
    }
  }
}
