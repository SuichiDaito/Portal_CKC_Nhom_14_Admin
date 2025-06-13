import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portal_ckc/api/controller/call_api_admin.dart';
import 'package:portal_ckc/api/model/admin_thongtin.dart';
import 'package:portal_ckc/api/services/admin_service.dart';
import 'package:portal_ckc/bloc/event/admin_event.dart';
import 'package:portal_ckc/bloc/state/admin_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdminBloc extends Bloc<AdminEvent, AdminState> {
  final AdminService service;

  AdminBloc() : service = CallApiAdmin.adminService, super(AdminInitial()) {
    on<AdminLoginEvent>(_onLogin);
    on<FetchAdminDetail>(_onFetchDetail);
  }

  Future<void> _onLogin(AdminLoginEvent event, Emitter emit) async {
    print('➡️ Đang xử lý đăng nhập');
    emit(AdminLoading());
    try {
      final response = await service.login({
        'tai_khoan': event.taiKhoan,
        'password': event.password,
      });

      if (response.isSuccessful && response.body != null) {
        final body = response.body;
        print('📦 Status: ${response.statusCode}');
        print('📦 Body: ${response.body}');
        print('📦 Error: ${response.error}');

        if (body is Map<String, dynamic>) {
          if (body.containsKey('user')) {
            final userJson = body['user'] as Map<String, dynamic>;
            final user = User.fromJson(userJson);
            final prefs = await SharedPreferences.getInstance();
            await prefs.setString('token', body['token']);

            emit(AdminLoaded(user));
          } else {
            emit(AdminError('Phản hồi không hợp lệ: Không có key "user"'));
          }
        } else {
          emit(
            AdminError('Phản hồi không hợp lệ từ server (body không phải Map)'),
          );
        }
      } else {
        final error = response.error;
        if (error is Map<String, dynamic> && error.containsKey('message')) {
          emit(AdminError(error['message']));
        } else {
          emit(AdminError('Đăng nhập thất bại'));
        }
      }
    } catch (e, stackTrace) {
      print('❌ Lỗi đăng nhập: $e');
      print('📌 StackTrace: $stackTrace');
      emit(AdminError('Lỗi hệ thống: $e'));
    }
  }

  Future<void> _onFetchDetail(FetchAdminDetail event, Emitter emit) async {
    print('➡️ Đang xử lý lấy thông tin chi tiết');
    emit(AdminLoading());
    try {
      final response = await service.getUserDetail(event.userId);
      if (response.isSuccessful &&
          response.body is List &&
          response.body.isNotEmpty) {
        final data = response.body;
        final user = User.fromJson(data[0]);
        emit(AdminSuccess(user));
      } else {
        emit(
          AdminError('Không thể lấy thông tin giảng viên hoặc dữ liệu rỗng'),
        );
      }
    } catch (e) {
      print('❌ Lỗi khi lấy thông tin: $e');
      emit(AdminError('Lỗi khi lấy thông tin: $e'));
    }
  }
}
