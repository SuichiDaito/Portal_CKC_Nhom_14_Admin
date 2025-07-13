import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApplicationsAdminPage extends StatelessWidget {
  const ApplicationsAdminPage({Key? key}) : super(key: key);

  Future<bool> hasPermission(String permission) async {
    final prefs = await SharedPreferences.getInstance();
    final permissions = prefs.getStringList('user_permissions') ?? [];
    return permissions.contains(permission);
  }

  Future<List<String>> _getPermissions() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('user_permissions') ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<String>>(
      future: _getPermissions(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final permissions = snapshot.data!;
        return SingleChildScrollView(
          padding: const EdgeInsets.all(13.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSection(
                context: context,
                title: 'Dành cho Giảng viên',
                icon: Icons.person,
                iconColor: Colors.blue,
                backgroundColor: Colors.blue.withOpacity(0.05),
                borderColor: Colors.blue.withOpacity(0.2),
                gridItems: _getTeacherFeatures(),
                permissions: permissions,
              ),
              const SizedBox(height: 24),
              _buildSection(
                context: context,
                title: 'Dành cho phòng Công tác',
                icon: Icons.school,
                iconColor: Colors.green,
                backgroundColor: Colors.green.withOpacity(0.05),
                borderColor: Colors.green.withOpacity(0.2),
                gridItems: _getCTCTFeatures(),
                permissions: permissions,
              ),
              const SizedBox(height: 24),
              _buildSection(
                context: context,
                title: 'Dành cho phòng Đào tạo',
                icon: Icons.school,
                iconColor: Colors.blueGrey,
                backgroundColor: Colors.blueGrey.withOpacity(0.05),
                borderColor: Colors.blueGrey.withOpacity(0.2),
                gridItems: _getPDTFeatures(),
                permissions: permissions,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSection({
    required String title,
    required IconData icon,
    required Color iconColor,
    required Color backgroundColor,
    required Color borderColor,
    required List<_FeatureItem> gridItems,
    required BuildContext context,
    required List<String> permissions,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: borderColor, width: 1),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: iconColor.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: iconColor, size: 20),
              ),
              const SizedBox(width: 12),
              Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: iconColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: gridItems.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: MediaQuery.of(context).size.width > 400 ? 3 : 2,
              childAspectRatio: 1.1,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
            ),
            itemBuilder: (context, index) {
              final feature = gridItems[index];
              final hasPermission = permissions.contains(feature.permission);
              return _buildFeatureCard(context, feature, hasPermission);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureCard(
    BuildContext context,
    _FeatureItem feature,
    bool hasPermission,
  ) {
    return GestureDetector(
      onTap: () {
        GoRouter.of(context).push('/admin/${feature.value}');
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: feature.color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(feature.icon, color: feature.color, size: 24),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                feature.title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<_FeatureItem> _getCTCTFeatures() {
    return [
      _FeatureItem(
        icon: Icons.person,
        title: 'Quản lý sinh viên',
        color: Colors.indigo,
        value: 'student_management_admin',
        permission: 'danh sách sinh viên',
      ),
      _FeatureItem(
        icon: Icons.description,
        title: 'Quản lý cấp giấy tờ',
        color: Colors.brown,
        value: 'decument_request_management_admin',
        permission: 'danh sách sinh viên đăng ký giấy xác nhận',
      ),
      _FeatureItem(
        icon: Icons.person_2,
        title: 'Quản lý giảng viên',
        color: Colors.blueGrey,
        value: 'teacher_management_admin',
        permission: 'danh sách giảng viên',
      ),
    ];
  }

  List<_FeatureItem> _getPDTFeatures() {
    return [
      _FeatureItem(
        icon: Icons.calendar_today,
        title: 'Quản lý lịch tuần',
        color: Colors.cyan,
        value: 'schedule_management_admin',
        permission: 'xem tuần',
      ),
      _FeatureItem(
        icon: Icons.school,
        title: 'Phân công lớp học phần',
        color: Colors.lightGreen,
        value: 'course_assignment_admin',
        permission: 'tạo lịch học',
      ),
      _FeatureItem(
        icon: Icons.alarm,
        title: 'Quản lý lịch thi',
        color: Colors.redAccent,
        value: 'exam_schedule_groupe_admin',
        permission: 'tạo lịch thi',
      ),
      _FeatureItem(
        icon: Icons.meeting_room,
        title: 'Quản lý phòng học',
        color: Colors.deepOrange,
        value: 'room_management_admin',
        permission: 'danh sách phòng học',
      ),
      _FeatureItem(
        icon: Icons.book,
        title: 'Quản lý sổ lên lớp',
        color: Colors.pink,
        value: 'class_list_book_admin',
        permission: 'Sổ lên lớp',
      ),
      _FeatureItem(
        icon: Icons.security,
        title: 'Khởi tạo năm học',
        color: Colors.grey,
        value: 'academic_year_management',
        permission: 'tạo tuần',
      ),
    ];
  }

  List<_FeatureItem> _getTeacherFeatures() {
    return [
      _FeatureItem(
        icon: Icons.class_,
        title: 'Quản lý lớp chủ nhiệm',
        color: Colors.blueAccent,
        value: 'class_management_admin',
        permission: 'xem lớp học',
      ),
      _FeatureItem(
        icon: Icons.menu_book,
        title: 'Sổ lên lớp',
        color: Colors.green,
        value: 'class_book_admin',
        permission: 'Tạo sổ lên lớp',
      ),
      _FeatureItem(
        icon: Icons.list_alt,
        title: 'Danh sách lớp học phần',
        color: Colors.teal,
        value: 'class_roster_admin',
        permission: 'xem lớp học',
      ),
      _FeatureItem(
        icon: Icons.event_seat,
        title: 'Lịch gác thi',
        color: Colors.deepPurple,
        value: 'exam_schedule_admin',
        permission: 'lịch thi',
      ),
      _FeatureItem(
        icon: Icons.schedule,
        title: 'Lịch giảng dạy',
        color: Colors.orange,
        value: 'teaching_schedule_admin',
        permission: 'xem lịch dạy',
      ),
    ];
  }
}

class _FeatureItem {
  final IconData icon;
  final String title;
  final Color color;
  final String value;
  final String permission;

  _FeatureItem({
    required this.icon,
    required this.title,
    required this.color,
    required this.value,
    required this.permission,
  });
}
