import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portal_ckc/api/controller/call_api_admin.dart';
import 'package:portal_ckc/api/model/admin_danh_sach_lop.dart';
import 'package:portal_ckc/api/model/admin_lop.dart';
import 'package:portal_ckc/bloc/event/lop_event.dart';
import 'package:portal_ckc/bloc/state/lop_state.dart';

class LopBloc extends Bloc<LopDetailEvent, LopDetailState> {
  final _service = CallApiAdmin.adminService;

  LopBloc() : super(LopDetailInitial()) {
    on<FetchLopDetail>(_onFetchLopDetail);
    on<FetchAllLopEvent>(_onFetchAllLop);
    on<ChangeStudentRoleEvent>(_onChangeStudentRole);
  }

  Future<void> _onFetchLopDetail(
    FetchLopDetail event,
    Emitter<LopDetailState> emit,
  ) async {
    emit(LopDetailLoading());
    try {
      final response = await _service.getLopChiTiet(event.lopId);

      if (response.isSuccessful && response.body != null) {
        try {
          final data = LopChiTietResponse.fromJson(response.body!);
          print('DEBUG JSON: ${response.body}');

          emit(LopDetailLoaded(data));
        } catch (e) {
          emit(LopDetailError("Lỗi parse dữ liệu lớp: $e"));
        }
      } else {
        emit(LopDetailError("Không nhận được dữ liệu chi tiết lớp."));
      }
    } catch (e) {
      emit(LopDetailError("Lỗi mạng: ${e.toString()}"));
    }
  }

  Future<void> _onFetchAllLop(
    FetchAllLopEvent event,
    Emitter<LopDetailState> emit,
  ) async {
    emit(LopDetailLoading());
    try {
      final response = await _service.getDanhSachLop();

      if (response.isSuccessful && response.body != null) {
        final rawData = response.body!['lops'];
        if (rawData != null && rawData is List) {
          try {
            final danhSach = rawData
                .map((e) => Lop.fromJson(e as Map<String, dynamic>))
                .toList();
            emit(AllLopLoaded(danhSach));
          } catch (e) {
            emit(LopDetailError("Lỗi parse danh sách lớp: $e"));
          }
        } else {
          emit(
            LopDetailError("Dữ liệu trả về không đúng định dạng danh sách."),
          );
        }
      } else {
        emit(LopDetailError("Không nhận được danh sách lớp."));
      }
    } catch (e) {
      emit(LopDetailError("Lỗi mạng: ${e.toString()}"));
    }
  }

  Future<void> _onChangeStudentRole(
    ChangeStudentRoleEvent event,
    Emitter<LopDetailState> emit,
  ) async {
    emit(LopDetailLoading());
    try {
      final response = await _service.doiChucVu(event.sinhVienId, {
        'chuc_vu': event.chucVu,
      });

      if (response.isSuccessful && response.body != null) {
        final success = response.body?['success'];
        final message = response.body?['message'];

        if (success == true) {
          emit(ChangeStudentRoleSuccess(message ?? 'Cập nhật thành công'));
        } else {
          emit(ChangeStudentRoleFailed(message ?? 'Cập nhật thất bại'));
        }
      } else {
        emit(ChangeStudentRoleFailed('Không nhận được phản hồi từ máy chủ.'));
      }
    } catch (e) {
      emit(ChangeStudentRoleFailed('Lỗi mạng: ${e.toString()}'));
    }
  }
}
