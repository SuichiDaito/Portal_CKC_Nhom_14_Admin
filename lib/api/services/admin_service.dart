
// services/admin_service.dart
import 'package:chopper/chopper.dart';
import 'package:portal_ckc/api/model/admin_thong_tin.dart';
import 'package:http/http.dart' show MultipartFile;

part 'admin_service.chopper.dart';

@ChopperApi(baseUrl: '/admin')
abstract class AdminService extends ChopperService {
  static AdminService create([ChopperClient? client]) => _$AdminService(client);
  // API Quên mật khẩu
  @Post(path: '/lay-lai-mat-khau')
  Future<Response<Map<String, dynamic>>> resetPassword(
    @Body() Map<String, dynamic> body,
  );

  //API LOGIN
  @Post(path: '/login')
  Future<Response<Map<String, dynamic>>> login(
    @Body() Map<String, dynamic> body,
  );

  //API LẤY THÔNG TIN GIẢNG VIÊN THEO ID
  @Get(path: '/giangvien/{id}')
  Future<Response> getUserDetail(@Path('id') int id);

  //API Đổi mật khẩu cho giảng viên
  @Post(path: '/doi-mat-khau')
  Future<Response<Map<String, dynamic>>> changePassword(
    @Body() Map<String, dynamic> body,
  );
  //API đổi chức vụ giảng viên
  @Put(path: '/users/{id}/role')
  Future<Response<Map<String, dynamic>>> updateTeacherRole(
    @Path('id') int userId,
    @Body() Map<String, dynamic> data,
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

  //API ĐỔI CHỨC VỤ THƯ KÝ CHO SINH VIÊN
  @POST(path: '/lopsinhvien/{sinhVien}/chucvu')
  Future<Response<Map<String, dynamic>>> doiChucVu(
    @Path('sinhVien') int sinhVienId,
    @Body() Map<String, dynamic> data,
  );

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
    @Query('nam') int nam,
  );
  //API CẬP NHẬT ĐIỂM RÈN LUYỆN CHO LỚP
  @Post(path: '/lop/cap-nhat-diem-checked') // ✅
  @FormUrlEncoded()
  Future<Response> updateBulkDiemRenLuyen({
    @Field("selected_students") required String selectedStudents,
    @Field("thoi_gian") required String thoiGian,
    @Field("xep_loai") required String xepLoai,
    @Field("nam") required String nam,
  });

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

  //LẤY DANH SÁCH TOÀN BỘ LỚP HỌC PHẦN
  @Get(path: '/lop-hoc-phan')
  Future<Response<Map<String, dynamic>>> getALLLopHocPhanList();
  @Get(path: '/lop-hoc-phan/giang-vien')
  Future<Response<Map<String, dynamic>>> getLopHocPhanTheoGiangVienList();

  //LẤY DANH SÁCH LỚP HỌC PHẦN CỦA GV HIỆN TẠI
  @Get(path: '/diem-mon-hoc')
  Future<Response<Map<String, dynamic>>> getLopHocPhanList();

  // LẤY DANH SÁCH SINH VIÊN TRONG LỚP HỌC PHẦN KÈM ĐIỂM
  @Get(path: '/diem-mon-hoc/{id}')
  Future<Response<Map<String, dynamic>>> getDanhSachSinhVienLopHocPhan(
    @Path('id') int idLopHocPhan,
  );
  //LẤY DANH SÁCH LỚP HỌC PHẦN THEO GIẢNG VIÊN
  @POST(path: '/lop-hoc-phan/phan-cong-giang-vien/{lopHocPhan}')
  Future<Response<Map<String, dynamic>>> phanCongGiangVien(
    @Path('lopHocPhan') int lopHocPhanId,
    @Body() Map<String, dynamic> body,
  );

  // ✅ NỘP BẢNG ĐIỂM (UPDATE TRẠNG THÁI)
  @Post(path: '/diem-mon-hoc/nop-bang-diem/{lopHocPhan}')
  Future<Response<Map<String, dynamic>>> updateTrangThaiNopDiem(
    @Path('lopHocPhan') int idLopHocPhan,
  );

  // API CẬP NHẬT ĐIỂM MÔN HỌC CHO LỚP HỌC PHẦN
  @Post(path: '/diem-mon-hoc/cap-nhat')
  Future<Response<Map<String, dynamic>>> capNhatDiemMonHoc(
    @Body() Map<String, dynamic> body,
  );
  // ================== 🔔 THÔNG BÁO ==================

  @Get(path: '/thongbao')
  Future<Response<Map<String, dynamic>>> getThongBaoList();

  @Get(path: '/thongbao/{id}')
  Future<Response<Map<String, dynamic>>> getThongBaoDetail(@Path('id') int id);

  @Delete(path: '/thongbao/file/{id}')
  Future<Response> deleteFileInThongBao(@Path('id') int id);

  @Post(path: '/thongbao')
  @multipart
  Future<Response<Map<String, dynamic>>> createThongBaoWithFiles(
    @Part('tieu_de') String tieuDe,
    @Part('noi_dung') String noiDung,
    @Part('tu_ai') String tuAi,
    @Part('ngay_gui') String ngayGui,
    @Part('files[]') List<MultipartFile> files,
  );
  @Post(path: '/thongbao/{id}?_method=PUT')
  @multipart
  Future<Response<Map<String, dynamic>>> updateThongBaoWithFiles(
    @Path('id') int id,
    @Part('tieu_de') String title,
    @Part('noi_dung') String content,
    @Part('ngay_gui') String ngayGui,
    @Part('tu_ai') String tuAi,
    @Part('trang_thai') int trangThai,
    @Part('files[]') List<MultipartFile> files,
    @Part('old_files') String oldFilesJson,
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

  // Lấy danh sách giá trị enum cấp trên
  @Get(path: '/thongbao/get-data-cap-tren')
  Future<Response<Map<String, dynamic>>> getCapTrenOptions();
  // Gửi bình luận mới cho thông báo
  @Post(path: '/thongbao/binh-luan/{id}')
  Future<Response<Map<String, dynamic>>> createComment(
    @Path('id') int thongBaoId,
    @Body() Map<String, dynamic> body,
  );

  // Xoá bình luận
  @Delete(path: '/thongbao/binh-luan/{id}')
  Future<Response> deleteComment(@Path('id') int commentId);
  //===========PHIẾU LÊN LỚP==============
  @Post(path: '/phieu-len-lop/store')
  Future<Response> storePhieuLenLop(@Body() Map<String, dynamic> body);

  @Get(path: '/phieu-len-lop/all')
  Future<Response> getPhieuLenLopAll();

  // =================== BIÊN BẢN SHCN ===================

  // Lấy danh sách biên bản theo lớp
  @Get(path: '/bienbanshcn/{lop}')
  Future<Response> getBienBanListByLop(@Path('lop') int lopId);

  // Lấy thông tin để tạo biên bản mới
  @Get(path: '/bienbanshcn/create/{lop}')
  Future<Response> getBienBanCreateInfo(@Path('lop') int lopId);

  // Tạo biên bản mới
  @Post(path: '/bienbanshcn/store/{lop}')
  Future<Response> createBienBan(
    @Path('lop') int lopId,
    @Body() Map<String, dynamic> data,
  );

  // Lấy chi tiết 1 biên bản SHCN
  @Get(path: '/bienbanshcn/chitiet/{bienBanSHCN}')
  Future<Response> getBienBanDetail(@Path('bienBanSHCN') int bienBanId);

  // Cập nhật biên bản
  @Put(path: '/bienbanshcn/{bienBanSHCN}')
  Future<Response> updateBienBan(
    @Path('bienBanSHCN') int bienBanId,
    @Body() Map<String, dynamic> data,
  );

  // Lấy thông tin để sửa biên bản
  @Get(path: '/bienbanshcn/{bienBanSHCN}/edit')
  Future<Response> getBienBanEditInfo(@Path('bienBanSHCN') int bienBanId);

  // Xoá biên bản
  @Delete(path: '/bienbanshcn/{bienBanSHCN}')
  Future<Response> deleteBienBan(@Path('bienBanSHCN') int bienBanId);

  // Xác nhận biên bản
  @Post(path: '/bienbanshcn/confirm/{bienBanSHCN}')
  Future<Response> confirmBienBan(@Path('bienBanSHCN') int bienBanId);

  // Xoá sinh viên vắng mặt khỏi biên bản
  @Delete(path: '/bienbanshcn/sinhvienvang/{id}')
  Future<Response> deleteSinhVienVang(@Path('id') int chiTietId);

  //DANH SÁCH TUẦN
  @Get(path: '/danhsach-tuan')
  Future<Response<Map<String, dynamic>>> getDanhSachTuan(
    @Query('nam_bat_dau') int namBatDau,
  );
  //KHỞI TẠO TUẦN
  @Post(path: '/khoi-tao-tuan')
  @FormUrlEncoded()
  Future<Response> khoiTaoTuan(@Field('date') String date);
  //LẤY DANH SÁCH CHƯƠNG TRÌNH ĐÀO TẠO
  @Get(path: '/ctdt')
  Future<Response> getCTDT();

  // ================== THỜI KHÓA BIỂU ==================

  //DANH SÁCH TKB
  @Get(path: '/thoi-khoa-bieu')
  Future<Response<dynamic>> getDanhSachThoiKhoaBieu();

  //TẠO THỜI KHÓA BIÊU
  @Post(path: '/thoi-khoa-bieu')
  Future<Response<Map<String, dynamic>>> createThoiKhoaBieu(
    @Body() Map<String, dynamic> body,
  );

  //CẬP NHẬT THỜI KHÓA BIỂU
  @Post(path: '/thoi-khoa-bieu/{tkb}')
  Future<Response<Map<String, dynamic>>> updateThoiKhoaBieu(
    @Path('tkb') int tkbId,
    @Body() Map<String, dynamic> body,
  );

  //XÓA THỜI KHÓA BIỂU
  @Delete(path: '/thoi-khoa-bieu/xoa-thoi-khoa-bieu/{tkb}')
  Future<Response> deleteThoiKhoaBieu(@Path('tkb') int tkbId);

  // //COPY THỜI KHÓA BIỂU
  // @Post(path: '/thoi-khoa-bieu/copy-tuan/{tkb}')
  // Future<Response> copyThoiKhoaBieuWeek(
  //   @Path('tkb') int tkbId,
  //   @Body() Map<String, dynamic> body,
  // );
  // COPY NHIỀU THỜI KHÓA BIỂU SANG NHIỀU TUẦN
  @Post(path: '/thoi-khoa-bieu/copy-nhieu-tuan')
  Future<Response> copyNhieuThoiKhoaBieuWeek(@Body() Map<String, dynamic> body);

  //===================== LỊCH THI =========================

  // Lấy danh sách lịch thi
  @Get(path: '/lich-thi/danh-sach-lich-thi')
  Future<Response<Map<String, dynamic>>> fetchLichThi();

  // Tạo mới lịch thi
  @Post(path: '/lich-thi/tao-lich-thi')
  Future<Response<Map<String, dynamic>>> createLichThi(
    @Body() Map<String, dynamic> body,
  );

  // Cập nhật lịch thi
  @Post(path: '/lich-thi/cap-nhat-lich-thi/{lichThi}')
  Future<Response<Map<String, dynamic>>> updateLichThi(
    @Path('lichThi') int lichThiId,
    @Body() Map<String, dynamic> body,
  );

  // Xóa lịch thi
  @Delete(path: '/lich-thi/xoa-lich-thi/{lichThi}')
  Future<Response> deleteLichThi(@Path('lichThi') int lichThiId);
}
