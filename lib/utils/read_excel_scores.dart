import 'dart:io';
import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:portal_ckc/api/model/admin_sinh_vien_lhp.dart';

Future<void> importScoresFromExcel(
  BuildContext context,
  List<SinhVienLopHocPhan> students,
) async {
  final result = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowedExtensions: ['xlsx', 'xls'],
  );

  if (result == null || result.files.single.path == null) return;

  final bytes = File(result.files.single.path!).readAsBytesSync();

  late Excel excel;
  try {
    excel = Excel.decodeBytes(bytes);
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("❌ File không hợp lệ hoặc không phải định dạng Excel"),
        backgroundColor: Colors.red,
      ),
    );
    return;
  }

  final sheet = excel.tables[excel.tables.keys.first];
  if (sheet == null || sheet.rows.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("❌ File không có dữ liệu hoặc không đúng định dạng."),
        backgroundColor: Colors.red,
      ),
    );
    return;
  }

  final header = sheet.rows.first;
  if (header.length < 6 ||
      header[0]?.value == null ||
      header[2]?.value == null ||
      header[3]?.value == null ||
      header[4]?.value == null ||
      header[5]?.value == null) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("❌ File Excel không đúng định dạng yêu cầu."),
        backgroundColor: Colors.red,
      ),
    );
    return;
  }

  for (var row in sheet.rows.skip(1)) {
    if (row.length < 6 || row[0]?.value == null) continue;

    final studentCode = row[0]?.value?.toString().trim();
    final chuyenCan = double.tryParse(row[2]?.value?.toString() ?? '') ?? 0.0;
    final quaTrinh = double.tryParse(row[3]?.value?.toString() ?? '') ?? 0.0;
    final thi1 = double.tryParse(row[4]?.value?.toString() ?? '') ?? 0.0;
    final thi2 = double.tryParse(row[5]?.value?.toString() ?? '') ?? 0.0;

    final matched = students.firstWhere(
      (s) => s.sinhVien.maSv == studentCode,
      orElse: () => null as SinhVienLopHocPhan,
    );

    if (matched != null) {
      matched.diemChuyenCan = chuyenCan;
      matched.diemQuaTrinh = quaTrinh;
      matched.diemThiLan1 = thi1;
      matched.diemThiLan2 = thi2;
    }
  }

  (context as Element).markNeedsBuild();

  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(content: Text("✅ Đã nhập điểm thành công từ file Excel")),
  );
}
