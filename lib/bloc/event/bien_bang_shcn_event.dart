abstract class BienBanEvent {}

class FetchBienBan extends BienBanEvent {
  final int lopId;

  FetchBienBan(this.lopId);
}

class CreateBienBan extends BienBanEvent {
  final Map<String, dynamic> data;
  final int lopId;

  CreateBienBan({required this.data, required this.lopId});
}

class ConfirmBienBan extends BienBanEvent {
  final int bienBanId;

  ConfirmBienBan(this.bienBanId);
}

class DeleteSinhVienVangEvent extends BienBanEvent {
  final int chiTietId;

  DeleteSinhVienVangEvent(this.chiTietId);
}

class FetchBienBanDetail extends BienBanEvent {
  final int bienBanId;
  FetchBienBanDetail(this.bienBanId);
}

class FetchBienBanCreateInfo extends BienBanEvent {
  final int lopId;
  FetchBienBanCreateInfo(this.lopId);
}

class FetchBienBanEditInfo extends BienBanEvent {
  final int bienBanId;
  FetchBienBanEditInfo(this.bienBanId);
}

class UpdateBienBanEvent extends BienBanEvent {
  final int bienBanId;
  final Map<String, dynamic> data;
  UpdateBienBanEvent({required this.bienBanId, required this.data});
}

class DeleteBienBanEvent extends BienBanEvent {
  final int bienBanId;
  DeleteBienBanEvent(this.bienBanId);
}
