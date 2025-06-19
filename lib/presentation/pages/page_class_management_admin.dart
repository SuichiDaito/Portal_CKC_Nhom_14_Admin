import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:portal_ckc/presentation/sections/button/buttons_class_action_class_management.dart';
import 'package:portal_ckc/presentation/sections/card/class_management_card.dart';
import 'package:portal_ckc/presentation/sections/card/class_management_dialogs.dart';
import 'package:portal_ckc/presentation/sections/card/class_management_teacher_info_card.dart';
import 'package:portal_ckc/presentation/sections/class_management_class_list_section.dart';

class PageClassManagementAdmin extends StatefulWidget {
  const PageClassManagementAdmin({super.key});

  @override
  _PageClassManagementAdminState createState() =>
      _PageClassManagementAdminState();
}

class _PageClassManagementAdminState extends State<PageClassManagementAdmin> {
  final String teacherName = "TS. Nguyễn Văn An";
  final String teacherId = "GV001";
  final String department = "Khoa Công Nghệ Thông Tin";

  final List<ClassInfo> classList = [
    ClassInfo(
      className: "CDTH22E",
      studentCount: 45,
      course: "K22",
      semester: "HK2 2024-2025",
    ),
    // ... các lớp khác
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        title: const Text(
          'Quản Lý Lớp Chủ Nhiệm',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: const Color(0xFF1976D2),
        elevation: 4,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 2. Thông tin giảng viên
            TeacherInfoCard(
              teacherName: teacherName,
              teacherId: teacherId,
              department: department,
            ),

            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: ButtonsClassActionClassManagementReport(
                    onTap: () {
                      // TODO: mở danh sách biên bản SHCN hoặc điều hướng
                      context.push(
                        '/admin/meeting_minutes_admin',
                      ); // ví dụ đường dẫn
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ClassActionButtons(
                    onOpenClassList: () {
                      // Thêm logic xử lý khác nếu muốn nút khác chức năng
                      print("Đang tới trang danh sách sinh viên");
                      showClassListDialog(
                        context,
                        classList.cast<ClassInfo>(),
                        (selectedClass) {
                          showClassDetailsDialog(context, selectedClass);
                        },
                      );
                    },
                  ),
                ),
              ],
            ),

            // 3. Nút tác vụ
            const SizedBox(height: 20),

            // 4. Danh sách lớp
            buildClassListSection(
              classList: classList,
              onTapClass: (info) => showClassDetailsDialog(context, info),
            ),
          ],
        ),
      ),
    );
  }
}
