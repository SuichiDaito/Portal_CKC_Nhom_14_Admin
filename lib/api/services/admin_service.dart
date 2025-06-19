// services/admin_service.dart
import 'package:chopper/chopper.dart';

part 'admin_service.chopper.dart';

@ChopperApi(baseUrl: '/admin')
abstract class AdminService extends ChopperService {
  static AdminService create([ChopperClient? client]) => _$AdminService(client);

  //API LOGIN
  @Post(path: '/login')
  Future<Response<Map<String, dynamic>>> login(
    @Body() Map<String, dynamic> body,
  );
  //API LẤY THÔNG TIN GIẢNG VIÊN THEO ID
  @Get(path: '/giangvien/{id}')
  Future<Response> getUserDetail(@Path('id') int id);
  //API LẤY DANH SÁCH PHÒNG
  @Get(path: '/phong')
  Future<Response<Map<String, dynamic>>> getRooms();
  //API LẤY DANH SÁCH LỚP CHỦ NHIỆM
  @Get(path: '/lop-chu-nhiem')
  Future<Response<Map<String, dynamic>>> getLopList();
  //API LẤY DANH SÁCH SINH VIÊN LỚP CHỦ NHIỆM THEO IDLỚP
  @Get(path: '/lop-chu-nhiem/sinhvien/{id}')
  Future<Response<Map<String, dynamic>>> getStudentsByClassId(
    @Path('id') int lopId,
  );
  //API LẤY ĐIỂM RÈN LUYỆN THEO ID LOP VÀ THỜI GIAN
  @Get(path: '/admin/nhap-diem-ren-luyen/{id}')
  Future<Response> fetchDiemRenLuyen(
    @Path('id') int idLop,
    @Query('thoi_gian') int thoiGian,
  );
}
