abstract class LopDetailEvent {}

class FetchLopDetail extends LopDetailEvent {
  final int lopId;
  FetchLopDetail(this.lopId);
}

class FetchAllLopEvent extends LopDetailEvent {}
