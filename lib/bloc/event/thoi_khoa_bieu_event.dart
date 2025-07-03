import 'package:portal_ckc/api/model/admin_thoi_khoa_bieu.dart';

abstract class ThoiKhoaBieuEvent {}

class FetchThoiKhoaBieuEvent extends ThoiKhoaBieuEvent {}

class CreateThoiKhoaBieuEvent extends ThoiKhoaBieuEvent {
  final ThoiKhoaBieu tkbData;
  CreateThoiKhoaBieuEvent(this.tkbData);
}

class UpdateThoiKhoaBieuEvent extends ThoiKhoaBieuEvent {
  final int id;
  final ThoiKhoaBieu tkbData;
  UpdateThoiKhoaBieuEvent(this.id, this.tkbData);
}

class DeleteThoiKhoaBieuEvent extends ThoiKhoaBieuEvent {
  final int id;
  DeleteThoiKhoaBieuEvent(this.id);
}

class CopyThoiKhoaBieuWeekEvent extends ThoiKhoaBieuEvent {
  final int tkbId;
  final int newWeekId;

  CopyThoiKhoaBieuWeekEvent({required this.tkbId, required this.newWeekId});
}

class CopyNhieuThoiKhoaBieuWeekEvent extends ThoiKhoaBieuEvent {
  final List<int> tkbIds;
  final int startWeekId;
  final int endWeekId;

  CopyNhieuThoiKhoaBieuWeekEvent({
    required this.tkbIds,
    required this.startWeekId,
    required this.endWeekId,
  });
}
