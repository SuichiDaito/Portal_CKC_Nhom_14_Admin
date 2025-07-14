import 'package:portal_ckc/api/model/admin_thong_bao.dart';
import 'package:equatable/equatable.dart';

abstract class ThongBaoState {}

class TBInitial extends ThongBaoState {}

class TBLoading extends ThongBaoState {}

class TBListLoaded extends ThongBaoState {
  final List<ThongBao> list;
  TBListLoaded(this.list);
  @override
  List<Object?> get props => [list];
}

class TBDetailLoaded extends ThongBaoState {
  final ThongBao detail;
  TBDetailLoaded(this.detail);
}

class TBDataCapTrenLoaded extends ThongBaoState {
  final List<CapTrenOption> options;
  TBDataCapTrenLoaded(this.options);
}

class TBSuccess extends ThongBaoState {
  final String message;
  final int? thongBaoId;

  TBSuccess(this.message, {this.thongBaoId});
}

class TBFailure extends ThongBaoState {
  final String error;
  TBFailure(this.error);
}
