import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portal_ckc/api/controller/call_api_admin.dart';
import 'package:portal_ckc/api/model/admin_lich_thi.dart';
import 'package:portal_ckc/bloc/event/lich_thi_event.dart';
import 'package:portal_ckc/bloc/state/lich_thi_state.dart';

class LichThiBloc extends Bloc<LichThiEvent, LichThiState> {
  final _service = CallApiAdmin.adminService;

  List<ExamSchedule> _cachedLichThi = [];

  LichThiBloc() : super(LichThiInitial()) {
    on<FetchLichThi>(_onFetch);
    on<CreateLichThi>(_onCreate);
    on<UpdateLichThi>(_onUpdate);
    on<DeleteLichThi>(_onDelete);
    on<FetchLichThiByGiangVienId>(_onFetchByGiangVienId);
  }

  Future<void> _onFetch(FetchLichThi event, Emitter<LichThiState> emit) async {
    emit(LichThiLoading());
    try {
      final res = await _service.fetchLichThi();
      if (res.isSuccessful && res.body != null) {
        final data = (res.body?['data'] as List)
            .map((e) => ExamSchedule.fromJson(e))
            .toList();
        _cachedLichThi = data;
        emit(LichThiLoaded(data));
      } else {
        emit(
          LichThiError(
            'Không thể tải lịch thi: ${res.error ?? 'Lỗi không xác định'}',
          ),
        );
      }
    } catch (e) {
      emit(LichThiError('Lỗi kết nối: $e'));
    }
  }

  Future<void> _onCreate(
    CreateLichThi event,
    Emitter<LichThiState> emit,
  ) async {
    try {
      final res = await _service.createLichThi(event.data);
      if (res.isSuccessful) {
        emit(LichThiOperationSuccess(res.body?['message'] ?? 'Tạo thành công'));
        add(FetchLichThi());
      } else {
        emit(LichThiOperationFailed(res.body?['message'] ?? 'Tạo thất bại'));
        emit(LichThiLoaded(_cachedLichThi));
      }
    } catch (e) {
      emit(LichThiOperationFailed('Lỗi mạng: $e'));
      emit(LichThiLoaded(_cachedLichThi));
    }
  }

  Future<void> _onUpdate(
    UpdateLichThi event,
    Emitter<LichThiState> emit,
  ) async {
    try {
      final res = await _service.updateLichThi(event.id, event.data);
      if (res.isSuccessful) {
        emit(
          LichThiOperationSuccess(
            res.body?['message'] ?? 'Cập nhật thành công',
          ),
        );
        add(FetchLichThi());
      } else {
        emit(
          LichThiOperationFailed(res.body?['message'] ?? 'Cập nhật thất bại'),
        );
        emit(LichThiLoaded(_cachedLichThi));
      }
    } catch (e) {
      emit(LichThiOperationFailed('Lỗi mạng: $e'));
      emit(LichThiLoaded(_cachedLichThi));
    }
  }

  Future<void> _onDelete(
    DeleteLichThi event,
    Emitter<LichThiState> emit,
  ) async {
    try {
      final res = await _service.deleteLichThi(event.id);
      if (res.isSuccessful) {
        emit(LichThiOperationSuccess(res.body?['message'] ?? 'Xóa thành công'));
        add(FetchLichThi());
      } else {
        emit(LichThiOperationFailed(res.body?['message'] ?? 'Xóa thất bại'));
        emit(LichThiLoaded(_cachedLichThi));
      }
    } catch (e) {
      emit(LichThiOperationFailed('Lỗi mạng: $e'));
      emit(LichThiLoaded(_cachedLichThi));
    }
  }

  Future<void> _onFetchByGiangVienId(
    FetchLichThiByGiangVienId event,
    Emitter<LichThiState> emit,
  ) async {
    emit(LichThiLoading());
    try {
      final res = await _service.fetchLichThi();
      if (res.isSuccessful && res.body != null) {
        final data = (res.body?['data'] as List)
            .map((e) => ExamSchedule.fromJson(e))
            .where(
              (lich) =>
                  lich.idGiamThi1 == event.giangVienId ||
                  lich.idGiamThi2 == event.giangVienId,
            )
            .toList();
        _cachedLichThi = data;
        emit(LichThiLoaded(data));
      } else {
        emit(
          LichThiError(
            'Không thể tải lịch thi: ${res.error ?? 'Lỗi không xác định'}',
          ),
        );
      }
    } catch (e) {
      emit(LichThiError('Lỗi kết nối: $e'));
    }
  }
}
