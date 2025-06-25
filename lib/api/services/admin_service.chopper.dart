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
  Future<Response<Map<String, dynamic>>> getRooms() {
    final Uri $url = Uri.parse('/admin/phong');
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
  Future<Response<dynamic>> fetchDiemRenLuyen(int idLop, int thoiGian) {
    final Uri $url = Uri.parse('/admin/lop-chu-nhiem/nhap-diem-rl/${idLop}');
    final Map<String, dynamic> $params = <String, dynamic>{
      'thoi_gian': thoiGian,
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
  Future<Response<Map<String, dynamic>>> createThongBao(
    Map<String, dynamic> body,
  ) {
    final Uri $url = Uri.parse('/admin/thongbao');
    final $body = body;
    final Request $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<Map<String, dynamic>, Map<String, dynamic>>($request);
  }

  @override
  Future<Response<Map<String, dynamic>>> updateThongBao(
    int id,
    Map<String, dynamic> body,
  ) {
    final Uri $url = Uri.parse('/admin/thongbao/${id}');
    final $body = body;
    final Request $request = Request('PUT', $url, client.baseUrl, body: $body);
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
  Future<Response<dynamic>> deleteFileInThongBao(int id) {
    final Uri $url = Uri.parse('/admin/thongbao/file/${id}');
    final Request $request = Request('DELETE', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<Map<String, dynamic>>> getCapTrenOptions() {
    final Uri $url = Uri.parse('/admin/thongbao/get-data-cap-tren');
    final Request $request = Request('GET', $url, client.baseUrl);
    return client.send<Map<String, dynamic>, Map<String, dynamic>>($request);
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
}
