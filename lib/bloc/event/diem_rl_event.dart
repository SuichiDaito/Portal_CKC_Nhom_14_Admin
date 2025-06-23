abstract class DiemRLEvent {}

class FetchDiemRenLuyen extends DiemRLEvent {
  final int lopId;
  final int thoiGian; // tháng

  FetchDiemRenLuyen(this.lopId, this.thoiGian);
}
