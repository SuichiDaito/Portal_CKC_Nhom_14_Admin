abstract class ThongBaoEvent {}

class FetchThongBaoList extends ThongBaoEvent {}

class FetchThongBaoDetail extends ThongBaoEvent {
  final int id;
  FetchThongBaoDetail(this.id);
}

class CreateThongBao extends ThongBaoEvent {
  final String title, content;
  final int capTren;
  CreateThongBao(this.title, this.content, this.capTren);
}

class UpdateThongBao extends ThongBaoEvent {
  final int id;
  final String title, content;
  UpdateThongBao(this.id, this.title, this.content);
}

class DeleteThongBao extends ThongBaoEvent {
  final int id;
  DeleteThongBao(this.id);
}

class SendToStudents extends ThongBaoEvent {
  final int id;
  final List<int> lopIds;
  SendToStudents(this.id, this.lopIds);
}

class FetchCapTrenOptions extends ThongBaoEvent {}

class CreateCommentEvent extends ThongBaoEvent {
  final int thongBaoId;
  final String noiDung;
  final int? idBinhLuanCha;

  CreateCommentEvent({
    required this.thongBaoId,
    required this.noiDung,
    this.idBinhLuanCha,
  });
}

class DeleteCommentEvent extends ThongBaoEvent {
  final int commentId;

  DeleteCommentEvent(this.commentId);
}
