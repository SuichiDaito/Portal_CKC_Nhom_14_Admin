abstract class CapNhatDiemState {}

class CapNhatDiemInitial extends CapNhatDiemState {}

class CapNhatDiemLoading extends CapNhatDiemState {}

class CapNhatDiemFailure extends CapNhatDiemState {
  final String error;

  CapNhatDiemFailure(this.error);
}

class CapNhatDiemSuccess extends CapNhatDiemState {
  final String message;
  CapNhatDiemSuccess(this.message);
}

class CapNhatDanhSachLopHocPhanSuccess extends CapNhatDiemState {
  final dynamic data;
  CapNhatDanhSachLopHocPhanSuccess(this.data);
}

class CapNhatDanhSachSinhVienSuccess extends CapNhatDiemState {
  final dynamic data;
  CapNhatDanhSachSinhVienSuccess(this.data);
}
