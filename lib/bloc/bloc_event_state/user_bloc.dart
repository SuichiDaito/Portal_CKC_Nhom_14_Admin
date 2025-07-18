import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portal_ckc/api/controller/call_api_admin.dart';
import 'package:portal_ckc/api/model/admin_thong_tin.dart';
import 'package:portal_ckc/bloc/event/user_event.dart';
import 'package:portal_ckc/bloc/state/user_state.dart';
import '../../api/services/admin_service.dart';
import 'package:chopper/chopper.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final AdminService service;

  UserBloc() : service = CallApiAdmin.adminService, super(UserInitial()) {
    on<FetchUsersEvent>(_onFetchUsers);
    on<UpdateUserRoleEvent>(_onUpdateUserRole);
  }

  Future<void> _onFetchUsers(
    FetchUsersEvent event,
    Emitter<UserState> emit,
  ) async {
    emit(UserLoading());
    try {
      final Response response = await service.getAllUsers();

      if (response.isSuccessful && response.body != null) {
        final List<dynamic> rawList = response.body;
        final List<User> users = rawList
            .map((e) => User.fromJson(e as Map<String, dynamic>))
            .toList();

        emit(UserLoaded(users));
      } else {
        emit(UserError("Không thể tải danh sách người dùng"));
      }
    } catch (e) {
      emit(UserError("Lỗi khi gọi API: $e"));
    }
  }

  Future<void> _onUpdateUserRole(
    UpdateUserRoleEvent event,
    Emitter<UserState> emit,
  ) async {
    emit(UserRoleUpdating());
    try {
      final response = await service.updateTeacherRole(event.userId, {
        'role_id': event.roleId,
      });

      if (response.isSuccessful && response.body != null) {
        final body = response.body as Map<String, dynamic>;
        emit(UserRoleUpdated(body['message'] ?? 'Cập nhật thành công'));
      } else {
        emit(UserRoleUpdateError('Không thể cập nhật chức vụ'));
      }
    } catch (e) {
      emit(UserRoleUpdateError('Lỗi khi cập nhật: $e'));
    }
  }
}
