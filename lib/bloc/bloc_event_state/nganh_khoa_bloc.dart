import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portal_ckc/api/controller/call_api_admin.dart';
import 'package:portal_ckc/api/model/admin_chuong_trinh_dao_tao.dart';
import 'package:portal_ckc/api/model/admin_phong_khoa.dart';
import 'package:portal_ckc/bloc/event/nganh_khoa_event.dart';
import 'package:portal_ckc/bloc/state/nganh_khoa_state.dart';

class NganhKhoaBloc extends Bloc<NganhKhoaEvent, NganhKhoaState> {
  final _service = CallApiAdmin.adminService;

  NganhKhoaBloc() : super(NganhKhoaInitial()) {
    on<FetchAllNganhHocEvent>(_onFetchAllNganhHoc);
    on<FetchBoMonEvent>(_onFetchBoMon);
    on<FetchNganhTheoKhoaEvent>(_onFetchBoMonByKhoa);
    on<FetchCTCTDTEvent>(_onFetchCTCTDT);
  }

  Future<void> _onFetchAllNganhHoc(
    FetchAllNganhHocEvent event,
    Emitter<NganhKhoaState> emit,
  ) async {
    emit(NganhKhoaLoading());
    try {
      final response = await _service.getDanhSachNganhHoc();
      if (response.isSuccessful && response.body != null) {
        final nganhList = (response.body!["nganhHoc"] as List)
            .map((e) => NganhHoc.fromJson(e))
            .toList();
        emit(NganhHocLoaded(nganhList));
      } else {
        emit(NganhKhoaError("Không lấy được danh sách ngành học"));
      }
    } catch (e) {
      emit(NganhKhoaError("Lỗi khi tải ngành học: $e"));
    }
  }

  Future<void> _onFetchBoMon(
    FetchBoMonEvent event,
    Emitter<NganhKhoaState> emit,
  ) async {
    emit(NganhKhoaLoading());
    try {
      final response = await _service.getDanhSachBoMon();
      if (response.isSuccessful && response.body != null) {
        final boMonList = (response.body!["bomon"] as List)
            .map((e) => BoMon.fromJson(e))
            .toList();
        emit(BoMonLoaded(boMonList));
      } else {
        emit(NganhKhoaError("Không lấy được danh sách bộ môn"));
      }
    } catch (e) {
      emit(NganhKhoaError(e.toString()));
    }
  }

  Future<void> _onFetchBoMonByKhoa(
    FetchNganhTheoKhoaEvent event,
    Emitter<NganhKhoaState> emit,
  ) async {}

  Future<void> _onFetchCTCTDT(
    FetchCTCTDTEvent event,
    Emitter<NganhKhoaState> emit,
  ) async {
    emit(NganhKhoaLoading());
    try {
      final response = await _service.getCTDT();
      if (response.isSuccessful && response.body != null) {
        final Map<String, dynamic> map = response.body!['ct_ctdt'] ?? {};
        final List<ChiTietChuongTrinhDaoTao> chiTietList = [];

        map.forEach((_, value) {
          if (value is List) {
            chiTietList.addAll(
              value.map((e) => ChiTietChuongTrinhDaoTao.fromJson(e)),
            );
          }
        });

        emit(CTCTDTLoaded(chiTietList));
      } else {
        emit(NganhKhoaError("Không lấy được chi tiết CTĐT"));
      }
    } catch (e) {
      emit(NganhKhoaError("Lỗi khi tải CTCTDT: $e"));
    }
  }
}
