import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portal_ckc/api/controller/call_api_admin.dart';
import 'package:portal_ckc/api/model/admin_giay_xac_nhan.dart';
import 'package:portal_ckc/bloc/event/giay_xac_nhan_event.dart';
import 'package:portal_ckc/bloc/state/giay_xac_nhan_state.dart';

class DangKyGiayBloc extends Bloc<DangKyGiayEvent, DangKyGiayState> {
  final _service = CallApiAdmin.adminService;

  DangKyGiayBloc() : super(DangKyGiayInitial()) {
    on<FetchDangKyGiayEvent>(_onFetch);
    on<ConfirmMultipleGiayXacNhanEvent>(_onConfirmMultiple);
  }

  Future<void> _onFetch(
    FetchDangKyGiayEvent event,
    Emitter<DangKyGiayState> emit,
  ) async {
    emit(DangKyGiayLoading());
    try {
      final response = await _service.getDanhSachGiayXacNhan();

      if (response.isSuccessful && response.body['data'] != null) {
        final List<dynamic> data = response.body['data'];
        final danhSach = data
            .map((item) => DangKyGiayModel.fromJson(item))
            .toList();
        emit(DangKyGiayLoaded(danhSach));
      } else {
        emit(DangKyGiayError('Không thể lấy dữ liệu từ server.'));
      }
    } catch (e) {
      emit(DangKyGiayError('Lỗi: ${e.toString()}'));
    }
  }

  Future<void> _onConfirmMultiple(
    ConfirmMultipleGiayXacNhanEvent event,
    Emitter<DangKyGiayState> emit,
  ) async {
    emit(DangKyGiayLoading());
    try {
      final response = await _service.confirmMultipleGiayXacNhan({
        'ids': event.ids,
        'id_giang_vien': event.userId,
        'trang_thai': 1,
      });

      if (response.isSuccessful && response.body['success'] == true) {
        // Gọi lại API lấy danh sách
        final resFetch = await _service.getDanhSachGiayXacNhan();
        if (resFetch.isSuccessful && resFetch.body['data'] != null) {
          final data = resFetch.body['data'] as List;
          final danhSach = data
              .map((e) => DangKyGiayModel.fromJson(e))
              .toList();
          emit(DangKyGiayLoaded(danhSach));
        } else {
          emit(DangKyGiayError("Xác nhận xong nhưng không load được dữ liệu."));
        }
      } else {
        emit(DangKyGiayError(response.body['message'] ?? 'Xác nhận thất bại.'));
      }
    } catch (e) {
      emit(DangKyGiayError('Lỗi: ${e.toString()}'));
    }
  }
}
