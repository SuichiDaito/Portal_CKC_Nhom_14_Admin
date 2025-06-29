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

class DiemRLSuccess extends DiemRLState {
  final String message;

  DiemRLSuccess(this.message);
}

class DiemRLUpdateSuccess extends DiemRLState {
  final String message;
  DiemRLUpdateSuccess(this.message);
}

class DiemRLUpdateFailure extends DiemRLState {
  final String message;
  DiemRLUpdateFailure(this.message);
}
