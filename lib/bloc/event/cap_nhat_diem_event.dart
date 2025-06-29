import 'package:portal_ckc/api/model/admin_sinh_vien_lhp.dart';

abstract class CapNhatDiemEvent {}

class SubmitCapNhatDiem extends CapNhatDiemEvent {
  final CapNhatDiemRequest request;

  SubmitCapNhatDiem(this.request);
}
