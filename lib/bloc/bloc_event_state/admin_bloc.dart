import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portal_ckc/api/controller/call_api_admin.dart';
import 'package:portal_ckc/api/model/admin_lop.dart';
import 'package:portal_ckc/api/model/admin_sinh_vien.dart';
import 'package:portal_ckc/api/model/admin_thong_tin.dart';
import 'package:portal_ckc/api/services/admin_service.dart';

import 'package:portal_ckc/bloc/event/admin_event.dart';
import 'package:portal_ckc/bloc/state/admin_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdminBloc extends Bloc<AdminEvent, AdminState> {
  final AdminService service;

  AdminBloc() : service = CallApiAdmin.adminService, super(AdminInitial()) {
    on<AdminLoginEvent>(_onLogin);
    on<FetchAdminDetail>(_onFetchDetail);
    on<FetchClassList>(_onFetchClassList);
    on<FetchStudentList>(_onFetchStudentList);
    on<ChangePasswordEvent>(_onChangePassword);
    on<ForgotPasswordRequested>(_onForgotPasswordRequested);
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
            final token = body['token'];
            if (token != null) {
              final prefs = await SharedPreferences.getInstance();
              await prefs.setString('token', token);
              await prefs.setInt('user_id', user.id);
              if (user.roles.isNotEmpty) {
                await prefs.setInt('user_role', user.roles.first.id);
                await prefs.setString('user_name_role', user.roles.first.name);
              } else {
                await prefs.setInt('user_role', -1);
                await prefs.setString('user_name_role', 'Chưa có vai trò');
              }

              await prefs.setString(
                'user_name_fullname',
                user.hoSo?.hoTen ?? "Lỗi khi tải ",
              );
              print('✅ Token đã được lưu: $token');
              print('✅ User ID đã được lưu: ${user.id}');

              print('✅ User Name đã được lưu: ${user.hoSo?.hoTen}');
            }
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

      if (response.isSuccessful && response.body != null) {
        final data = response.body;
        if (data is Map<String, dynamic> && data.containsKey('user')) {
          final userJson = data['user'];
          final rolesJson = data['roles'];

          final user = User.fromJson({...userJson, 'roles': rolesJson});
          emit(AdminSuccess(user));
        } else {
          emit(AdminError('Phản hồi không đúng định dạng'));
        }
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

  //Lấy danh sách lớp chủ nhiệm
  Future<void> _onFetchClassList(FetchClassList event, Emitter emit) async {
    try {
      final response = await service.getLopList(); // gọi API
      if (response.isSuccessful && response.body != null) {
        final body = response.body;
        if (body is Map<String, dynamic> && body.containsKey('data')) {
          final dataList = body['data'] as List<dynamic>;
          final lops = dataList.map((e) => Lop.fromJson(e)).toList();
          print("Tổng số lớp: ${lops.length}");
          emit(ClassListLoaded(lops));
        } else {
          emit(AdminError('Phản hồi không đúng định dạng'));
        }
      } else {
        emit(AdminError('Không thể lấy danh sách lớp'));
      }
    } catch (e) {
      emit(AdminError('Lỗi lấy danh sách lớp: $e'));
    }
  }
  // admin_bloc.dart

  Future<void> _onFetchStudentList(FetchStudentList event, Emitter emit) async {
    emit(AdminLoading());
    try {
      final response = await service.getStudentsByClassId(event.lopId);
      if (response.isSuccessful && response.body != null) {
        final body = response.body;
        if (body is Map<String, dynamic> && body.containsKey('sinh_viens')) {
          final dataList = body['sinh_viens'] as List<dynamic>;
          final studentsWithRole = dataList
              .map((e) => StudentWithRole.fromJson(e))
              .toList();
          print("✅ Tổng số sinh viên: ${studentsWithRole.length}");
          emit(StudentListLoaded(studentsWithRole));
        } else {
          emit(AdminError('Phản hồi không đúng định dạng (thiếu sinh_viens)'));
        }
      } else {
        emit(AdminError('Không thể lấy danh sách sinh viên'));
      }
    } catch (e) {
      emit(AdminError('Lỗi lấy danh sách sinh viên: $e'));
    }
  }

  Future<void> _onChangePassword(
    ChangePasswordEvent event,
    Emitter<AdminState> emit,
  ) async {
    emit(AdminLoading());
    try {
      final response = await service.changePassword({
        'current_password': event.currentPassword,
        'new_password': event.newPassword,
        'new_password_confirmation': event.confirmPassword,
      });

      if (response.isSuccessful && response.body != null) {
        final body = response.body!;
        if (body['status'] == true) {
          emit(AdminSuccessMessage(body['message']));
        } else {
          emit(AdminError(body['message'] ?? 'Đổi mật khẩu thất bại'));
        }
      } else {
        emit(AdminError('Không thể đổi mật khẩu. Vui lòng thử lại.'));
      }
    } catch (e) {
      emit(AdminError('Lỗi hệ thống: $e'));
    }
  }

  Future<void> _onForgotPasswordRequested(
    ForgotPasswordRequested event,
    Emitter<AdminState> emit,
  ) async {
    emit(ForgotPasswordLoading());
    try {
      final response = await service.resetPassword({'email': event.email});

      if (response.isSuccessful && response.body != null) {
        final body = response.body;
        if (body?['success'] == true && body?['data'] != null) {
          emit(
            ForgotPasswordSuccess(
              hoTen: body?['data']['ho_ten'],
              email: body?['data']['email'],
            ),
          );
        } else {
          emit(ForgotPasswordFailure(body?['message'] ?? 'Yêu cầu thất bại'));
        }
      } else {
        emit(ForgotPasswordFailure('Không thể gửi yêu cầu. Vui lòng thử lại.'));
      }
    } catch (e) {
      emit(ForgotPasswordFailure('Lỗi hệ thống: ${e.toString()}'));
    }
  }
}
