abstract class LopHocPhanEvent {}

class FetchLopHocPhan extends LopHocPhanEvent {
  final int? idLop;
  FetchLopHocPhan({this.idLop});
}

class LoadLopHocPhanEvent extends LopHocPhanEvent {}

class FetchALLLopHocPhan extends LopHocPhanEvent {
  final bool isAll;
  FetchALLLopHocPhan({this.isAll = false});
}

class PhanCongGiangVienEvent extends LopHocPhanEvent {
  final int lopHocPhanId;
  final int idGiangVien;

  PhanCongGiangVienEvent({
    required this.lopHocPhanId,
    required this.idGiangVien,
  });
}

class FetchLopHocPhanTheoGiangVien extends LopHocPhanEvent {}
