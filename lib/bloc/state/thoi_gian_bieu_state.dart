import 'package:portal_ckc/api/model/admin_thoi_khoa_bieu.dart';

abstract class ThoiKhoaBieuState {}

class ThoiKhoaBieuInitial extends ThoiKhoaBieuState {}

class ThoiKhoaBieuLoading extends ThoiKhoaBieuState {}

class ThoiKhoaBieuLoaded extends ThoiKhoaBieuState {
  final List<ThoiKhoaBieu> danhSach;
  ThoiKhoaBieuLoaded(this.danhSach);
}

class ThoiKhoaBieuSuccess extends ThoiKhoaBieuState {
  final String message;
  final ThoiKhoaBieu tkb;
  ThoiKhoaBieuSuccess(this.message, this.tkb);
}

class ThoiKhoaBieuDeleted extends ThoiKhoaBieuState {
  final String message;
  ThoiKhoaBieuDeleted(this.message);
}

class ThoiKhoaBieuError extends ThoiKhoaBieuState {
  final String message;
  ThoiKhoaBieuError(this.message);
}

class SaoChepLichError extends ThoiKhoaBieuState {
  final String message;
  SaoChepLichError(this.message);
}

class CopyThoiKhoaBieuSuccess extends ThoiKhoaBieuState {
  final ThoiKhoaBieu tkb;

  CopyThoiKhoaBieuSuccess(this.tkb);
}

class CopyNhieuThoiKhoaBieuSuccess extends ThoiKhoaBieuState {
  final List<ThoiKhoaBieu> copiedTKBs;

  CopyNhieuThoiKhoaBieuSuccess(this.copiedTKBs);
}
