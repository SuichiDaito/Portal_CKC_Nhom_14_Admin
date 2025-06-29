abstract class SinhVienLhpEvent {}

class FetchSinhVienLhp extends SinhVienLhpEvent {
  final int lopHocPhanId;
  FetchSinhVienLhp(this.lopHocPhanId);
}
