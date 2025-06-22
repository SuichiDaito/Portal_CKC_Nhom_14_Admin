
import 'dart:async';
import 'package:chopper/chopper.dart';
import 'package:portal_ckc/api/services/admin_service.dart';
import 'package:portal_ckc/api/services/converted_chopper.dart';
import 'package:portal_ckc/constant/string.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CallApiStudent {
  static final ChopperClient _chopper = ChopperClient(
    baseUrl: Uri.parse(ApiString.urlApi),
    converter: ModelConverter(),
    interceptors: [HttpLoggingInterceptor(), AuthHeaderInterceptor()],
    services: [], // DÙNG services rỗng để tránh lỗi
  );

  static final AdminService adminService = AdminService.create(_chopper);
}

class AuthHeaderInterceptor implements Interceptor {
  @override
  FutureOr<Response<BodyType>> intercept<BodyType>(
    Chain<BodyType> chain,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';

    final updatedRequest = chain.request.copyWith(
      headers: {
        ...chain.request.headers,
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );

    return chain.proceed(updatedRequest);
  }
}

