
import 'package:portal_ckc/api/model/admin_danh_sach_lop.dart';
import 'package:portal_ckc/api/model/admin_diem_ren_luyen_response.dart';
import 'package:portal_ckc/api/model/admin_ho_so.dart';
import 'package:portal_ckc/api/model/admin_lop.dart';

enum StudentStatus { active, inactive, graduated, suspended }

class SinhVien {
  final int id;
  final String maSv;
  final int? idLop;
  final int? idHoSo;
  final int? chucVu;
  final int trangThai;
  final HoSo hoSo;
  final Lop lop;
  final List<DiemRenLuyen> diemRenLuyens;

  SinhVien({
    required this.id,
    required this.maSv,
    this.idLop,
    this.idHoSo,
    this.chucVu,
    required this.trangThai,
    required this.hoSo,
    required this.lop,
    required this.diemRenLuyens,

  });

  factory SinhVien.fromJson(Map<String, dynamic> json) {
    return SinhVien(
      id: json['id'] ?? 0,
      maSv: json['ma_sv'] ?? '',
      idLop: json['id_lop'],
      idHoSo: json['id_ho_so'],
      chucVu: json['chuc_vu'],
      trangThai: json['trang_thai'] ?? 0,
      hoSo: json['ho_so'] != null ? HoSo.fromJson(json['ho_so']) : HoSo.empty(),
      lop: json['lop'] != null ? Lop.fromJson(json['lop']) : Lop.empty(),
      diemRenLuyens:
          (json['diem_ren_luyens'] as List<dynamic>?)
              ?.map((e) => DiemRenLuyen.fromJson(e))
              .toList() ??
          [],
    );
  }
  Map<String, dynamic> toJson() => {
    'id': id,
    'ma_sv': maSv,
    'id_lop': idLop,
    'id_ho_so': idHoSo,
    'chuc_vu': chucVu,
    'trang_thai': trangThai,
    'ho_so': hoSo.toJson(),
    'lop': lop.toJson(),
    'diem_ren_luyens': diemRenLuyens.map((e) => e.toJson()).toList(),
  };
  factory SinhVien.empty() {
    return SinhVien(
      id: 0,
      maSv: '',
      idLop: null,
      idHoSo: null,
      chucVu: null,
      trangThai: 0,
      hoSo: HoSo.empty(),
      lop: Lop.empty(),
      diemRenLuyens: [],
    );
  }
}

class DanhSachSinhVienResponse {
  final Lop lop;
  final List<StudentWithRole> students;

  DanhSachSinhVienResponse({required this.lop, required this.students});

  factory DanhSachSinhVienResponse.fromJson(Map<String, dynamic> json) {
    return DanhSachSinhVienResponse(
      lop: Lop.fromJson(json['lop']),
      students: (json['sinh_viens'] as List<dynamic>)
          .map((e) => StudentWithRole.fromJson(e))
          .toList(),
    );
  }
}

class StudentWithScore {
  final SinhVien sinhVien;
  String conductScore;
  bool isSelected;

  StudentWithScore({
    required this.sinhVien,
    this.conductScore = '-',
    this.isSelected = false,
  });

  factory StudentWithScore.fromJson(
    Map<String, dynamic> json, {
    required int month,
    required int year,
  }) {
    String score = '-';
    if (json['diem_ren_luyens'] != null) {
      for (final item in json['diem_ren_luyens']) {
        if ((item['thoi_gian']?.toString() ?? '') == month.toString() &&
            item['id_nam']?.toString() == year.toString()) {
          score = convertXepLoaiToString(item['xep_loai']);
          break;
        }
      }
    }

    return StudentWithScore(
      sinhVien: SinhVien.fromJson(json),
      conductScore: score,
    );
  }

  static String convertXepLoaiToString(dynamic value) {
    switch (value.toString()) {
      case '1':
        return 'A';
      case '2':
        return 'B';
      case '3':
        return 'C';
      case '4':
        return 'D';
      default:
        return '-';
    }
  }

  factory StudentWithScore.fromSinhVien({required SinhVien sv}) {
    String score = '-';
    if (sv.diemRenLuyens.isNotEmpty) {
      score = convertXepLoaiToString(sv.diemRenLuyens.first.xepLoai);
    }

    return StudentWithScore(sinhVien: sv, conductScore: score);
  }

  String get id => sinhVien.maSv;
  String get name => sinhVien.hoSo.hoTen;
}
