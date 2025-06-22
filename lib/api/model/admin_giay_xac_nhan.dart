import 'package:portal_ckc/api/model/admin_sinh_vien.dart';

class DangKyGiayModel {
  final int id;
  final int? idSinhVien;
  final int? idGiangVien;
  final int idLoaiGiay;
  final String ngayDangKy;
  final String ngayNhan;
  final int trangThai;
  final LoaiGiayModel loaiGiay;
  final SinhVien sinhVien;

  DangKyGiayModel({
    required this.id,
    this.idSinhVien,
    this.idGiangVien,
    required this.idLoaiGiay,
    required this.ngayDangKy,
    required this.ngayNhan,
    required this.trangThai,
    required this.loaiGiay,
    required this.sinhVien,
  });

  factory DangKyGiayModel.fromJson(Map<String, dynamic> json) {
    return DangKyGiayModel(
      id: json['id'],
      idSinhVien: json['id_sinh_vien'],
      idGiangVien: json['id_giang_vien'],
      idLoaiGiay: json['id_loai_giay'],
      ngayDangKy: json['ngay_dang_ky'],
      ngayNhan: json['ngay_nhan'],
      trangThai: json['trang_thai'],
      loaiGiay: LoaiGiayModel.fromJson(json['loai_giay']),
      sinhVien: SinhVien.fromJson(json['sinh_vien']),
    );
  }
}

class LoaiGiayModel {
  final int id;
  final String tenGiay;
  final int trangThai;

  LoaiGiayModel({
    required this.id,
    required this.tenGiay,
    required this.trangThai,
  });

  factory LoaiGiayModel.fromJson(Map<String, dynamic> json) {
    return LoaiGiayModel(
      id: json['id'],
      tenGiay: json['ten_giay'],
      trangThai: json['trang_thai'],
    );
  }
}

enum DocumentRequestStatus { pending, confirmed }

enum DocumentType { transcript, certificate, recommendationLetter, other }

class DocumentRequest {
  final String id;
  final String studentCode;
  final String studentName;
  final DateTime requestDate;
  final String documentName; // <-- dùng trực tiếp từ API
  final DocumentRequestStatus status;
  final bool isSelected;

  DocumentRequest({
    required this.id,
    required this.studentCode,
    required this.studentName,
    required this.requestDate,
    required this.documentName,
    required this.status,
    this.isSelected = false,
  });

  factory DocumentRequest.fromModel(DangKyGiayModel model) {
    return DocumentRequest(
      id: model.id.toString(),
      studentCode: model.sinhVien.maSv,
      studentName: model.sinhVien.hoSo?.hoTen ?? 'Không rõ',
      requestDate: DateTime.tryParse(model.ngayDangKy) ?? DateTime.now(),
      documentName: model.loaiGiay.tenGiay, // ✅ dùng trực tiếp
      status: model.trangThai == 1
          ? DocumentRequestStatus.confirmed
          : DocumentRequestStatus.pending,
    );
  }
}
