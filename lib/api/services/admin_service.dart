import 'package:chopper/chopper.dart';

part 'admin_service.chopper.dart';

@ChopperApi(baseUrl: '/admin')
abstract class AdminService extends ChopperService {
  static AdminService create([ChopperClient? client]) => _$AdminService(client);
  @Post(path: '/login')
  Future<Response<Map<String, dynamic>>> login(
    @Body() Map<String, dynamic> body,
  );

  @Get(path: '/show/{id}')
  Future<Response> getUserDetail(@Path('id') int id);
}
