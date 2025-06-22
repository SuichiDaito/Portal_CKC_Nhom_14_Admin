abstract class DangKyGiayEvent {}

class FetchDangKyGiayEvent extends DangKyGiayEvent {}

abstract class GiayXacNhanEvent {}

class ConfirmMultipleGiayXacNhanEvent extends DangKyGiayEvent {
  final List<int> ids;
  final int userId;
  final int trangThai;
  ConfirmMultipleGiayXacNhanEvent({
    required this.ids,
    required this.userId,
    required this.trangThai,
  });
}
