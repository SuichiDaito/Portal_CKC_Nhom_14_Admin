abstract class DiemRLEvent {}

class FetchDiemRenLuyen extends DiemRLEvent {
  final int lopId;
  final int thoiGian;
  final int nam;

  FetchDiemRenLuyen(this.lopId, this.thoiGian, this.nam);
}

class UpdateBulkDiemRenLuyen extends DiemRLEvent {
  final String thoiGian;
  final String nam;
  final String xepLoai;
  final List<int> selectedStudentIds;

  UpdateBulkDiemRenLuyen({
    required this.thoiGian,
    required this.nam,
    required this.xepLoai,
    required this.selectedStudentIds,
  });
}
