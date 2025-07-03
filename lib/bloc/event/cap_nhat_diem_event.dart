import 'package:portal_ckc/api/model/admin_sinh_vien_lhp.dart';

abstract class CapNhatDiemEvent {}

class SubmitCapNhatDiem extends CapNhatDiemEvent {
  final CapNhatDiemRequest request;

  SubmitCapNhatDiem(this.request);
}

class GetLopHocPhanEvent extends CapNhatDiemEvent {
  final int? lopId;
  GetLopHocPhanEvent({this.lopId});
}

class GetDanhSachSinhVienEvent extends CapNhatDiemEvent {
  final int idLopHocPhan;
  GetDanhSachSinhVienEvent(this.idLopHocPhan);
}

class UpdateTrangThaiNopDiemEvent extends CapNhatDiemEvent {
  final int idLopHocPhan;
  UpdateTrangThaiNopDiemEvent(this.idLopHocPhan);
}
