abstract class CapNhatDiemState {}

class CapNhatDiemInitial extends CapNhatDiemState {}

class CapNhatDiemLoading extends CapNhatDiemState {}

class CapNhatDiemSuccess extends CapNhatDiemState {
  final String message;

  CapNhatDiemSuccess(this.message);
}

class CapNhatDiemFailure extends CapNhatDiemState {
  final String error;

  CapNhatDiemFailure(this.error);
}
