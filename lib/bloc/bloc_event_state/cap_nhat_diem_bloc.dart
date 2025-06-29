import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portal_ckc/api/controller/call_api_admin.dart';
import '../event/cap_nhat_diem_event.dart';
import '../state/cap_nhat_diem_state.dart';
import 'package:chopper/chopper.dart';
import 'dart:convert';

class CapNhatDiemBloc extends Bloc<CapNhatDiemEvent, CapNhatDiemState> {
  final _service = CallApiAdmin.adminService;

  CapNhatDiemBloc() : super(CapNhatDiemInitial()) {
    on<SubmitCapNhatDiem>(_onSubmit);
  }
  Future<void> _onSubmit(
    SubmitCapNhatDiem event,
    Emitter<CapNhatDiemState> emit,
  ) async {
    emit(CapNhatDiemLoading());

    try {
      print('👉 Gửi dữ liệu: ${event.request.toJson()}');
      final Response response = await _service.capNhatDiemMonHoc(
        event.request.toJson(),
      );

      if (response.isSuccessful) {
        // Tùy vào kiểu response, kiểm tra kiểu trước khi dùng
        final resBody = response.body;
        if (resBody is Map && resBody['message'] != null) {
          emit(CapNhatDiemSuccess(resBody['message']));
        } else {
          emit(CapNhatDiemSuccess('Cập nhật thành công!'));
        }
      } else {
        print('❌ Response thất bại: ${response.error}');
        final error = response.error;
        emit(
          CapNhatDiemFailure(
            error is String ? error : 'Có lỗi xảy ra khi gửi dữ liệu.',
          ),
        );
      }
    } catch (e) {
      print('🔥 Lỗi gọi API: $e');
      emit(CapNhatDiemFailure('Lỗi kết nối hoặc máy chủ: ${e.toString()}'));
    }
  }
}
