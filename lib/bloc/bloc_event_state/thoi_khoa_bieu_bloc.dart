import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portal_ckc/api/controller/call_api_admin.dart';
import 'package:portal_ckc/api/model/admin_thoi_khoa_bieu.dart';
import 'package:portal_ckc/bloc/event/thoi_khoa_bieu_event.dart';
import 'package:portal_ckc/bloc/state/thoi_gian_bieu_state.dart';

class ThoiKhoaBieuBloc extends Bloc<ThoiKhoaBieuEvent, ThoiKhoaBieuState> {
  final _service = CallApiAdmin.adminService;

  ThoiKhoaBieuBloc() : super(ThoiKhoaBieuInitial()) {
    on<FetchThoiKhoaBieuEvent>(_onFetchTKB);
    on<CreateThoiKhoaBieuEvent>(_onCreateTKB);
    on<UpdateThoiKhoaBieuEvent>(_onUpdateTKB);
    on<DeleteThoiKhoaBieuEvent>(_onDeleteTKB);
    // on<CopyThoiKhoaBieuWeekEvent>(_onCopyTKBWeek);
    on<CopyNhieuThoiKhoaBieuWeekEvent>(_onCopyNhieuTKBWeek);
  }

  Future<void> _onFetchTKB(
    FetchThoiKhoaBieuEvent event,
    Emitter<ThoiKhoaBieuState> emit,
  ) async {
    emit(ThoiKhoaBieuLoading());
    try {
      final response = await _service.getDanhSachThoiKhoaBieu();
      if (response.isSuccessful && response.body?['data'] != null) {
        final List<ThoiKhoaBieu> danhSach = (response.body['data'] as List)
            .map((json) => ThoiKhoaBieu.fromJson(json))
            .toList();
        emit(ThoiKhoaBieuLoaded(danhSach));
      } else {
        emit(ThoiKhoaBieuError('Không thể tải danh sách TKB'));
      }
    } catch (e) {
      emit(ThoiKhoaBieuError('Lỗi tải danh sách TKB: $e'));
    }
  }

  Future<void> _onCreateTKB(
    CreateThoiKhoaBieuEvent event,
    Emitter<ThoiKhoaBieuState> emit,
  ) async {
    emit(ThoiKhoaBieuLoading());
    try {
      final response = await _service.createThoiKhoaBieu(
        event.tkbData.toJson(),
      );
      if (response.isSuccessful && response.body?['data'] != null) {
        final tkb = ThoiKhoaBieu.fromJson(response.body?['data']);
        emit(ThoiKhoaBieuSuccess('Tạo thời khóa biểu thành công', tkb));
      } else {
        emit(ThoiKhoaBieuError(response.body?['message'] ?? 'Tạo thất bại'));
      }
    } catch (e) {
      emit(ThoiKhoaBieuError('Lỗi tạo thời khóa biểu: $e'));
    }
  }

  Future<void> _onUpdateTKB(
    UpdateThoiKhoaBieuEvent event,
    Emitter<ThoiKhoaBieuState> emit,
  ) async {
    emit(ThoiKhoaBieuLoading());
    try {
      final response = await _service.updateThoiKhoaBieu(
        event.id,
        event.tkbData.toJson(),
      );
      if (response.isSuccessful && response.body?['data'] != null) {
        final tkb = ThoiKhoaBieu.fromJson(response.body?['data']);
        emit(ThoiKhoaBieuSuccess('Cập nhật thành công', tkb));
      } else {
        emit(
          ThoiKhoaBieuError(response.body?['message'] ?? 'Cập nhật thất bại'),
        );
      }
    } catch (e) {
      emit(ThoiKhoaBieuError('Lỗi cập nhật thời khóa biểu: $e'));
    }
  }

  Future<void> _onDeleteTKB(
    DeleteThoiKhoaBieuEvent event,
    Emitter<ThoiKhoaBieuState> emit,
  ) async {
    emit(ThoiKhoaBieuLoading());
    try {
      final response = await _service.deleteThoiKhoaBieu(event.id);
      if (response.isSuccessful) {
        emit(ThoiKhoaBieuDeleted('Xoá thời khóa biểu thành công'));
      } else {
        emit(ThoiKhoaBieuError('Xoá thất bại'));
      }
    } catch (e) {
      emit(ThoiKhoaBieuError('Lỗi xoá thời khóa biểu: $e'));
    }
  }

  // Future<void> _onCopyTKBWeek(
  //   CopyThoiKhoaBieuWeekEvent event,
  //   Emitter<ThoiKhoaBieuState> emit,
  // ) async {
  //   emit(ThoiKhoaBieuLoading());
  //   try {
  //     final response = await _service.copyThoiKhoaBieuWeek(event.tkbId, {
  //       'id_tuan': event.newWeekId,
  //     });
  //     if (response.isSuccessful && response.body?['data'] != null) {
  //       final newTKB = ThoiKhoaBieu.fromJson(response.body['data']);
  //       emit(CopyThoiKhoaBieuSuccess(newTKB));
  //     } else {
  //       emit(
  //         ThoiKhoaBieuError(response.body?['message'] ?? 'Sao chép thất bại'),
  //       );
  //     }
  //   } catch (e) {
  //     emit(ThoiKhoaBieuError('Lỗi sao chép thời khóa biểu: $e'));
  //   }
  // }
  Future<void> _onCopyNhieuTKBWeek(
    CopyNhieuThoiKhoaBieuWeekEvent event,
    Emitter<ThoiKhoaBieuState> emit,
  ) async {
    emit(ThoiKhoaBieuLoading());
    try {
      final response = await _service.copyNhieuThoiKhoaBieuWeek({
        'tkb_ids': event.tkbIds, // List<int>
        'start_week_id': event.startWeekId, // int
        'end_week_id': event.endWeekId, // int
      });

      if (response.isSuccessful && response.body?['data'] != null) {
        final copiedTKBs = (response.body['data'] as List)
            .map((e) => ThoiKhoaBieu.fromJson(e))
            .toList();
        emit(CopyNhieuThoiKhoaBieuSuccess(copiedTKBs));
      } else {
        emit(
          ThoiKhoaBieuError(response.body?['message'] ?? 'Sao chép thất bại'),
        );
      }
    } catch (e) {
      emit(ThoiKhoaBieuError('Lỗi sao chép nhiều TKB: $e'));
    }
  }
}
