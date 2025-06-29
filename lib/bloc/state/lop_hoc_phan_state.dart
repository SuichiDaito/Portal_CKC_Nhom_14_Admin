import 'package:portal_ckc/api/model/admin_lop_hoc_phan.dart';

abstract class LopHocPhanState {}

class LopHocPhanInitial extends LopHocPhanState {}

class LopHocPhanLoading extends LopHocPhanState {}

class LopHocPhanLoaded extends LopHocPhanState {
  final List<LopHocPhan> lopHocPhans;

  LopHocPhanLoaded(this.lopHocPhans);

  @override
  List<Object?> get props => [lopHocPhans];
}

class LopHocPhanError extends LopHocPhanState {
  final String message;
  LopHocPhanError(this.message);
}
