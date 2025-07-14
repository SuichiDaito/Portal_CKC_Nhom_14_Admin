import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portal_ckc/api/controller/call_api_admin.dart';
import 'package:portal_ckc/api/model/admin_thong_bao.dart';
import 'package:portal_ckc/bloc/event/thong_bao_event.dart';
import 'package:portal_ckc/bloc/state/thong_bao_state.dart';
import 'package:http/http.dart' show MultipartFile;
import 'dart:convert';

class ThongBaoBloc extends Bloc<ThongBaoEvent, ThongBaoState> {
  final _service = CallApiAdmin.adminService;

  ThongBaoBloc() : super(TBInitial()) {
    on<FetchThongBaoList>(_onFetchList);
    on<FetchThongBaoDetail>(_onFetchDetail);
    on<CreateThongBao>(_onCreate);
    on<UpdateThongBao>(_onUpdate);
    on<DeleteThongBao>(_onDelete);
    on<SendToStudents>(_onSend);
    on<FetchCapTrenOptions>(_onFetchCapTren);
    on<CreateCommentEvent>(_onCreateComment);
    on<DeleteCommentEvent>(_onDeleteComment);
    on<DeleteAttachedFile>(_onDeleteFile);
  }

  Future<void> _onFetchList(
    FetchThongBaoList event,
    Emitter<ThongBaoState> emit,
  ) async {
    emit(TBLoading());
    try {
      final response = await _service.getThongBaoList();
      if (response.isSuccessful) {
        final data = response.body?['data'] as List;
        final list = data.map((e) => ThongBao.fromJson(e)).toList();
        emit(TBListLoaded(list));
      } else {
        emit(TBFailure('Lỗi: ${response.error}'));
      }
    } catch (e) {
      emit(TBFailure('Exception: $e'));
    }
  }

  Future<void> _onFetchDetail(
    FetchThongBaoDetail event,
    Emitter<ThongBaoState> emit,
  ) async {
    emit(TBLoading());
    try {
      final response = await _service.getThongBaoDetail(event.id);
      if (response.isSuccessful) {
        final detail = ThongBao.fromJson(response.body?['data']);
        emit(TBDetailLoaded(detail));
      } else {
        emit(TBFailure('Lỗi: ${response.error}'));
      }
    } catch (e) {
      emit(TBFailure('Exception: $e'));
    }
  }

  Future<void> _onCreate(
    CreateThongBao event,
    Emitter<ThongBaoState> emit,
  ) async {
    emit(TBLoading());
    try {
      final response = await _service.createThongBaoWithFiles(
        event.title,
        event.content,
        event.capTren,
        DateTime.now().toIso8601String(),
        event.files,
      );

      if (response.isSuccessful) {
        final body = response.body;
        final id = body?['data']?['id'];

        emit(TBSuccess('Tạo thông báo thành công', thongBaoId: id));
      } else {
        emit(TBFailure('Lỗi: ${response.error}'));
      }
    } catch (e) {
      emit(TBFailure('Exception: $e'));
    }
  }

  Future<void> _onUpdate(
    UpdateThongBao event,
    Emitter<ThongBaoState> emit,
  ) async {
    emit(TBLoading());
    try {
      final response = await CallApiAdmin.adminService.updateThongBaoWithFiles(
        event.id,
        event.title,
        event.content,
        event.ngayGui,
        event.tuAi,
        event.trangThai ?? 1,
        event.files,
        jsonEncode(event.oldFiles),
      );
      print('🧾 Số lượng files gửi: ${event.files.length}');
      for (final f in event.files) {
        print('📎 File: ${f.filename}');
      }

      if (response.isSuccessful) {
        emit(TBSuccess('Cập nhật thông báo thành công'));
      } else {
        emit(TBFailure('Lỗi: ${response.error}'));
      }
    } catch (e) {
      emit(TBFailure('Exception: $e'));
    }
  }

  Future<void> _onDelete(
    DeleteThongBao event,
    Emitter<ThongBaoState> emit,
  ) async {
    emit(TBLoading());
    try {
      final response = await _service.deleteThongBao(event.id);
      if (response.isSuccessful) {
        emit(TBSuccess('Xoá thông báo thành công'));
      } else {
        emit(TBFailure('Lỗi: ${response.error}'));
      }
    } catch (e) {
      emit(TBFailure('Exception: $e'));
    }
  }

  Future<void> _onDeleteFile(
    DeleteAttachedFile event,
    Emitter<ThongBaoState> emit,
  ) async {
    try {
      final response = await _service.deleteFileInThongBao(event.fileId);

      if (response.isSuccessful) {
        emit(TBSuccess('Xoá file thành công'));
      } else {
        emit(TBFailure('Xoá file thất bại: ${response.error}'));
      }
    } catch (e) {
      emit(TBFailure('Exception khi xoá file: $e'));
    }
  }

  Future<void> _onSend(
    SendToStudents event,
    Emitter<ThongBaoState> emit,
  ) async {
    emit(TBLoading());
    try {
      final response = await _service.sendThongBaoToStudents(event.id, {
        'lop_ids': event.lopIds,
      });
      if (response.isSuccessful) {
        emit(TBSuccess('Gửi thông báo tới sinh viên thành công'));
      } else {
        emit(TBFailure('Lỗi: ${response.error}'));
      }
    } catch (e) {
      emit(TBFailure('Exception: $e'));
    }
  }

  Future<void> _onFetchCapTren(
    FetchCapTrenOptions event,
    Emitter<ThongBaoState> emit,
  ) async {
    emit(TBLoading());
    try {
      final response = await _service.getCapTrenOptions();
      if (response.isSuccessful) {
        final list = response.body?['cap_tren'] as List;
        final opts = list.map((e) => CapTrenOption.fromJson(e)).toList();
        emit(TBDataCapTrenLoaded(opts));
      } else {
        emit(TBFailure('Lỗi: ${response.error}'));
      }
    } catch (e) {
      emit(TBFailure('Exception: $e'));
    }
  }

  Future<void> _onCreateComment(
    CreateCommentEvent event,
    Emitter<ThongBaoState> emit,
  ) async {
    print('🟢 Đang gửi bình luận: ${event.noiDung}');
    try {
      final response = await _service.createComment(event.thongBaoId, {
        'noi_dung': event.noiDung,
        if (event.idBinhLuanCha != null)
          'id_binh_luan_cha': event.idBinhLuanCha,
      });

      if (response.isSuccessful) {
        print('✅ Gửi bình luận thành công');
        add(FetchThongBaoDetail(event.thongBaoId));
      } else {
        print('❌ Gửi thất bại: ${response.error}');
        emit(TBFailure('Gửi bình luận thất bại: ${response.error}'));
      }
    } catch (e) {
      print('❌ Exception: $e');
      emit(TBFailure('Exception khi gửi bình luận: $e'));
    }
  }

  Future<void> _onDeleteComment(
    DeleteCommentEvent event,
    Emitter<ThongBaoState> emit,
  ) async {
    try {
      final response = await _service.deleteComment(event.commentId);

      if (response.isSuccessful) {
      } else {
        emit(TBFailure('Xoá bình luận thất bại: ${response.error}'));
      }
    } catch (e) {
      emit(TBFailure('Exception khi xoá bình luận: $e'));
    }
  }
}
