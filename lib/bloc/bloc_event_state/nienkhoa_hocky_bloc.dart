import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portal_ckc/api/controller/call_api_admin.dart';
import 'package:portal_ckc/api/model/admin_nien_khoa.dart';
import 'package:portal_ckc/bloc/event/nienkhoa_hocky_event.dart';
import 'package:portal_ckc/bloc/state/nienkhoa_hocky_state.dart';

class NienKhoaHocKyBloc extends Bloc<NienKhoaHocKyEvent, NienKhoaHocKyState> {
  final _service = CallApiAdmin.adminService;

  NienKhoaHocKyBloc() : super(NienKhoaHocKyInitial()) {
    on<FetchNienKhoaHocKy>(_onFetch);
  }

  Future<void> _onFetch(
    FetchNienKhoaHocKy event,
    Emitter<NienKhoaHocKyState> emit,
  ) async {
    emit(NienKhoaHocKyLoading());

    try {
      final response = await _service.fetchNienKhoaHocKy();

      if (response.isSuccessful && response.body != null) {
        final List<dynamic> dataList = response.body?['nienkhoa'];
        final List<NienKhoa> nienKhoas = dataList
            .map((e) => NienKhoa.fromJson(e))
            .toList();
        emit(NienKhoaHocKyLoaded(nienKhoas));
      } else {
        emit(NienKhoaHocKyError('Lỗi khi tải dữ liệu niên khóa'));
      }
    } catch (e) {
      emit(NienKhoaHocKyError('Lỗi: $e'));
    }
  }
}
