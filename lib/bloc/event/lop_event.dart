abstract class LopDetailEvent {}

class FetchLopDetail extends LopDetailEvent {
  final int lopId;
  FetchLopDetail(this.lopId);
}

class FetchAllLopEvent extends LopDetailEvent {}

class ChangeStudentRoleEvent extends LopDetailEvent {
  final int sinhVienId;
  final int chucVu; // 0: không có chức vụ, 1: thư ký (ví dụ)

  ChangeStudentRoleEvent({required this.sinhVienId, required this.chucVu});
}
