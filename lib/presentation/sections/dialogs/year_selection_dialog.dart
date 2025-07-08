import 'package:flutter/material.dart';
import 'package:portal_ckc/api/model/admin_nien_khoa.dart';

class YearSelectionDialog extends StatelessWidget {
  final NienKhoa nienKhoa;

  const YearSelectionDialog({super.key, required this.nienKhoa});

  @override
  Widget build(BuildContext context) {
    final parts = nienKhoa.tenNienKhoa.split('-');
    final start = int.tryParse(parts[0]) ?? DateTime.now().year;
    final end = int.tryParse(parts[1]) ?? start + 3;

    final years = List.generate(end - start + 2, (i) => start + i);

    return AlertDialog(
      title: const Text("Chọn năm học để khởi tạo tuần"),
      content: SizedBox(
        width: double.maxFinite,
        height: 200,
        child: ListView.builder(
          itemCount: years.length,
          itemBuilder: (_, index) {
            final year = years[index];
            return ListTile(
              title: Text("Năm $year"),
              onTap: () => Navigator.of(context).pop(year),
            );
          },
        ),
      ),
    );
  }
}
