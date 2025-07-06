// 📁 student_list.dart
import 'package:flutter/material.dart';
import 'package:portal_ckc/api/model/admin_sinh_vien.dart';

class StudentList extends StatelessWidget {
  final List<StudentWithRole> studentList;
  final void Function(StudentWithRole) onTapStudent;

  const StudentList({
    super.key,
    required this.studentList,
    required this.onTapStudent,
  });

  @override
  Widget build(BuildContext context) {
    if (studentList.isEmpty) {
      return const Center(child: Text('Không tìm thấy sinh viên nào.'));
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: studentList.length,
      itemBuilder: (context, index) {
        final student = studentList[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 6,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
            leading: CircleAvatar(
              radius: 24,
              backgroundColor: const Color(0xFF1976D2),
              child: Icon(
                Icons.school, // 🎓 biểu tượng học sinh
                color: Colors.white,
                size: 24,
              ),
            ),

            title: Text(
              student.sinhVien.hoSo.hoTen,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 4),
                Text("MSSV: ${student.sinhVien.maSv}"),
                Text("Chức vụ: ${student.chucVu == 1 ? 'Thư ký' : 'Không có'}"),
              ],
            ),
            trailing: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: student.sinhVien.trangThai == 0
                    ? Colors.green[50]
                    : Colors.red[50],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                'Trạng thái: ${{0: 'Đang học', 1: 'Bảo lưu', 2: 'Đã tốt nghiệp'}[student.sinhVien.trangThai] ?? 'Không rõ'}',
                style: TextStyle(
                  color: student.sinhVien.trangThai == 0
                      ? Colors.green
                      : Colors.red,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
            onTap: () => onTapStudent(student),
          ),
        );
      },
    );
  }
}
