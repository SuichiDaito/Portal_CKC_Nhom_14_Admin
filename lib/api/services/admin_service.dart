// services/admin_service.dart
import 'package:chopper/chopper.dart';
import 'package:portal_ckc/api/model/admin_thong_tin.dart';

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
  //API LẤY DANH SÁCH TẤT CẢ SINH VIÊN
  @Get(path: '/students')
  Future<Response<Map<String, dynamic>>> getAllSinhViens();
  //API LẤY DANH SÁCH LỚP HỌC
  @Get(path: "/lopsinhvien")
  Future<Response> getDanhSachLop();

  //API LẤY DANH SÁCH SINH VIÊN THEO LỚP
  @Get(path: '/lopsinhvien/{id}')
  Future<Response<Map<String, dynamic>>> getLopChiTiet(@Path('id') int lopId);

  //API LẤY DANH SÁCH NIÊN KHÓA-HỌC KỲ
  @Get(path: '/nien-khoa')
  Future<Response<Map<String, dynamic>>> fetchNienKhoaHocKy();

  //API LẤY DANH SÁCH TẤT CẢ GIẢNG VIÊN
  @Get(path: '/giangvien')
  Future<Response> getAllUsers();
  //API LẤY ĐIỂM RÈN LUYỆN THEO ID LOP VÀ THỜI GIAN
  @Get(path: '/admin/nhap-diem-ren-luyen/{id}')
  Future<Response> fetchDiemRenLuyen(
    @Path('id') int idLop,
    @Query('thoi_gian') int thoiGian,
  );
  //API LẤY DANH SÁCH NGÀNH HỌC, KHOA
  @Get(path: '/nganh-hoc')
  Future<Response> getDanhSachNganhHoc();
  //API LẤY DANH SÁCH BỘ MÔN
  @Get(path: '/bo-mon')
  Future<Response> getDanhSachBoMon();
  //API LẤY DANH SÁCH vai trò
  @Get(path: '/roles')
  Future<Response> getDanhSachVaiTro();
  //API LẤY DANH SÁCH GIẤY XÁC NHẬN
  @Get(path: '/giay-xac-nhan')
  Future<Response> getDanhSachGiayXacNhan();
  // PUT: Xác nhận hàng loạt giấy xác nhận
  @Put(path: '/giay-xac-nhan')
  Future<Response> confirmMultipleGiayXacNhan(
    @Body() Map<String, dynamic> body,
  );
}
