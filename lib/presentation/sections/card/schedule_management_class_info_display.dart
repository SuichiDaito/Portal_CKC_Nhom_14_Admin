import 'package:flutter/material.dart';
import 'package:portal_ckc/api/model/admin_lop_hoc_phan.dart';

class ClassInfoDisplay extends StatelessWidget {
  final LopHocPhan classSchedule;

  const ClassInfoDisplay({Key? key, required this.classSchedule})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tenLop = classSchedule.lop.tenLop;
    final tenHocPhan = classSchedule.tenHocPhan;
    final siSo = classSchedule.soLuongDangKy;
    final loai = classSchedule.loaiLopHocPhan == 1 ? 'Thực hành' : 'Lý thuyết';
    final gv = classSchedule.gv?.hoSo?.hoTen ?? "";
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.blueAccent.withOpacity(0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$tenLop - $tenHocPhan',
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: Colors.blueAccent,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Giảng viên: $gv',
            style: const TextStyle(fontSize: 15, color: Colors.black87),
          ),
          const SizedBox(height: 6),

          Text(
            'Loại: $loai',
            style: const TextStyle(fontSize: 15, color: Colors.black87),
          ),
          const SizedBox(height: 4),
          Text(
            'Sĩ số: $siSo',
            style: const TextStyle(fontSize: 15, color: Colors.black87),
          ),
        ],
      ),
    );
  }
}
