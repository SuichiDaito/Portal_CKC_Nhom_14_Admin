import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portal_ckc/api/model/admin_phieu_len_lop.dart';
import 'package:portal_ckc/api/controller/call_api_admin.dart';
import 'package:portal_ckc/bloc/event/phieu_len_lop_event.dart';
import 'package:portal_ckc/bloc/state/phieu_len_lop_state.dart';

class PhieuLenLopBloc extends Bloc<PhieuLenLopEvent, PhieuLenLopState> {
  final _service = CallApiAdmin.adminService;

  PhieuLenLopBloc() : super(PhieuLenLopInitial()) {
    on<FetchAllPhieuLenLop>(_onFetchAll);
    on<CreatePhieuLenLop>(_onCreate);
  }

  Future<void> _onFetchAll(
    FetchAllPhieuLenLop event,
    Emitter<PhieuLenLopState> emit,
  ) async {
    emit(PhieuLenLopLoading());
    try {
      final response = await _service.getPhieuLenLopAll();
      if (response.isSuccessful && response.body != null) {
        final data = response.body['data'] as List;
        final result = data.map((e) => PhieuLenLop.fromJson(e)).toList();
        emit(PhieuLenLopLoaded(result));
      } else {
        emit(PhieuLenLopError(response.error.toString()));
      }
    } catch (e) {
      emit(PhieuLenLopError(e.toString()));
    }
  }

  Future<void> _onCreate(
    CreatePhieuLenLop event,
    Emitter<PhieuLenLopState> emit,
  ) async {
    emit(PhieuLenLopLoading());
    try {
      final response = await _service.storePhieuLenLop(event.payload);
      if (response.isSuccessful && response.body['status'] == true) {
        emit(PhieuLenLopSuccess(response.body['message']));
      } else {
        emit(PhieuLenLopError('Không thể lưu phiếu lên lớp.'));
      }
    } catch (e) {
      emit(PhieuLenLopError(e.toString()));
    }
  }
}
