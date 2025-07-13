import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portal_ckc/api/controller/call_api_admin.dart';
import 'package:portal_ckc/api/model/admin_bien_bang_shcn.dart';
import 'package:portal_ckc/bloc/event/bien_bang_shcn_event.dart';
import 'package:portal_ckc/bloc/state/bien_bang_shcn_state.dart';

class BienBangShcnBloc extends Bloc<BienBanEvent, BienBanState> {
  final _service = CallApiAdmin.adminService;

  BienBangShcnBloc() : super(BienBanInitial()) {
    on<FetchBienBan>(_onFetchBienBan);
    on<ConfirmBienBan>(_onConfirmBienBan);
    on<DeleteSinhVienVangEvent>(_onDeleteSinhVienVang);
    // Chi tiết biên bản
    on<FetchBienBanDetail>(_onFetchBienBanDetail);

    // Thông tin tạo mới
    on<CreateBienBanEvent>(_onCreateBienBan);
    // Thông tin chỉnh sửa
    on<FetchBienBanEditInfo>(_onFetchEditBienBanInfo);

    // Cập nhật biên bản
    on<UpdateBienBanEvent>(_onUpdateBienBan);

    // Xoá biên bản
    on<DeleteBienBanEvent>(_onDeleteBienBan);
  }
  Future<void> _onFetchBienBan(
    FetchBienBan event,
    Emitter<BienBanState> emit,
  ) async {
    emit(BienBanLoading());
    try {
      final response = await _service.getBienBanListByLop(event.lopId);
      print('API Response: ${response.body}');

      if (response.isSuccessful) {
        final data = response.body['data'];
        final List<BienBanSHCN> bienBans = BienBanSHCN.fromJsonList(data);
        emit(BienBanLoaded(bienBans));
      } else {
        emit(BienBanError("Không thể tải dữ liệu biên bản"));
      }
    } catch (e) {
      emit(BienBanError("Lỗi tải biên bản: $e"));
    }
  }

  Future<void> _onCreateBienBan(
    CreateBienBanEvent event,
    Emitter<BienBanState> emit,
  ) async {
    emit(BienBanLoading());
    try {
      final response = await _service.createBienBan(event.lopId, event.data);
      if (response.isSuccessful) {
        emit(BienBanActionSuccess("Tạo biên bản thành công"));
      } else {
        emit(BienBanError("Tạo biên bản thất bại"));
      }
    } catch (e) {
      emit(BienBanError("Lỗi khi tạo biên bản: $e"));
    }
  }

  Future<void> _onConfirmBienBan(
    ConfirmBienBan event,
    Emitter<BienBanState> emit,
  ) async {
    try {
      final response = await _service.confirmBienBan(event.bienBanId);
      if (response.isSuccessful) {
        emit(BienBanActionSuccess("Xác nhận biên bản thành công"));
      } else {
        emit(BienBanError("Xác nhận biên bản thất bại"));
      }
    } catch (e) {
      emit(BienBanError("Xác nhận thất bại: $e"));
    }
  }

  Future<void> _onDeleteSinhVienVang(
    DeleteSinhVienVangEvent event,
    Emitter<BienBanState> emit,
  ) async {
    try {
      final response = await _service.deleteSinhVienVang(event.chiTietId);
      if (response.isSuccessful) {
        emit(BienBanActionSuccess("Xóa sinh viên vắng mặt thành công"));
      } else {
        emit(BienBanError("Xóa sinh viên vắng mặt thất bại"));
      }
    } catch (e) {
      emit(BienBanError("Xóa thất bại: $e"));
    }
  }

  Future<void> _onFetchBienBanDetail(
    FetchBienBanDetail event,
    Emitter<BienBanState> emit,
  ) async {
    emit(BienBanLoading());
    try {
      final response = await _service.getBienBanDetail(event.bienBanId);
      if (response.isSuccessful) {
        final data = response.body['data'];
        final bienBan = BienBanSHCN.fromJson(data);
        emit(BienBanDetailLoaded(bienBan));
      } else {
        emit(BienBanError("Không thể tải chi tiết biên bản"));
      }
    } catch (e) {
      emit(BienBanError("Lỗi khi tải chi tiết biên bản: $e"));
    }
  }

  Future<void> _onFetchEditBienBanInfo(
    FetchBienBanEditInfo event,
    Emitter<BienBanState> emit,
  ) async {
    emit(BienBanLoading());
    try {
      final response = await _service.getBienBanEditInfo(event.bienBanId);
      if (response.isSuccessful) {
        emit(BienBanLoaded(response.body['data']));
      } else {
        emit(BienBanError("Không thể lấy thông tin sửa biên bản"));
      }
    } catch (e) {
      emit(BienBanError("Lỗi: $e"));
    }
  }

  Future<void> _onUpdateBienBan(
    UpdateBienBanEvent event,
    Emitter<BienBanState> emit,
  ) async {
    emit(BienBanLoading());
    try {
      final response = await _service.updateBienBan(
        event.bienBanId,
        event.data,
      );
      if (response.isSuccessful) {
        emit(BienBanActionSuccess("Cập nhật biên bản thành công"));
      } else {
        emit(BienBanError("Cập nhật biên bản thất bại"));
      }
    } catch (e) {
      emit(BienBanError("Lỗi khi cập nhật: $e"));
    }
  }

  Future<void> _onDeleteBienBan(
    DeleteBienBanEvent event,
    Emitter<BienBanState> emit,
  ) async {
    try {
      final response = await _service.deleteBienBan(event.bienBanId);
      if (response.isSuccessful) {
        emit(BienBanActionSuccess("Xoá biên bản thành công"));
      } else {
        emit(BienBanError("Xoá biên bản thất bại"));
      }
    } catch (e) {
      emit(BienBanError("Xoá thất bại: $e"));
    }
  }
}
