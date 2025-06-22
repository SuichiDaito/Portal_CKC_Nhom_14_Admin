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
    final Uri $url = Uri.parse('/admin/admin/nhap-diem-ren-luyen/${idLop}');
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
}
