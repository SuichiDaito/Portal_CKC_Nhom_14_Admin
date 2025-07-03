abstract class LichThiEvent {}

class FetchLichThi extends LichThiEvent {}

class CreateLichThi extends LichThiEvent {
  final Map<String, dynamic> data;

  CreateLichThi(this.data);
}

class UpdateLichThi extends LichThiEvent {
  final int id;
  final Map<String, dynamic> data;

  UpdateLichThi(this.id, this.data);
}

class DeleteLichThi extends LichThiEvent {
  final int id;

  DeleteLichThi(this.id);
}

class FetchLichThiByGiangVienId extends LichThiEvent {
  final int giangVienId;

  FetchLichThiByGiangVienId(this.giangVienId);
}
