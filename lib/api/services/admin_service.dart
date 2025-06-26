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

  // ✅ API Đổi mật khẩu cho giảng viên
  @Put(path: '/doi-mat-khau')
  Future<Response<Map<String, dynamic>>> changePassword(
    @Body() Map<String, dynamic> body,
  );

  //=================PHÒNG=============
  //API LẤY DANH SÁCH PHÒNG
  @Get(path: '/phong')
  Future<Response<Map<String, dynamic>>> getRooms();

  @Post(path: '/phong')
  Future<Response<Map<String, dynamic>>> createRoom(
    @Body() Map<String, dynamic> body,
  );

  @Put(path: '/phong/{id}')
  Future<Response<Map<String, dynamic>>> updateRoom(
    @Path('id') int id,
    @Body() Map<String, dynamic> body,
  );

  @Get(path: '/phong/{id}')
  Future<Response<Map<String, dynamic>>> getRoomDetail(@Path('id') int id);

  //=================LỚP CHỦ NHIỆM==================

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
  @Get(path: '/lop-chu-nhiem/nhap-diem-rl/{id}')
  Future<Response> fetchDiemRenLuyen(
    @Path('id') int idLop,
    @Query('thoi_gian') int thoiGian,
    // @Query('nam') int nam,
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

  //=================GIẤY XÁC NHẬN====================
  //API LẤY DANH SÁCH GIẤY XÁC NHẬN
  @Get(path: '/giay-xac-nhan')
  Future<Response> getDanhSachGiayXacNhan();

  // PUT: Xác nhận hàng loạt giấy xác nhận
  @Put(path: '/giay-xac-nhan')
  Future<Response> confirmMultipleGiayXacNhan(
    @Body() Map<String, dynamic> body,
  );

  //==============LỚP HỌC PHẦN=====================

  //LẤY DANH SÁCH LỚP HỌC PHẦN CỦA GV HIỆN TẠI
  @Get(path: '/diem-mon-hoc')
  Future<Response<Map<String, dynamic>>> getLopHocPhanList();

  // LẤY DANH SÁCH SINH VIÊN TRONG LỚP HỌC PHẦN KÈM ĐIỂM
  @Get(path: '/diem-mon-hoc/{id}')
  Future<Response<Map<String, dynamic>>> getDanhSachSinhVienLopHocPhan(
    @Path('id') int idLopHocPhan,
  );

  // API CẬP NHẬT ĐIỂM MÔN HỌC CHO LỚP HỌC PHẦN
  @Post(path: '/diem-mon-hoc/cap-nhat')
  Future<Response<Map<String, dynamic>>> capNhatDiemMonHoc(
    @Body() Map<String, dynamic> body,
  );
  // ================== 🔔 THÔNG BÁO ==================

  // Lấy danh sách tất cả thông báo
  @Get(path: '/thongbao')
  Future<Response<Map<String, dynamic>>> getThongBaoList();

  // Lấy chi tiết 1 thông báo
  @Get(path: '/thongbao/{id}')
  Future<Response<Map<String, dynamic>>> getThongBaoDetail(@Path('id') int id);

  // Tạo mới thông báo
  @Post(path: '/thongbao')
  Future<Response<Map<String, dynamic>>> createThongBao(
    @Body() Map<String, dynamic> body,
  );

  // Cập nhật thông báo
  @Put(path: '/thongbao/{id}')
  Future<Response<Map<String, dynamic>>> updateThongBao(
    @Path('id') int id,
    @Body() Map<String, dynamic> body,
  );

  // Xoá thông báo
  @Delete(path: '/thongbao/{id}')
  Future<Response> deleteThongBao(@Path('id') int id);

  // Gửi thông báo tới sinh viên (theo danh sách lớp)
  @Post(path: '/thongbao/send-to-student/{id}')
  Future<Response<Map<String, dynamic>>> sendThongBaoToStudents(
    @Path('id') int id,
    @Body() Map<String, dynamic> body,
  );

  // Xoá file đính kèm trong thông báo
  @Delete(path: '/thongbao/file/{id}')
  Future<Response> deleteFileInThongBao(@Path('id') int id);

  // Lấy danh sách giá trị enum cấp trên
  @Get(path: '/thongbao/get-data-cap-tren')
  Future<Response<Map<String, dynamic>>> getCapTrenOptions();

  //========================PHIẾU LÊN LỚP==============
  @Post(path: '/phieu-len-lop/store')
  Future<Response> storePhieuLenLop(@Body() Map<String, dynamic> body);

  @Get(path: '/phieu-len-lop/all')
  Future<Response> getPhieuLenLopAll();
}
