import 'package:portal_ckc/api/model/admin_giay_xac_nhan.dart';

abstract class DangKyGiayState {}

class DangKyGiayInitial extends DangKyGiayState {}

class DangKyGiayLoading extends DangKyGiayState {}

class DangKyGiayLoaded extends DangKyGiayState {
  final List<DangKyGiayModel> danhSach;

  DangKyGiayLoaded(this.danhSach);
}

class DangKyGiayError extends DangKyGiayState {
  final String message;

  DangKyGiayError(this.message);
}

abstract class GiayXacNhanState {}

class GiayXacNhanInitial extends GiayXacNhanState {}

class GiayXacNhanLoading extends GiayXacNhanState {}

class GiayXacNhanSuccess extends GiayXacNhanState {
  final List<int> updatedIds;

  GiayXacNhanSuccess(this.updatedIds);
}

class GiayXacNhanError extends GiayXacNhanState {
  final String message;

  GiayXacNhanError(this.message);
}

class DangKyGiayConfirmedSuccess extends DangKyGiayState {
  final List<dynamic> updatedIds;
  DangKyGiayConfirmedSuccess(this.updatedIds);
}
