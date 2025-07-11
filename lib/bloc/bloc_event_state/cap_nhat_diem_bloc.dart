import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portal_ckc/api/controller/call_api_admin.dart';
import 'package:chopper/chopper.dart';
import '../event/cap_nhat_diem_event.dart';
import '../state/cap_nhat_diem_state.dart';

class CapNhatDiemBloc extends Bloc<CapNhatDiemEvent, CapNhatDiemState> {
  final _service = CallApiAdmin.adminService;

  CapNhatDiemBloc() : super(CapNhatDiemInitial()) {
    on<SubmitCapNhatDiem>(_onSubmit);
    on<GetLopHocPhanEvent>(_onGetLopHocPhan);
    on<GetDanhSachSinhVienEvent>(_onGetDanhSachSinhVien);
    on<UpdateTrangThaiNopDiemEvent>(_onUpdateTrangThai);
  }

  Future<void> _onSubmit(
    SubmitCapNhatDiem event,
    Emitter<CapNhatDiemState> emit,
  ) async {
    emit(CapNhatDiemLoading());
    try {
      final Response response = await _service.capNhatDiemMonHoc(
        event.request.toJson(),
      );
      if (response.isSuccessful) {
        emit(
          CapNhatDiemSuccess(
            response.body['message'] ?? 'Cập nhật điểm thành công!',
          ),
        );
      } else {
        emit(CapNhatDiemFailure('Cập nhật thất bại!'));
      }
    } catch (e) {
      emit(CapNhatDiemFailure('Lỗi: $e'));
    }
  }

  Future<void> _onGetLopHocPhan(
    GetLopHocPhanEvent event,
    Emitter<CapNhatDiemState> emit,
  ) async {
    emit(CapNhatDiemLoading());
    try {
      final Response response = await _service.getLopHocPhanList();
      if (response.isSuccessful) {
        emit(CapNhatDanhSachLopHocPhanSuccess(response.body));
      } else {
        emit(CapNhatDiemFailure('Lấy danh sách lớp học phần thất bại!'));
      }
    } catch (e) {
      emit(CapNhatDiemFailure('Lỗi: $e'));
    }
  }

  /// ✅ Lấy danh sách sinh viên của lớp học phần
  Future<void> _onGetDanhSachSinhVien(
    GetDanhSachSinhVienEvent event,
    Emitter<CapNhatDiemState> emit,
  ) async {
    emit(CapNhatDiemLoading());
    try {
      final Response response = await _service.getDanhSachSinhVienLopHocPhan(
        event.idLopHocPhan,
      );
      if (response.isSuccessful) {
        emit(CapNhatDanhSachSinhVienSuccess(response.body));
      } else {
        emit(CapNhatDiemFailure('Lấy danh sách sinh viên thất bại!'));
      }
    } catch (e) {
      emit(CapNhatDiemFailure('Lỗi: $e'));
    }
  }

  /// ✅ Nộp bảng điểm (update trạng thái)
  Future<void> _onUpdateTrangThai(
    UpdateTrangThaiNopDiemEvent event,
    Emitter<CapNhatDiemState> emit,
  ) async {
    emit(CapNhatDiemLoading());
    try {
      final Response response = await _service.updateTrangThaiNopDiem(
        event.idLopHocPhan,
      );
      if (response.isSuccessful) {
        emit(
          CapNhatDiemSuccess(
            response.body['message'] ?? 'Nộp bảng điểm thành công!',
          ),
        );
      } else {
        emit(CapNhatDiemFailure('Nộp bảng điểm thất bại!'));
      }
    } catch (e) {
      emit(CapNhatDiemFailure('Lỗi: $e'));
    }
  }
}
