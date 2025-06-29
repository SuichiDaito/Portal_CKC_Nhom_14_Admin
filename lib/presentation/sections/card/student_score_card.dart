import 'package:flutter/material.dart';
import 'package:portal_ckc/presentation/sections/card/edit_score_dialog.dart';

class StudentScoreCard extends StatelessWidget {
  final String maSv;
  final String hoTen;
  final String lop;
  final String email;
  final String gioiTinh;
  final Map<String, dynamic> diem;

  const StudentScoreCard({
    super.key,
    required this.maSv,
    required this.hoTen,
    required this.email,
    required this.lop,
    required this.gioiTinh,
    required this.diem,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$maSv - $hoTen',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text('Email: $email'),
            Text('Giới tính: $gioiTinh'),
            Text('Lớp: $lop'),
            const Divider(),
            Text('Lý thuyết: ${diem['lyThuyet'] ?? '-'}'),
            Text('Thực hành: ${diem['thucHanh'] ?? '-'}'),
            Text('Chuyên cần: ${diem['chuyenCan'] ?? '-'}'),
            Text('Quá trình: ${diem['quaTrinh'] ?? '-'}'),
            Text('Thi: ${diem['thi'] ?? '-'}'),
            Text('Tổng kết: ${diem['tongKet'] ?? '-'}'),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton.icon(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (_) =>
                        EditScoreDialog(maSv: maSv, currentScores: diem),
                  );
                },
                icon: const Icon(Icons.edit, size: 18),
                label: const Text('Sửa điểm'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
