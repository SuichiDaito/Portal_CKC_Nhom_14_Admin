import 'package:portal_ckc/api/model/admin_ho_so.dart';
import 'package:portal_ckc/api/model/admin_lop.dart';
import 'package:portal_ckc/api/model/admin_sinh_vien.dart';

import 'package:portal_ckc/api/model/admin_thong_tin.dart';

class ThongBao {
  final int id;
  final int idGv;
  final String tuAi;
  final DateTime ngayGui;
  final String tieuDe;
  final String noiDung;
  final int trangThai;
  final DateTime? createdAt;
  final List<Lop>? dsLops;
  final User? giangVien;
  final List<ChiTietThongBao> chiTiet;
  final List<BinhLuan> binhLuans;
  final List<FileModel> files;

  ThongBao({
    required this.id,
    required this.idGv,
    required this.tuAi,
    required this.ngayGui,
    required this.tieuDe,
    required this.noiDung,
    required this.trangThai,
    required this.createdAt,
    this.dsLops,
    this.giangVien,
    required this.chiTiet,
    required this.binhLuans,
    required this.files,
  });

  factory ThongBao.fromJson(Map<String, dynamic> json) => ThongBao(
    id: json['id'],
    idGv: json['id_gv'] ?? 0,
    tuAi: json['tu_ai'] ?? '',
    ngayGui: DateTime.parse(
      json['ngay_gui'] ?? DateTime.now().toIso8601String(),
    ),
    tieuDe: json['tieu_de'] ?? '',
    noiDung: json['noi_dung'] ?? '',
    trangThai: json['trang_thai'] ?? 0,
    createdAt: json['created_at'] != null
        ? DateTime.tryParse(json['created_at'])
        : null,
    dsLops: (json['ds_lops'] as List?)?.map((e) => Lop.fromJson(e)).toList(),
    giangVien: json['giang_vien'] != null
        ? User.fromJson(json['giang_vien'])
        : null,
    chiTiet:
        (json['chi_tiet_thong_bao'] as List?)
            ?.map((e) => ChiTietThongBao.fromJson(e))
            .toList() ??
        [],
    binhLuans:
        (json['binh_luans'] as List?)
            ?.map((e) => BinhLuan.fromJson(e))
            .toList() ??
        [],
    files:
        (json['file'] as List?)?.map((e) => FileModel.fromJson(e)).toList() ??
        [],
  );
  Map<String, dynamic> toJson() => {
    'id': id,
    'id_gv': idGv,
    'tu_ai': tuAi,
    'ngay_gui': ngayGui.toIso8601String(),
    'tieu_de': tieuDe,
    'noi_dung': noiDung,
    'trang_thai': trangThai,
    'created_at': createdAt?.toIso8601String(),
    'ds_lops': dsLops?.map((lop) => lop.toJson()).toList(),
    'giang_vien': giangVien?.toJson(),
    'chi_tiet_thong_bao': chiTiet.map((e) => e.toJson()).toList(),
    'binh_luans': binhLuans.map((e) => e.toJson()).toList(),
    'file': files.map((f) => f.toJson()).toList(),
  };
}

class ChiTietThongBao {
  final int id;
  final int idThongBao;
  final SinhVien sinhVien;
  final int trangThai;

  ChiTietThongBao({
    required this.id,
    required this.idThongBao,
    required this.sinhVien,
    required this.trangThai,
  });

  factory ChiTietThongBao.fromJson(Map<String, dynamic> json) =>
      ChiTietThongBao(
        id: json['id'],
        idThongBao: json['id_thong_bao'],
        trangThai: json['trang_thai'],
        sinhVien: SinhVien.fromJson(json['sinh_vien']),
      );
}

extension ChiTietThongBaoExt on ChiTietThongBao {
  Map<String, dynamic> toJson() => {
    'id': id,
    'id_thong_bao': idThongBao,
    'sinh_vien': sinhVien.toJson(),
    'trang_thai': trangThai,
  };
}

class CapTrenOption {
  final String name;
  final int value;

  CapTrenOption({required this.name, required this.value});

  factory CapTrenOption.fromJson(Map<String, dynamic> json) =>
      CapTrenOption(name: json['name'], value: json['value']);
}

class BinhLuan {
  final int id;
  final String noiDung;
  final int? idBinhLuanCha;
  final int trangThai;
  final DateTime createdAt;
  final NguoiBinhLuan nguoiBinhLuan;
  final List<BinhLuan> binhLuanCon;

  BinhLuan({
    required this.id,
    required this.noiDung,
    this.idBinhLuanCha,
    required this.trangThai,
    required this.createdAt,
    required this.nguoiBinhLuan,
    required this.binhLuanCon,
  });

  factory BinhLuan.fromJson(Map<String, dynamic> json) => BinhLuan(
    id: json['id'],
    noiDung: json['noi_dung'],
    idBinhLuanCha: json['id_binh_luan_cha'],
    trangThai: json['trang_thai'],
    createdAt: DateTime.parse(json['created_at']),
    nguoiBinhLuan: NguoiBinhLuan.fromJson(json['nguoi_binh_luan']),
    binhLuanCon:
        (json['binh_luan_con'] as List?)
            ?.map((e) => BinhLuan.fromJson(e))
            .toList() ??
        [],
  );
}

extension BinhLuanExt on BinhLuan {
  Map<String, dynamic> toJson() => {
    'id': id,
    'noi_dung': noiDung,
    'id_binh_luan_cha': idBinhLuanCha,
    'trang_thai': trangThai,
    'created_at': createdAt.toIso8601String(),
    'nguoi_binh_luan': nguoiBinhLuan.toJson(),
    'binh_luan_con': binhLuanCon.map((e) => e.toJson()).toList(),
  };
}

extension NguoiBinhLuanExt on NguoiBinhLuan {
  Map<String, dynamic> toJson() => {
    'id': id,
    'type': type,
    'ho_so': hoSo.toJson(),
  };
}

class NguoiBinhLuan {
  final int id;
  final HoSo hoSo;
  final String type; // 'App\\Models\\User' hoặc 'App\\Models\\SinhVien'

  NguoiBinhLuan({required this.id, required this.hoSo, required this.type});

  factory NguoiBinhLuan.fromJson(Map<String, dynamic> json) => NguoiBinhLuan(
    id: json['id'],
    hoSo: HoSo.fromJson(json['ho_so']),
    type: json['type'] ?? '',
  );
}

class FileModel {
  final int id;
  final String tenFile;
  final String url;

  FileModel({required this.id, required this.tenFile, required this.url});

  factory FileModel.fromJson(Map<String, dynamic> json) =>
      FileModel(id: json['id'], tenFile: json['ten_file'], url: json['url']);

  Map<String, dynamic> toJson() => {'id': id, 'ten_file': tenFile, 'url': url};
}
