import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portal_ckc/api/controller/call_api_admin.dart';
import 'package:portal_ckc/api/model/admin_lop_hoc_phan.dart';
import 'package:portal_ckc/bloc/event/lop_hoc_phan_event.dart';
import 'package:portal_ckc/bloc/state/lop_hoc_phan_state.dart';

class LopHocPhanBloc extends Bloc<LopHocPhanEvent, LopHocPhanState> {
  final _service = CallApiAdmin.adminService;

  LopHocPhanBloc() : super(LopHocPhanInitial()) {
    on<FetchLopHocPhan>(_onFetch);
    on<FetchALLLopHocPhan>(_onFetchAll);
    on<PhanCongGiangVienEvent>(_onPhanCongGiangVien);
    on<FetchLopHocPhanTheoGiangVien>(_onFetchByGiangVien);
  }

  Future<void> _onFetchAll(
    FetchALLLopHocPhan event,
    Emitter<LopHocPhanState> emit,
  ) async {
    emit(LopHocPhanLoading());
    try {
      final lopHocPhans = await fetchAllLopHocPhanFromApi();
      emit(LopHocPhanLoaded(lopHocPhans));
    } catch (e, stackTrace) {
      print('🛑 Lỗi khi fetch ALL lớp học phần: $e');
      print('📍 Stack trace:\n$stackTrace');
      emit(LopHocPhanError(e.toString()));
    }
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

  Future<List<LopHocPhan>> fetchAllLopHocPhanFromApi() async {
    final response = await _service.getALLLopHocPhanList();
    if (response.isSuccessful) {
      final body = response.body;
      if (body != null && body['data'] is List) {
        final data = body['data'] as List<dynamic>;
        final result = <LopHocPhan>[];

        for (final item in data) {
          try {
            result.add(LopHocPhan.fromJson(item));
          } catch (e) {
            print('❌ Lỗi parse item: ${jsonEncode(item)}');
            print('🔍 Chi tiết lỗi: $e');
          }
        }

        return result;
      } else {
        throw Exception('Dữ liệu lớp học phần không đúng định dạng.');
      }
    } else {
      throw Exception('Lỗi khi tải toàn bộ lớp học phần: ${response.error}');
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

  Future<void> _onPhanCongGiangVien(
    PhanCongGiangVienEvent event,
    Emitter<LopHocPhanState> emit,
  ) async {
    try {
      final response = await _service.phanCongGiangVien(event.lopHocPhanId, {
        'id_giang_vien': event.idGiangVien,
      });

      if (response.isSuccessful) {
        emit(
          PhanCongGiangVienSuccess(
            message: response.body?['message'] ?? 'Phân công thành công',
          ),
        );
        add(FetchALLLopHocPhan());
      } else {
        emit(LopHocPhanError('Phân công thất bại: ${response.error}'));
      }
    } catch (e) {
      emit(LopHocPhanError('Lỗi phân công: $e'));
    }
  }

  Future<void> _onFetchByGiangVien(
    FetchLopHocPhanTheoGiangVien event,
    Emitter<LopHocPhanState> emit,
  ) async {
    emit(LopHocPhanLoading());
    try {
      final lopHocPhans = await fetchLopHocPhanTheoGiangVienFromApi();
      emit(LopHocPhanLoaded(lopHocPhans));
    } catch (e) {
      emit(LopHocPhanError(e.toString()));
    }
  }

  Future<List<LopHocPhan>> fetchLopHocPhanTheoGiangVienFromApi() async {
    final response = await _service.getLopHocPhanTheoGiangVienList();
    if (response.isSuccessful) {
      final body = response.body;
      if (body != null && body['data'] is List) {
        final data = body['data'] as List<dynamic>;
        return data.map((item) => LopHocPhan.fromJson(item)).toList();
      } else {
        throw Exception('Dữ liệu lớp học phần không đúng định dạng.');
      }
    } else {
      throw Exception(
        'Lỗi khi tải lớp học phần theo giảng viên: ${response.error}',
      );
    }
  }
}
