import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portal_ckc/api/model/admin_vai_tro.dart';
import '../../api/controller/call_api_admin.dart';
import '../event/role_event.dart';
import '../state/role_state.dart';

class RoleBloc extends Bloc<RoleEvent, RoleState> {
  final _service = CallApiAdmin.adminService;

  RoleBloc() : super(RoleInitial()) {
    on<FetchRolesEvent>(_onFetchRoles);
  }

  Future<void> _onFetchRoles(
    FetchRolesEvent event,
    Emitter<RoleState> emit,
  ) async {
    emit(RoleLoading());
    try {
      final response = await _service.getDanhSachVaiTro();
      if (response.isSuccessful && response.body != null) {
        final roles = (response.body!["roles"] as List)
            .map((e) => Role.fromJson(e))
            .toList();
        emit(RoleLoaded(roles));
      } else {
        emit(RoleError("Không lấy được danh sách vai trò"));
      }
    } catch (e) {
      emit(RoleError("Lỗi: ${e.toString()}"));
    }
  }
}
