import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portal_ckc/api/controller/call_api_admin.dart';
import 'package:portal_ckc/api/model/admin_phong.dart';
import 'package:portal_ckc/api/services/admin_service.dart';

import '../event/phong_event.dart';
import '../state/phong_state.dart';

class PhongBloc extends Bloc<PhongEvent, PhongState> {
  final AdminService service;

  PhongBloc() : service = CallApiAdmin.adminService, super(PhongInitial()) {
    on<FetchRoomsEvent>(_onFetchRooms);
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
}
