import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portal_ckc/api/controller/call_api_admin.dart';
import 'package:portal_ckc/api/model/admin_lop_hoc_phan.dart';
import 'package:portal_ckc/bloc/event/lop_hoc_phan_event.dart';
import 'package:portal_ckc/bloc/state/lop_hoc_phan_state.dart';

class LopHocPhanBloc extends Bloc<LopHocPhanEvent, LopHocPhanState> {
  final _service = CallApiAdmin.adminService;

  LopHocPhanBloc() : super(LopHocPhanInitial()) {
    on<FetchLopHocPhan>(_onFetch);
  }

  Future<void> _onFetch(
    FetchLopHocPhan event,
    Emitter<LopHocPhanState> emit,
  ) async {
    emit(LopHocPhanLoading());
    try {
      final lopHocPhans = await fetchLopHocPhanFromApi();
      emit(LopHocPhanLoaded(lopHocPhans));
    } catch (e) {
      emit(LopHocPhanError(e.toString()));
    }
  }

  Future<List<LopHocPhan>> fetchLopHocPhanFromApi() async {
    final response = await _service.getLopHocPhanList();
    if (response.isSuccessful) {
      final body = response.body;
      if (body != null && body['lop_hoc_phan'] is List) {
        final data = body['lop_hoc_phan'] as List<dynamic>;
        return data.map((item) => LopHocPhan.fromJson(item)).toList();
      } else {
        throw Exception('Dữ liệu trả về không đúng định dạng hoặc null.');
      }
    } else {
      throw Exception('Lỗi khi tải lớp học phần: ${response.error}');
    }
  }
}
