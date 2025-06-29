import 'package:portal_ckc/api/model/admin_sinh_vien.dart';

class SinhVienLopHocPhan {
  final SinhVien sinhVien;
  double? diemThucHanh;
  double? diemLyThuyet;
  double? diemChuyenCan;
  double? diemQuaTrinh;
  double? diemThi;
  double? diemTongKet;
  bool isSelected;
  SinhVienLopHocPhan({
    required this.sinhVien,
    this.diemThucHanh,
    this.diemLyThuyet,
    this.diemChuyenCan,
    this.diemQuaTrinh,
    this.diemThi,
    this.diemTongKet,
    this.isSelected = false,
  });

  factory SinhVienLopHocPhan.fromJson(Map<String, dynamic> json) {
    final diem = (json['danh_sach_hoc_phans'] as List).firstWhere(
      (e) => e['lop_hoc_phan'] != null,
      orElse: () => {},
    );

    return SinhVienLopHocPhan(
      sinhVien: SinhVien.fromJson(json),
      diemThucHanh: diem['diem_md_thuc_hanh']?.toDouble(),
      diemLyThuyet: diem['diem_md_ly_thuyet']?.toDouble(),
      diemChuyenCan: diem['diem_chuyen_can']?.toDouble(),
      diemQuaTrinh: diem['diem_qua_trinh']?.toDouble(),
      diemThi: diem['diem_thi']?.toDouble(),
      diemTongKet: diem['diem_tong_ket']?.toDouble(),
    );
  }
  void setGrade(SinhVienLopHocPhan other) {
    diemChuyenCan = other.diemChuyenCan;
    diemQuaTrinh = other.diemQuaTrinh;
    diemThi = other.diemThi;
    diemLyThuyet = other.diemLyThuyet;
    diemTongKet = other.diemTongKet;
  }
}

class CapNhatDiemRequest {
  final int idLopHocPhan;
  final List<int> students;
  final Map<int, double> diemChuyenCan;
  final Map<int, double> diemQuaTrinh;
  final Map<int, double> diemThi;
  final Map<int, double> diemLyThuyet;

  CapNhatDiemRequest({
    required this.idLopHocPhan,
    required this.students,
    required this.diemChuyenCan,
    required this.diemQuaTrinh,
    required this.diemThi,
    required this.diemLyThuyet,
  });

  Map<String, dynamic> toJson() {
    return {
      'id_lop_hoc_phan': idLopHocPhan,
      'students': students,
      'diem_chuyen_can': diemChuyenCan.map((k, v) => MapEntry(k.toString(), v)),
      'diem_qua_trinh': diemQuaTrinh.map((k, v) => MapEntry(k.toString(), v)),
      'diem_thi': diemThi.map((k, v) => MapEntry(k.toString(), v)),
      'diem_ly_thuyet': diemLyThuyet.map((k, v) => MapEntry(k.toString(), v)),
    };
  }
}
