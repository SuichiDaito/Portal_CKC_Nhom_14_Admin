abstract class DiemRLEvent {}

class FetchDiemRenLuyen extends DiemRLEvent {
  final int lopId;
  final int thoiGian;

  FetchDiemRenLuyen(this.lopId, this.thoiGian);
}
