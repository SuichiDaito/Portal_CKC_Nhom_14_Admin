abstract class LopHocPhanEvent {}

class FetchLopHocPhan extends LopHocPhanEvent {
  final int? idLop;
  FetchLopHocPhan({this.idLop});
}
