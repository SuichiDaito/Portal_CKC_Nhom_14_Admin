import 'package:portal_ckc/api/model/admin_diem_ren_luyen_response.dart';

abstract class DiemRLState {}

class DiemRLLoading extends DiemRLState {}

class DiemRLLoaded extends DiemRLState {
  final NhapDiemRLResponse data;

  DiemRLLoaded(this.data);
}

class DiemRLError extends DiemRLState {
  final String message;

  DiemRLError(this.message);
}

class DiemRLInitial extends DiemRLState {}
