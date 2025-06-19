// 📁 student_list.dart
import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:portal_ckc/api/model/admin_sinh_vien.dart';

class StudentList extends StatelessWidget {
  final List<SinhVien> studentList;
  final void Function(SinhVien) onTapStudent;
=======
import 'package:portal_ckc/presentation/pages/page_class_detail_admin.dart';

class StudentList extends StatelessWidget {
  final List<Student> studentList;
  final void Function(Student) onTapStudent;
>>>>>>> origin/develop

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
<<<<<<< HEAD
              child: Icon(
                Icons.school, // 🎓 biểu tượng học sinh
                color: Colors.white,
                size: 24,
              ),
            ),

            title: Text(
              student.hoSo.hoTen,
=======
              child: Text(
                student.id.substring(student.id.length - 2),
                style: const TextStyle(color: Colors.white),
              ),
            ),
            title: Text(
              student.name,
>>>>>>> origin/develop
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 4),
<<<<<<< HEAD
                Text("MSSV: ${student.maSv}"),
                Text("Chức vụ: ${student.chucVu == 0 ? 'Thư ký' : 'Không có'}"),
=======
                Text("MSSV: ${student.id}"),
                Text(
                  "Chức vụ: ${student.role.isNotEmpty ? student.role : "Không có"}",
                ),
>>>>>>> origin/develop
              ],
            ),
            trailing: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
<<<<<<< HEAD
                color: student.trangThai == 0
=======
                color: student.status == 'Đang học'
>>>>>>> origin/develop
                    ? Colors.green[50]
                    : Colors.red[50],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
<<<<<<< HEAD
                'Trạng thái: ${{0: 'Đang học', 1: 'Bảo lưu', 2: 'Đã tốt nghiệp'}[student.trangThai] ?? 'Không rõ'}',
                style: TextStyle(
                  color: student.trangThai == 0 ? Colors.green : Colors.red,
=======
                student.status,
                style: TextStyle(
                  color: student.status == 'Đang học'
                      ? Colors.green
                      : Colors.red,
>>>>>>> origin/develop
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
