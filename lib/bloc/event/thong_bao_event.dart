import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' show MultipartFile;
import 'package:portal_ckc/api/model/admin_thong_bao.dart';

abstract class ThongBaoEvent {}

class FetchThongBaoList extends ThongBaoEvent {}

class FetchThongBaoDetail extends ThongBaoEvent {
  final int id;
  FetchThongBaoDetail(this.id);
}

class CreateThongBao extends ThongBaoEvent {
  final String title;
  final String content;
  final String capTren;
  final String ngayGui;
  final List<MultipartFile> files;
  CreateThongBao({
    required this.title,
    required this.content,
    required this.capTren,
    required this.ngayGui,
    required this.files,
  });
}

class UpdateThongBao extends ThongBaoEvent {
  final int id;
  final String title;
  final String content;
  final int? trangThai;
  final String tuAi;
  final String ngayGui;
  final List<MultipartFile> files;
  final List<int> oldFiles;

  UpdateThongBao({
    required this.id,
    required this.title,
    required this.content,
    this.trangThai,
    required this.tuAi,
    required this.ngayGui,
    required this.files,
    required this.oldFiles,
  });
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

class DeleteAttachedFile extends ThongBaoEvent {
  final int fileId;
  DeleteAttachedFile(this.fileId);
}
