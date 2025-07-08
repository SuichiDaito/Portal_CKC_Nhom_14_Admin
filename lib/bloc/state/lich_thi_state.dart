import 'package:portal_ckc/api/model/admin_lich_thi.dart';

abstract class LichThiState {}

class LichThiInitial extends LichThiState {}

class LichThiLoading extends LichThiState {}

class LichThiLoaded extends LichThiState {
  final List<ExamSchedule> lichThiList;
  LichThiLoaded(this.lichThiList);
}

class LichThiError extends LichThiState {
  final String message;
  LichThiError(this.message);
}

class LichThiOperationSuccess extends LichThiState {
  final String message;
  LichThiOperationSuccess(this.message);
}

class LichThiOperationFailed extends LichThiState {
  final String message;
  LichThiOperationFailed(this.message);
}
