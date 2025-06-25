import 'package:equatable/equatable.dart';
import 'package:portal_ckc/api/model/admin_phieu_len_lop.dart';

abstract class PhieuLenLopState extends Equatable {
  const PhieuLenLopState();

  @override
  List<Object?> get props => [];
}

class PhieuLenLopInitial extends PhieuLenLopState {}

class PhieuLenLopLoading extends PhieuLenLopState {}

class PhieuLenLopLoaded extends PhieuLenLopState {
  final List<PhieuLenLop> phieuLenLops;

  const PhieuLenLopLoaded(this.phieuLenLops);

  @override
  List<Object?> get props => [phieuLenLops];
}

class PhieuLenLopSuccess extends PhieuLenLopState {
  final String message;

  const PhieuLenLopSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class PhieuLenLopError extends PhieuLenLopState {
  final String error;

  const PhieuLenLopError(this.error);

  @override
  List<Object?> get props => [error];
}
// bloc/state/phieu_len_lop_state.dart

class PhieuInitial extends PhieuLenLopState {}

class PhieuSubmitting extends PhieuLenLopState {}

class PhieuSuccess extends PhieuLenLopState {}

class PhieuFailure extends PhieuLenLopState {
  final String message;

  const PhieuFailure(this.message);

  @override
  List<Object?> get props => [message];
}
