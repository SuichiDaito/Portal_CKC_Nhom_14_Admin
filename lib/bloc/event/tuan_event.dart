abstract class TuanEvent {}

class FetchTuanEvent extends TuanEvent {
  final int namBatDau;

  FetchTuanEvent(this.namBatDau);
}

class KhoiTaoTuanEvent extends TuanEvent {
  final String date; // định dạng yyyy-MM-dd
  KhoiTaoTuanEvent(this.date);
}
