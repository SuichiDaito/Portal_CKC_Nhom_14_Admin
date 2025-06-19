import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portal_ckc/api/model/admin_diem_ren_luyen_response.dart';
import 'package:portal_ckc/api/services/admin_service.dart';
import 'package:portal_ckc/bloc/event/diem_rl_event.dart';
import 'package:portal_ckc/bloc/state/diem_rl_state.dart';

class DiemRLBloc extends Bloc<DiemRLEvent, DiemRLState> {
  final AdminService service;

  DiemRLBloc({required this.service}) : super(DiemRLLoading()) {
    on<FetchDiemRenLuyen>(_onFetch);
  }

  Future<void> _onFetch(
    FetchDiemRenLuyen event,
    Emitter<DiemRLState> emit,
  ) async {
    emit(DiemRLLoading());
    try {
      final res = await service.fetchDiemRenLuyen(event.lopId, event.thoiGian);
      if (res.isSuccessful) {
        final data = DiemRenLuyenResponse.fromJson(res.body);
        emit(DiemRLLoaded(data));
      } else {
        emit(DiemRLError('Lỗi lấy dữ liệu: ${res.error}'));
      }
    } catch (e) {
      emit(DiemRLError('Lỗi mạng hoặc server: $e'));
    }
  }
}
