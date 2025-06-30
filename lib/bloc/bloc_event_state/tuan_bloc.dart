import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portal_ckc/api/controller/call_api_admin.dart';
import 'package:portal_ckc/api/model/admin_tuan.dart';
import 'package:portal_ckc/bloc/event/tuan_event.dart';
import 'package:portal_ckc/bloc/state/tuan_state.dart';

class TuanBloc extends Bloc<TuanEvent, TuanState> {
  final _service = CallApiAdmin.adminService;

  TuanBloc() : super(TuanInitial()) {
    on<FetchTuanEvent>(_onFetchTuan);
    on<KhoiTaoTuanEvent>(_onKhoiTaoTuan);
  }

  Future<void> _onFetchTuan(
    FetchTuanEvent event,
    Emitter<TuanState> emit,
  ) async {
    emit(TuanLoading());
    try {
      final response = await _service.getDanhSachTuan(event.namBatDau);
      if (response.isSuccessful && response.body != null) {
        final data = response.body!;
        final List<dynamic> dsTuan = data["dsTuan"];
        final List<TuanModel> tuans = dsTuan
            .map((e) => TuanModel.fromJson(e))
            .toList();
        emit(TuanLoaded(tuans));
      } else {
        emit(TuanError("Không lấy được danh sách tuần"));
      }
    } catch (e) {
      print("Lỗi: ${e.toString()}");

      emit(TuanError("Không lấy được danh sách tuần"));
    }
  }

  Future<void> _onKhoiTaoTuan(
    KhoiTaoTuanEvent event,
    Emitter<TuanState> emit,
  ) async {
    emit(TuanLoading());
    try {
      final response = await _service.khoiTaoTuan(event.date);
      if (response.isSuccessful) {
        emit(TuanSuccess("Khởi tạo tuần thành công"));
      } else {
        print("Lỗi: ${response.error}");
        emit(TuanError("Đã có lỗi xảy ra khi khởi tạo tuần"));
      }
    } catch (e) {
      print("Lỗi: ${e.toString()}");
      emit(TuanError("Đã có lỗi xảy ra khi khởi tạo tuần"));
    }
  }
}
