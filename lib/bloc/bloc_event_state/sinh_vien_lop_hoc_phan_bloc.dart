import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portal_ckc/api/controller/call_api_admin.dart';
import 'package:portal_ckc/api/model/admin_lop_hoc_phan.dart';
import 'package:portal_ckc/api/model/admin_sinh_vien_lhp.dart';
import 'package:portal_ckc/bloc/event/sinh_vien_lop_hoc_phan_event.dart';
import 'package:portal_ckc/bloc/state/sinh_vien_lop_hoc_phan_state.dart';

class SinhVienLhpBloc extends Bloc<SinhVienLhpEvent, SinhVienLhpState> {
  final _service = CallApiAdmin.adminService;

  SinhVienLhpBloc() : super(SinhVienLhpInitial()) {
    on<FetchSinhVienLhp>(_onFetch);
  }

  Future<void> _onFetch(
    FetchSinhVienLhp event,
    Emitter<SinhVienLhpState> emit,
  ) async {
    emit(SinhVienLhpLoading());
    try {
      final response = await _service.getDanhSachSinhVienLopHocPhan(
        event.lopHocPhanId,
      );
      if (response.isSuccessful) {
        final data = response.body;

        final lopHocPhanJson = data?['lop_hoc_phan'];
        final lopHocPhan = LopHocPhan.fromJson(lopHocPhanJson);

        final sinhViensJson = data?['sinh_viens'] as List;
        final danhSach = sinhViensJson
            .map((e) => SinhVienLopHocPhan.fromJson(e, event.lopHocPhanId))
            .toList();

        emit(SinhVienLhpLoaded(lopHocPhan: lopHocPhan, danhSach: danhSach));
      } else {
        emit(SinhVienLhpError('Lỗi: ${response.error}'));
      }
    } catch (e) {
      emit(SinhVienLhpError('Exception: $e'));
    }
  }
}
