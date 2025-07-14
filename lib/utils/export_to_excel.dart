import 'package:excel/excel.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:permission_handler/permission_handler.dart';
import 'package:portal_ckc/api/model/admin_sinh_vien_lhp.dart';

Future<void> ExportToExcel(List<SinhVienLopHocPhan> students) async {
  final excel = Excel.createExcel();
  final Sheet sheetObject = excel['DiemSV'];

  sheetObject.appendRow([
    'Mã SV',
    'Họ tên',
    'Chuyên cần',
    'Quá trình',
    'Thi lần 1',
    'Thi lần 2',
    'Điểm tổng kết',
  ]);

  for (var student in students) {
    sheetObject.appendRow([
      student.sinhVien.maSv,
      student.sinhVien.hoSo.hoTen,
      student.diemChuyenCan ?? 0.0,
      student.diemQuaTrinh ?? 0.0,
      student.diemThiLan1 ?? 0.0,
      student.diemThiLan2 ?? 0.0,
      student.diemTongKet ?? 0.0,
    ]);
  }

  if (await Permission.manageExternalStorage.request().isGranted) {
    // final dir = await getApplicationDocumentsDirectory(); // ✅ hoạt động được cả Android/iOS/Windows

    final dir = await getExternalStorageDirectory();
    String filePath =
        "${dir!.path}/Diem_Lop_${DateTime.now().millisecondsSinceEpoch}.xlsx";
    final fileBytes = excel.encode();
    final file = File(filePath);
    await file.writeAsBytes(fileBytes!);

    final result = await OpenFilex.open(filePath);

    print("📁 File lưu tại: $filePath");
    print("📂 Trạng thái mở file: ${result.message}");
  } else {
    print("❌ Không có quyền truy cập bộ nhớ");
  }
}
