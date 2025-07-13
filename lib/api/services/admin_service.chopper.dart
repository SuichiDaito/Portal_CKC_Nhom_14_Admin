// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
final class _$AdminService extends AdminService {
  _$AdminService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final Type definitionType = AdminService;

  @override
  Future<Response<Map<String, dynamic>>> resetPassword(
    Map<String, dynamic> body,
  ) {
    final Uri $url = Uri.parse('/admin/lay-lai-mat-khau');
    final $body = body;
    final Request $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<Map<String, dynamic>, Map<String, dynamic>>($request);
  }

  @override
  Future<Response<Map<String, dynamic>>> login(Map<String, dynamic> body) {
    final Uri $url = Uri.parse('/admin/login');
    final $body = body;
    final Request $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<Map<String, dynamic>, Map<String, dynamic>>($request);
  }

  @override
  Future<Response<dynamic>> getUserDetail(int id) {
    final Uri $url = Uri.parse('/admin/giangvien/${id}');
    final Request $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override

  Future<Response<Map<String, dynamic>>> changePassword(
    Map<String, dynamic> body,
  ) {
    final Uri $url = Uri.parse('/admin/doi-mat-khau');
    final $body = body;
    final Request $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<Map<String, dynamic>, Map<String, dynamic>>($request);
  }

  @override
  Future<Response<Map<String, dynamic>>> updateTeacherRole(
    int userId,
    Map<String, dynamic> data,
  ) {
    final Uri $url = Uri.parse('/admin/users/${userId}/role');
    final $body = data;
    final Request $request = Request('PUT', $url, client.baseUrl, body: $body);
    return client.send<Map<String, dynamic>, Map<String, dynamic>>($request);
  }

  @override

  Future<Response<Map<String, dynamic>>> getRooms() {
    final Uri $url = Uri.parse('/admin/phong');
    final Request $request = Request('GET', $url, client.baseUrl);
    return client.send<Map<String, dynamic>, Map<String, dynamic>>($request);
  }

  @override
  Future<Response<Map<String, dynamic>>> createRoom(Map<String, dynamic> body) {
    final Uri $url = Uri.parse('/admin/phong');
    final $body = body;
    final Request $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<Map<String, dynamic>, Map<String, dynamic>>($request);
  }

  @override
  Future<Response<Map<String, dynamic>>> updateRoom(
    int id,
    Map<String, dynamic> body,
  ) {
    final Uri $url = Uri.parse('/admin/phong/${id}');
    final $body = body;
    final Request $request = Request('PUT', $url, client.baseUrl, body: $body);
    return client.send<Map<String, dynamic>, Map<String, dynamic>>($request);
  }

  @override
  Future<Response<Map<String, dynamic>>> getRoomDetail(int id) {
    final Uri $url = Uri.parse('/admin/phong/${id}');
    final Request $request = Request('GET', $url, client.baseUrl);
    return client.send<Map<String, dynamic>, Map<String, dynamic>>($request);
  }

  @override

  Future<Response<Map<String, dynamic>>> getLopList() {
    final Uri $url = Uri.parse('/admin/lop-chu-nhiem');
    final Request $request = Request('GET', $url, client.baseUrl);
    return client.send<Map<String, dynamic>, Map<String, dynamic>>($request);
  }

  @override
  Future<Response<Map<String, dynamic>>> getStudentsByClassId(int lopId) {
    final Uri $url = Uri.parse('/admin/lop-chu-nhiem/sinhvien/${lopId}');
    final Request $request = Request('GET', $url, client.baseUrl);
    return client.send<Map<String, dynamic>, Map<String, dynamic>>($request);
  }

  @override
  Future<Response<Map<String, dynamic>>> getAllSinhViens() {
    final Uri $url = Uri.parse('/admin/students');
    final Request $request = Request('GET', $url, client.baseUrl);
    return client.send<Map<String, dynamic>, Map<String, dynamic>>($request);
  }

  @override
  Future<Response<dynamic>> getDanhSachLop() {
    final Uri $url = Uri.parse('/admin/lopsinhvien');
    final Request $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<Map<String, dynamic>>> getLopChiTiet(int lopId) {
    final Uri $url = Uri.parse('/admin/lopsinhvien/${lopId}');
    final Request $request = Request('GET', $url, client.baseUrl);
    return client.send<Map<String, dynamic>, Map<String, dynamic>>($request);
  }

  @override
  Future<Response<Map<String, dynamic>>> doiChucVu(
    int sinhVienId,
    Map<String, dynamic> data,
  ) {
    final Uri $url = Uri.parse('/admin/lopsinhvien/${sinhVienId}/chucvu');
    final $body = data;
    final Request $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<Map<String, dynamic>, Map<String, dynamic>>($request);
  }

  @override
  Future<Response<Map<String, dynamic>>> fetchNienKhoaHocKy() {
    final Uri $url = Uri.parse('/admin/nien-khoa');
    final Request $request = Request('GET', $url, client.baseUrl);
    return client.send<Map<String, dynamic>, Map<String, dynamic>>($request);
  }

  @override
  Future<Response<dynamic>> getAllUsers() {
    final Uri $url = Uri.parse('/admin/giangvien');
    final Request $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> fetchDiemRenLuyen(
    int idLop,
    int thoiGian,
    int nam,
  ) {
    final Uri $url = Uri.parse('/admin/lop-chu-nhiem/nhap-diem-rl/${idLop}');
    final Map<String, dynamic> $params = <String, dynamic>{
      'thoi_gian': thoiGian,
      'nam': nam,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> updateBulkDiemRenLuyen({
    required String selectedStudents,
    required String thoiGian,
    required String xepLoai,
    required String nam,
  }) {
    final Uri $url = Uri.parse('/admin/lop/cap-nhat-diem-checked');
    final Map<String, String> $headers = {
      'content-type': 'application/x-www-form-urlencoded',
    };
    final $body = <String, String>{
      'selected_students': selectedStudents.toString(),
      'thoi_gian': thoiGian.toString(),
      'xep_loai': xepLoai.toString(),
      'nam': nam.toString(),
    };
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      headers: $headers,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getDanhSachNganhHoc() {
    final Uri $url = Uri.parse('/admin/nganh-hoc');
    final Request $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getDanhSachBoMon() {
    final Uri $url = Uri.parse('/admin/bo-mon');
    final Request $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getDanhSachVaiTro() {
    final Uri $url = Uri.parse('/admin/roles');
    final Request $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getDanhSachGiayXacNhan() {
    final Uri $url = Uri.parse('/admin/giay-xac-nhan');
    final Request $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> confirmMultipleGiayXacNhan(
    Map<String, dynamic> body,
  ) {
    final Uri $url = Uri.parse('/admin/giay-xac-nhan');
    final $body = body;
    final Request $request = Request('PUT', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<Map<String, dynamic>>> getALLLopHocPhanList() {
    final Uri $url = Uri.parse('/admin/lop-hoc-phan');
    final Request $request = Request('GET', $url, client.baseUrl);
    return client.send<Map<String, dynamic>, Map<String, dynamic>>($request);
  }

  @override
  Future<Response<Map<String, dynamic>>> getLopHocPhanTheoGiangVienList() {
    final Uri $url = Uri.parse('/admin/lop-hoc-phan/giang-vien');
    final Request $request = Request('GET', $url, client.baseUrl);
    return client.send<Map<String, dynamic>, Map<String, dynamic>>($request);
  }

  @override
  Future<Response<Map<String, dynamic>>> getLopHocPhanList() {
    final Uri $url = Uri.parse('/admin/diem-mon-hoc');
    final Request $request = Request('GET', $url, client.baseUrl);
    return client.send<Map<String, dynamic>, Map<String, dynamic>>($request);
  }

  @override
  Future<Response<Map<String, dynamic>>> getDanhSachSinhVienLopHocPhan(
    int idLopHocPhan,
  ) {
    final Uri $url = Uri.parse('/admin/diem-mon-hoc/${idLopHocPhan}');
    final Request $request = Request('GET', $url, client.baseUrl);
    return client.send<Map<String, dynamic>, Map<String, dynamic>>($request);
  }

  @override
  Future<Response<Map<String, dynamic>>> phanCongGiangVien(
    int lopHocPhanId,
    Map<String, dynamic> body,
  ) {
    final Uri $url = Uri.parse(
      '/admin/lop-hoc-phan/phan-cong-giang-vien/${lopHocPhanId}',
    );
    final $body = body;
    final Request $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<Map<String, dynamic>, Map<String, dynamic>>($request);
  }

  @override
  Future<Response<Map<String, dynamic>>> updateTrangThaiNopDiem(
    int idLopHocPhan,
  ) {
    final Uri $url = Uri.parse(
      '/admin/diem-mon-hoc/nop-bang-diem/${idLopHocPhan}',
    );
    final Request $request = Request('POST', $url, client.baseUrl);
    return client.send<Map<String, dynamic>, Map<String, dynamic>>($request);
  }

  @override
  Future<Response<Map<String, dynamic>>> capNhatDiemMonHoc(
    Map<String, dynamic> body,
  ) {
    final Uri $url = Uri.parse('/admin/diem-mon-hoc/cap-nhat');
    final $body = body;
    final Request $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<Map<String, dynamic>, Map<String, dynamic>>($request);
  }

  @override
  Future<Response<Map<String, dynamic>>> getThongBaoList() {
    final Uri $url = Uri.parse('/admin/thongbao');
    final Request $request = Request('GET', $url, client.baseUrl);
    return client.send<Map<String, dynamic>, Map<String, dynamic>>($request);
  }

  @override
  Future<Response<Map<String, dynamic>>> getThongBaoDetail(int id) {
    final Uri $url = Uri.parse('/admin/thongbao/${id}');
    final Request $request = Request('GET', $url, client.baseUrl);
    return client.send<Map<String, dynamic>, Map<String, dynamic>>($request);
  }

  @override
  Future<Response<dynamic>> deleteFileInThongBao(int id) {
    final Uri $url = Uri.parse('/admin/thongbao/file/${id}');
    final Request $request = Request('DELETE', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<Map<String, dynamic>>> createThongBaoWithFiles(
    String tieuDe,
    String noiDung,
    String tuAi,
    String ngayGui,
    List<MultipartFile> files,
  ) {
    final Uri $url = Uri.parse('/admin/thongbao');
    final List<PartValue> $parts = <PartValue>[
      PartValue<String>('tieu_de', tieuDe),
      PartValue<String>('noi_dung', noiDung),
      PartValue<String>('tu_ai', tuAi),
      PartValue<String>('ngay_gui', ngayGui),
      PartValue<List<MultipartFile>>('files[]', files),
    ];
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      parts: $parts,
      multipart: true,
    );
    return client.send<Map<String, dynamic>, Map<String, dynamic>>($request);
  }

  @override
  Future<Response<Map<String, dynamic>>> updateThongBaoWithFiles(
    int id,
    String title,
    String content,
    String ngayGui,
    String tuAi,
    int trangThai,
    List<MultipartFile> files,
    String oldFilesJson,
  ) {
    final Uri $url = Uri.parse('/admin/thongbao/${id}?_method=PUT');
    final List<PartValue> $parts = <PartValue>[
      PartValue<String>('tieu_de', title),
      PartValue<String>('noi_dung', content),
      PartValue<String>('ngay_gui', ngayGui),
      PartValue<String>('tu_ai', tuAi),
      PartValue<int>('trang_thai', trangThai),
      PartValue<List<MultipartFile>>('files', files),
      PartValue<String>('old_files', oldFilesJson),
    ];
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      parts: $parts,
      multipart: true,
    );
    return client.send<Map<String, dynamic>, Map<String, dynamic>>($request);
  }

  @override
  Future<Response<dynamic>> deleteThongBao(int id) {
    final Uri $url = Uri.parse('/admin/thongbao/${id}');
    final Request $request = Request('DELETE', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<Map<String, dynamic>>> sendThongBaoToStudents(
    int id,
    Map<String, dynamic> body,
  ) {
    final Uri $url = Uri.parse('/admin/thongbao/send-to-student/${id}');
    final $body = body;
    final Request $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<Map<String, dynamic>, Map<String, dynamic>>($request);
  }

  @override
  Future<Response<Map<String, dynamic>>> getCapTrenOptions() {
    final Uri $url = Uri.parse('/admin/thongbao/get-data-cap-tren');
    final Request $request = Request('GET', $url, client.baseUrl);
    return client.send<Map<String, dynamic>, Map<String, dynamic>>($request);
  }

  @override
  Future<Response<Map<String, dynamic>>> createComment(
    int thongBaoId,
    Map<String, dynamic> body,
  ) {
    final Uri $url = Uri.parse('/admin/thongbao/binh-luan/${thongBaoId}');
    final $body = body;
    final Request $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<Map<String, dynamic>, Map<String, dynamic>>($request);
  }

  @override
  Future<Response<dynamic>> deleteComment(int commentId) {
    final Uri $url = Uri.parse('/admin/thongbao/binh-luan/${commentId}');
    final Request $request = Request('DELETE', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> storePhieuLenLop(Map<String, dynamic> body) {
    final Uri $url = Uri.parse('/admin/phieu-len-lop/store');
    final $body = body;
    final Request $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getPhieuLenLopAll() {
    final Uri $url = Uri.parse('/admin/phieu-len-lop/all');
    final Request $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getBienBanListByLop(int lopId) {
    final Uri $url = Uri.parse('/admin/bienbanshcn/${lopId}');
    final Request $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getBienBanCreateInfo(int lopId) {
    final Uri $url = Uri.parse('/admin/bienbanshcn/create/${lopId}');
    final Request $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> createBienBan(
    int lopId,
    Map<String, dynamic> data,
  ) {
    final Uri $url = Uri.parse('/admin/bienbanshcn/store/${lopId}');
    final $body = data;
    final Request $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getBienBanDetail(int bienBanId) {
    final Uri $url = Uri.parse('/admin/bienbanshcn/chitiet/${bienBanId}');
    final Request $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> updateBienBan(
    int bienBanId,
    Map<String, dynamic> data,
  ) {
    final Uri $url = Uri.parse('/admin/bienbanshcn/${bienBanId}');
    final $body = data;
    final Request $request = Request('PUT', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getBienBanEditInfo(int bienBanId) {
    final Uri $url = Uri.parse('/admin/bienbanshcn/${bienBanId}/edit');
    final Request $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> deleteBienBan(int bienBanId) {
    final Uri $url = Uri.parse('/admin/bienbanshcn/${bienBanId}');
    final Request $request = Request('DELETE', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> confirmBienBan(int bienBanId) {
    final Uri $url = Uri.parse('/admin/bienbanshcn/confirm/${bienBanId}');
    final Request $request = Request('POST', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> deleteSinhVienVang(int chiTietId) {
    final Uri $url = Uri.parse('/admin/bienbanshcn/sinhvienvang/${chiTietId}');
    final Request $request = Request('DELETE', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<Map<String, dynamic>>> getDanhSachTuan(int namBatDau) {
    final Uri $url = Uri.parse('/admin/danhsach-tuan');
    final Map<String, dynamic> $params = <String, dynamic>{
      'nam_bat_dau': namBatDau,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<Map<String, dynamic>, Map<String, dynamic>>($request);
  }

  @override
  Future<Response<dynamic>> khoiTaoTuan(String date) {
    final Uri $url = Uri.parse('/admin/khoi-tao-tuan');
    final Map<String, String> $headers = {
      'content-type': 'application/x-www-form-urlencoded',
    };
    final $body = <String, String>{'date': date.toString()};
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      headers: $headers,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getCTDT() {
    final Uri $url = Uri.parse('/admin/ctdt');
    final Request $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getDanhSachThoiKhoaBieu() {
    final Uri $url = Uri.parse('/admin/thoi-khoa-bieu');
    final Request $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<Map<String, dynamic>>> createThoiKhoaBieu(
    Map<String, dynamic> body,
  ) {
    final Uri $url = Uri.parse('/admin/thoi-khoa-bieu');
    final $body = body;
    final Request $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<Map<String, dynamic>, Map<String, dynamic>>($request);
  }

  @override
  Future<Response<Map<String, dynamic>>> updateThoiKhoaBieu(
    int tkbId,
    Map<String, dynamic> body,
  ) {
    final Uri $url = Uri.parse('/admin/thoi-khoa-bieu/${tkbId}');
    final $body = body;
    final Request $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<Map<String, dynamic>, Map<String, dynamic>>($request);
  }

  @override
  Future<Response<dynamic>> deleteThoiKhoaBieu(int tkbId) {
    final Uri $url = Uri.parse(
      '/admin/thoi-khoa-bieu/xoa-thoi-khoa-bieu/${tkbId}',
    );
    final Request $request = Request('DELETE', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> copyNhieuThoiKhoaBieuWeek(
    Map<String, dynamic> body,
  ) {
    final Uri $url = Uri.parse('/admin/thoi-khoa-bieu/copy-nhieu-tuan');
    final $body = body;
    final Request $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<Map<String, dynamic>>> fetchLichThi() {
    final Uri $url = Uri.parse('/admin/lich-thi/danh-sach-lich-thi');
    final Request $request = Request('GET', $url, client.baseUrl);
    return client.send<Map<String, dynamic>, Map<String, dynamic>>($request);
  }

  @override
  Future<Response<Map<String, dynamic>>> createLichThi(
    Map<String, dynamic> body,
  ) {
    final Uri $url = Uri.parse('/admin/lich-thi/tao-lich-thi');
    final $body = body;
    final Request $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<Map<String, dynamic>, Map<String, dynamic>>($request);
  }

  @override
  Future<Response<Map<String, dynamic>>> updateLichThi(
    int lichThiId,
    Map<String, dynamic> body,
  ) {
    final Uri $url = Uri.parse(
      '/admin/lich-thi/cap-nhat-lich-thi/${lichThiId}',
    );
    final $body = body;
    final Request $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<Map<String, dynamic>, Map<String, dynamic>>($request);
  }

  @override
  Future<Response<dynamic>> deleteLichThi(int lichThiId) {
    final Uri $url = Uri.parse('/admin/lich-thi/xoa-lich-thi/${lichThiId}');
    final Request $request = Request('DELETE', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }
}
