import 'package:chopper/chopper.dart';
import 'package:portal_ckc/api/services/admin_service.dart';
import 'package:portal_ckc/api/services/converted_chopper.dart';
import 'package:portal_ckc/constant/string.dart';

class CallApiAdmin {
  static final ChopperClient _chopper = ChopperClient(
    baseUrl: Uri.parse(ApiString.urlApi),
    converter: ModelConverter(),
    interceptors: [HttpLoggingInterceptor()],
    services: [], // DÙNG services rỗng để tránh lỗi
  );

  static final AdminService adminService = AdminService.create(_chopper);
}
