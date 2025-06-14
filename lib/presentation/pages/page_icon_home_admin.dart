import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.blue[100],
              child: Icon(Icons.person, color: Colors.blue[700]),
            ),
            SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Nguyễn Văn B',
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  'Trưởng khoa CNTT',
                  style: TextStyle(color: Colors.grey[600], fontSize: 12),
                ),
              ],
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Main Menu',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 16),
            _buildMainMenuGrid(context),
            SizedBox(height: 24),
            Text(
              'Other',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 16),
            _buildOtherMenuGrid(context),
          ],
        ),
      ),
    );
  }

  Widget _buildMainMenuGrid(BuildContext context) {
    final mainMenuItems = [
      DashboardItem(
        title: 'Sổ lên lớp',
        icon: Icons.class_,
        color: Colors.blue,
        onTap: () => _handleAction(context, 'Sổ lên lớp'),
      ),
      DashboardItem(
        title: 'Xem danh sách lớp',
        icon: Icons.list_alt,
        color: Colors.green,
        onTap: () => _handleAction(context, 'Xem danh sách lớp'),
      ),
      DashboardItem(
        title: 'Xem Lịch tuần',
        icon: Icons.calendar_today,
        color: Colors.orange,
        onTap: () => _handleAction(context, 'Xem Lịch tuần'),
      ),
      DashboardItem(
        title: 'Thông báo',
        icon: Icons.notifications,
        color: Colors.red,
        onTap: () => _handleAction(context, 'Thông báo'),
      ),
      DashboardItem(
        title: 'Lớp chủ nhiệm',
        icon: Icons.supervised_user_circle,
        color: Colors.purple,
        onTap: () => _handleAction(context, 'Lớp chủ nhiệm'),
      ),
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: mainMenuItems.length,
      itemBuilder: (context, index) {
        return _buildDashboardCard(mainMenuItems[index]);
      },
    );
  }

  Widget _buildOtherMenuGrid(BuildContext context) {
    final otherMenuItems = [
      DashboardItem(
        title: 'Quản lý phòng học',
        icon: Icons.meeting_room,
        color: Colors.teal,
        onTap: () => _handleAction(context, 'Quản lý phòng học'),
      ),
      DashboardItem(
        title: 'Quản lý sinh viên',
        icon: Icons.school,
        color: Colors.indigo,
        onTap: () => _handleAction(context, 'Quản lý sinh viên'),
      ),
      DashboardItem(
        title: 'Lịch Thi',
        icon: Icons.quiz,
        color: Colors.amber,
        onTap: () => _handleAction(context, 'Lịch Thi'),
      ),
      DashboardItem(
        title: 'Cấp giấy xác nhận',
        icon: Icons.verified,
        color: Colors.cyan,
        onTap: () => _handleAction(context, 'Cấp giấy xác nhận'),
      ),
      DashboardItem(
        title: 'Quản lý lớp học phần',
        icon: Icons.analytics,
        color: Colors.deepOrange,
        onTap: () => _handleAction(context, 'Quản lý lớp học phần'),
      ),
      DashboardItem(
        title: 'Cập nhật tham số',
        icon: Icons.settings,
        color: Colors.blueGrey,
        onTap: () => _handleAction(context, 'Cập nhật tham số'),
      ),
      DashboardItem(
        title: 'Danh sách giáo viên',
        icon: Icons.people,
        color: Colors.pink,
        onTap: () => _handleAction(context, 'Danh sách giáo viên'),
      ),
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: otherMenuItems.length,
      itemBuilder: (context, index) {
        return _buildDashboardCard(otherMenuItems[index]);
      },
    );
  }

  Widget _buildDashboardCard(DashboardItem item) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: item.onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                item.color.withOpacity(0.1),
                item.color.withOpacity(0.05),
              ],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: item.color.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(item.icon, size: 32, color: item.color),
              ),
              SizedBox(height: 12),
              Text(
                item.title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleAction(BuildContext context, String action) {
    // Xử lý action tương ứng với từng chức năng
    switch (action) {
      case 'Sổ lên lớp':
        _showActionDialog(
          context,
          'Sổ lên lớp',
          'Chức năng điểm danh và quản lý sổ lên lớp',
        );
        break;
      case 'Xem danh sách lớp':
        _showActionDialog(
          context,
          'Danh sách lớp',
          'Xem danh sách các lớp học',
        );
        break;
      case 'Xem Lịch tuần':
        _showActionDialog(
          context,
          'Lịch tuần',
          'Xem lịch giảng dạy trong tuần',
        );
        break;
      case 'Thông báo':
        _showActionDialog(context, 'Thông báo', 'Xem các thông báo mới nhất');
        break;
      case 'Lớp chủ nhiệm':
        _showActionDialog(context, 'Lớp chủ nhiệm', 'Quản lý lớp chủ nhiệm');
        break;
      case 'Quản lý phòng học':
        _showActionDialog(
          context,
          'Quản lý phòng học',
          'Quản lý và đặt phòng học',
        );
        break;
      case 'Quản lý sinh viên':
        _showActionDialog(
          context,
          'Quản lý sinh viên',
          'Quản lý thông tin sinh viên',
        );
        break;
      case 'Lịch Thi':
        _showActionDialog(context, 'Lịch Thi', 'Xem lịch thi và coi thi');
        break;
      case 'Cấp giấy xác nhận':
        _showActionDialog(
          context,
          'Cấp giấy xác nhận',
          'Cấp các loại giấy xác nhận',
        );
        break;
      case 'Quản lý lớp học phần':
        _showActionDialog(
          context,
          'Quản lý lớp học phần',
          'Quản lý các lớp học phần',
        );
        break;
      case 'Cập nhật tham số':
        _showActionDialog(
          context,
          'Cập nhật tham số',
          'Cập nhật các tham số hệ thống',
        );
        break;
      case 'Danh sách giáo viên':
        _showActionDialog(
          context,
          'Danh sách giáo viên',
          'Xem danh sách giáo viên',
        );
        break;
      default:
        _showActionDialog(context, action, 'Chức năng đang được phát triển');
    }
  }

  void _showActionDialog(
    BuildContext context,
    String title,
    String description,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(description),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Đóng'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                // Thêm logic điều hướng đến màn hình tương ứng
                print('Điều hướng đến: $title');
              },
              child: Text('Mở'),
            ),
          ],
        );
      },
    );
  }
}

class DashboardItem {
  final String title;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  DashboardItem({
    required this.title,
    required this.icon,
    required this.color,
    required this.onTap,
  });
}

// Màn hình chính để chạy ứng dụng
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dashboard App',
      theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'Roboto'),
      home: DashboardScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
