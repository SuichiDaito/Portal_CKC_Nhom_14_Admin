import 'package:portal_ckc/api/model/admin_tuan.dart';

abstract class TuanState {}

class TuanInitial extends TuanState {}

class TuanLoading extends TuanState {}

class TuanLoaded extends TuanState {
  final List<TuanModel> danhSachTuan;

  TuanLoaded(this.danhSachTuan);
}

class TuanError extends TuanState {
  final String message;

  TuanError(this.message);
}
