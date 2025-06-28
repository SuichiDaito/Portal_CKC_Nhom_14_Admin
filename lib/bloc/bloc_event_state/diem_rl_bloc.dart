import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portal_ckc/api/controller/call_api_admin.dart';
import 'package:portal_ckc/api/model/admin_diem_ren_luyen_response.dart';
import 'package:portal_ckc/api/services/admin_service.dart';
import 'package:portal_ckc/bloc/event/diem_rl_event.dart';
import 'package:portal_ckc/bloc/state/diem_rl_state.dart';

class DiemRlBloc extends Bloc<DiemRLEvent, DiemRLState> {
  final _service = CallApiAdmin.adminService;

  DiemRlBloc() : super(DiemRLInitial()) {
    on<FetchDiemRenLuyen>(_onFetch);
    on<UpdateBulkDiemRenLuyen>(_onUpdateBulk);
  }
  Future<void> _onFetch(
    FetchDiemRenLuyen event,
    Emitter<DiemRLState> emit,
  ) async {
    emit(DiemRLLoading());
    try {
      final res = await _service.fetchDiemRenLuyen(
        event.lopId,
        event.thoiGian,
        event.nam,
      );

      if (res.isSuccessful && res.body != null) {
        final data = NhapDiemRLResponse.fromJson(res.body);
        emit(DiemRLLoaded(data));
      } else {
        emit(
          DiemRLError('Lỗi lấy dữ liệu: ${res.error ?? 'Không có dữ liệu'}'),
        );
      }
    } catch (e) {
      emit(DiemRLError('Lỗi mạng hoặc server: $e'));
    }
  }

  Future<void> _onUpdateBulk(
    UpdateBulkDiemRenLuyen event,
    Emitter<DiemRLState> emit,
  ) async {
    try {
      final res = await _service.updateBulkDiemRenLuyen(
        thoiGian: event.thoiGian,
        nam: event.nam,
        xepLoai: event.xepLoai,
        selectedStudents: jsonEncode(event.selectedStudentIds),
      );

      if (res.isSuccessful && res.body?['success'] == true) {
        emit(
          DiemRLUpdateSuccess(res.body?['message'] ?? 'Cập nhật thành công'),
        );
      } else {
        emit(DiemRLUpdateFailure(res.body?['message'] ?? 'Cập nhật thất bại'));
      }
    } catch (e) {
      emit(DiemRLUpdateFailure('Lỗi mạng hoặc server: $e'));
    }
  }
}
