import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portal_ckc/api/controller/call_api_admin.dart';
import 'package:portal_ckc/api/model/admin_sinh_vien.dart';
import '../../api/services/admin_service.dart';
import '../event/sinh_vien_event.dart';
import '../state/sinh_vien_state.dart';

class SinhVienBloc extends Bloc<SinhVienEvent, SinhVienState> {
  final AdminService service;

  SinhVienBloc()
    : service = CallApiAdmin.adminService,
      super(SinhVienInitial()) {
    on<FetchAllSinhViensEvent>(_onFetchAllSinhViens);
  }

  Future<void> _onFetchAllSinhViens(
    FetchAllSinhViensEvent event,
    Emitter<SinhVienState> emit,
  ) async {
    emit(SinhVienLoading());
    try {
      final response = await service.getAllSinhViens();
      print('Response body: ${response.body}');
      print('======================================');
      if (response.isSuccessful && response.body != null) {
        final List<dynamic> data = response.body?['sinh_viens'];
        final danhSach = data.map((e) => SinhVien.fromJson(e)).toList();
        emit(SinhVienLoaded(danhSach));
        print('==================================================');
        print("THÀNH CÔNG");
      } else {
        emit(SinhVienError('Lỗi khi tải danh sách sinh viên'));
      }
    } catch (e, stackTrace) {
      print('===============CATCH======================');
      print('Error: $e');
      print('StackTrace: $stackTrace');
      emit(SinhVienError(e.toString()));
    }
  }
}
