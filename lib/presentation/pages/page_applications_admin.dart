import 'package:flutter/material.dart';

class ApplicationsAdminPage extends StatelessWidget {
  const ApplicationsAdminPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(13.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section for Students
          _buildSection(
            title: 'Dành cho Sinh viên',
            icon: Icons.school,
            iconColor: Colors.green,
            backgroundColor: Colors.green.withOpacity(0.05),
            borderColor: Colors.green.withOpacity(0.2),
            gridItems: _getStudentFeatures(),
          ),

          const SizedBox(height: 24),

          // Section for Teachers
          _buildSection(
            title: 'Dành cho Giảng viên',
            icon: Icons.person,
            iconColor: Colors.blue,
            backgroundColor: Colors.blue.withOpacity(0.05),
            borderColor: Colors.blue.withOpacity(0.2),
            gridItems: _getTeacherFeatures(),
          ),
        ],
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required IconData icon,
    required Color iconColor,
    required Color backgroundColor,
    required Color borderColor,
    required List<_FeatureItem> gridItems,
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
          // Section Header
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

          // Grid View
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 1.1,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
            ),
            itemCount: gridItems.length,
            itemBuilder: (context, index) {
              final feature = gridItems[index];
              return _buildFeatureCard(feature);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureCard(_FeatureItem feature) {
    return GestureDetector(
      onTap: () {
        print('Tapped on ${feature.title}');
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
            // Icon Container
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
            // Title
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

  List<_FeatureItem> _getStudentFeatures() {
    return [
      _FeatureItem(
        icon: Icons.assessment,
        title: 'Điểm rèn luyện',
        color: Colors.blue,
      ),
      _FeatureItem(
        icon: Icons.notifications,
        title: 'Thông báo',
        color: Colors.orange,
      ),
      _FeatureItem(icon: Icons.videocam, title: 'KPKP', color: Colors.green),
      _FeatureItem(
        icon: Icons.description,
        title: 'SKCH',
        color: Colors.purple,
      ),
      _FeatureItem(
        icon: Icons.calendar_today,
        title: 'Lịch học',
        color: Colors.red,
      ),
      _FeatureItem(icon: Icons.folder, title: 'Tài liệu', color: Colors.teal),
      _FeatureItem(
        icon: Icons.access_time,
        title: 'Thời khóa biểu',
        color: Colors.indigo,
      ),
      _FeatureItem(icon: Icons.star, title: 'Đánh giá', color: Colors.amber),
      _FeatureItem(
        icon: Icons.assignment,
        title: 'Bài tập',
        color: Colors.deepOrange,
      ),
    ];
  }

  List<_FeatureItem> _getTeacherFeatures() {
    return [
      _FeatureItem(
        icon: Icons.book,
        title: 'Quản lý môn học',
        color: Colors.blue,
      ),
      _FeatureItem(
        icon: Icons.analytics,
        title: 'Thống kê',
        color: Colors.green,
      ),
      _FeatureItem(
        icon: Icons.check_circle,
        title: 'Chấm điểm',
        color: Colors.indigo,
      ),
      _FeatureItem(
        icon: Icons.assignment_turned_in,
        title: 'Quản lý đề thi',
        color: Colors.orange,
      ),
      _FeatureItem(
        icon: Icons.group,
        title: 'Quản lý lớp học',
        color: Colors.purple,
      ),
      _FeatureItem(
        icon: Icons.schedule,
        title: 'Lịch giảng dạy',
        color: Colors.red,
      ),
      _FeatureItem(icon: Icons.bar_chart, title: 'Báo cáo', color: Colors.cyan),
      _FeatureItem(
        icon: Icons.notifications_active,
        title: 'Thông báo lớp',
        color: Colors.amber,
      ),
      _FeatureItem(icon: Icons.settings, title: 'Cài đặt', color: Colors.grey),
    ];
  }
}

class _FeatureItem {
  final IconData icon;
  final String title;
  final Color color;

  _FeatureItem({required this.icon, required this.title, required this.color});
}
