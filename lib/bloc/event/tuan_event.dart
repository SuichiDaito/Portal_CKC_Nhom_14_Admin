abstract class TuanEvent {}

class FetchTuanEvent extends TuanEvent {
  final int namBatDau;

  FetchTuanEvent(this.namBatDau);
}
