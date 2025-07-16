import 'package:portal_ckc/api/model/admin_sinh_vien.dart';

class SinhVienLopHocPhan {
  final SinhVien sinhVien;
  double? diemThucHanh;
  double? diemLyThuyet;
  double? diemThiLan2;
  double? diemChuyenCan;
  double? diemQuaTrinh;
  double? diemThiLan1;
  final List<DangKyHocGhepThiLai> dangKyHocGhepThiLai;
  double? diemTongKet;
  bool isSelected;
  SinhVienLopHocPhan({
    required this.sinhVien,
    this.diemThucHanh,
    this.diemLyThuyet,
    this.diemChuyenCan,
    this.diemQuaTrinh,
    this.diemThiLan1,
    this.diemThiLan2,
    this.dangKyHocGhepThiLai = const [],
    this.diemTongKet,
    this.isSelected = true,
  });

  factory SinhVienLopHocPhan.fromJson(
    Map<String, dynamic> json,
    int idLopHocPhan,
  ) {
    final danhSach = json['danh_sach_hoc_phans'] as List<dynamic>? ?? [];

    final diem = danhSach.firstWhere(
      (e) => e['id_lop_hoc_phan'] == idLopHocPhan,
      orElse: () => {},
    );
    final hocGhepList =
        json['dang_ky_hoc_ghep_thi_lai'] as List<dynamic>? ?? [];

    return SinhVienLopHocPhan(
      sinhVien: SinhVien.fromJson(json),
      diemThucHanh: double.tryParse(
        diem['diem_md_thuc_hanh']?.toString() ?? "",
      ),
      diemLyThuyet: double.tryParse(
        diem['diem_md_ly_thuyet']?.toString() ?? "",
      ),
      diemChuyenCan: double.tryParse(diem['diem_chuyen_can']?.toString() ?? ""),
      diemQuaTrinh: double.tryParse(diem['diem_qua_trinh']?.toString() ?? ""),
      diemThiLan1: double.tryParse(diem['diem_thi_lan_1']?.toString() ?? ""),
      diemThiLan2: double.tryParse(diem['diem_thi_lan_2']?.toString() ?? ""),
      diemTongKet: double.tryParse(diem['diem_tong_ket']?.toString() ?? ""),
      dangKyHocGhepThiLai: hocGhepList
          .map((e) => DangKyHocGhepThiLai.fromJson(e))
          .toList(),
    );
  }

  void setGrade(SinhVienLopHocPhan other) {
    diemChuyenCan = other.diemChuyenCan;
    diemQuaTrinh = other.diemQuaTrinh;
    diemThiLan1 = other.diemThiLan1;
    diemThiLan2 = other.diemThiLan2;

    diemLyThuyet = other.diemLyThuyet;
    diemTongKet = other.diemTongKet;
  }
}

class CapNhatDiemRequest {
  final int idLopHocPhan;
  final List<int> students;
  final Map<int, double> diemChuyenCan;
  final Map<int, double> diemQuaTrinh;
  final Map<int, double> diemThiLan1;
  final Map<int, double> diemThiLan2;

  CapNhatDiemRequest({
    required this.idLopHocPhan,
    required this.students,
    required this.diemChuyenCan,
    required this.diemQuaTrinh,
    required this.diemThiLan1,
    required this.diemThiLan2,
  });

  Map<String, dynamic> toJson() {
    return {
      'id_lop_hoc_phan': idLopHocPhan,
      'students': students,
      'diem_chuyen_can': diemChuyenCan.map((k, v) => MapEntry(k.toString(), v)),
      'diem_qua_trinh': diemQuaTrinh.map((k, v) => MapEntry(k.toString(), v)),
      'diem_thi_lan_1': diemThiLan1.map((k, v) => MapEntry(k.toString(), v)),
      'diem_thi_lan_2': diemThiLan2.map((k, v) => MapEntry(k.toString(), v)),
    };
  }
}

class DangKyHocGhepThiLai {
  final int idSinhVien;
  final int idLopHocPhan;
  final String soTien;
  final int loaiDong;
  final int trangThai;
  final String createdAt;
  final String updatedAt;

  DangKyHocGhepThiLai({
    required this.idSinhVien,
    required this.idLopHocPhan,
    required this.soTien,
    required this.loaiDong,
    required this.trangThai,
    required this.createdAt,
    required this.updatedAt,
  });

  factory DangKyHocGhepThiLai.fromJson(Map<String, dynamic> json) {
    return DangKyHocGhepThiLai(
      idSinhVien: json['id_sinh_vien'] ?? 0,
      idLopHocPhan: json['id_lop_hoc_phan'] ?? 0,
      soTien: json['so_tien'] ?? '0',
      loaiDong: json['loai_dong'] ?? 0,
      trangThai: json['trang_thai'] ?? 0,
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
    );
  }
}
