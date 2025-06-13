import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:portal_ckc/presentation/pages/page_notification_detail_admin.dart';

// Main Notifications Page
class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  String selectedFilter = 'Tất cả';
  int _selectedIndex = 1; // Notifications tab selected

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.blue[600],
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => context.go('/admin/home'),
        ),
        title: Text(
          'Thông báo',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          // Filter Tabs
          _buildFilterTabs(),

          // Notifications List
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildNotificationSection('Thông báo khoa', Colors.orange, [
                    _createNotification(
                      'Thông báo khoa',
                      'Thông tin động học\nphí học kì 6 của\nkhoa...',
                      '24/06/2024',
                      Colors.orange[100]!,
                      Colors.orange,
                    ),
                    _createNotification(
                      'Thông báo khoa',
                      'Thông tin động học\nphí học kì 6 của\nkhoa...',
                      '24/06/2024',
                      Colors.orange[100]!,
                      Colors.orange,
                    ),
                  ]),

                  SizedBox(height: 20),

                  _buildNotificationSection('Thông báo giáo viên', Colors.red, [
                    _createNotification(
                      'Thông báo giáo viên',
                      'Thông tin động học\nphí học kì 6 của\nkhoa...',
                      '24/06/2024',
                      Colors.red[100]!,
                      Colors.red,
                    ),
                    _createNotification(
                      'Thông báo giáo viên',
                      'Thông tin động học\nphí học kì 6 của\nkhoa...',
                      '24/06/2024',
                      Colors.red[100]!,
                      Colors.red,
                    ),
                  ]),

                  SizedBox(height: 20),

                  _buildNotificationSection('Thông báo lớp', Colors.green, [
                    _createNotification(
                      'Thông báo lớp',
                      'Thông tin động học\nphí học kì 6 của\nkhoa...',
                      '21/06/2024',
                      Colors.green[100]!,
                      Colors.green,
                    ),
                    _createNotification(
                      'Thông báo lớp',
                      'Thông tin động học\nphí học kì 6 của\nkhoa...',
                      '24/06/2024',
                      Colors.green[100]!,
                      Colors.green,
                    ),
                  ]),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildFilterTabs() {
    final filters = ['Tất cả', 'Khoa', 'Lớp', 'GV'];

    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: filters.map((filter) {
          final isSelected = selectedFilter == filter;
          return Padding(
            padding: EdgeInsets.only(right: 8),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selectedFilter = filter;
                });
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: isSelected ? Colors.blue[600] : Colors.grey[200],
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isSelected ? Colors.blue[600]! : Colors.grey[300]!,
                  ),
                ),
                child: Text(
                  filter,
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.grey[700],
                    fontSize: 14,
                    fontWeight: isSelected
                        ? FontWeight.w600
                        : FontWeight.normal,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildNotificationSection(
    String title,
    Color color,
    List<Widget> notifications,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 12),
        Row(children: notifications),
      ],
    );
  }

  Widget _createNotification(
    String title,
    String content,
    String date,
    Color bgColor,
    Color? buttonColor,
  ) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(right: 8),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 8),
            Text(
              content,
              style: TextStyle(
                fontSize: 12,
                color: Colors.black54,
                height: 1.3,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Ngày đăng: $date',
              style: TextStyle(fontSize: 10, color: Colors.grey[600]),
            ),
            SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NotificationDetailPageNew(
                        title: title,
                        content: content,
                        date: date,
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: buttonColor,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 8),
                ),
                child: Text('Xem', style: TextStyle(fontSize: 12)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.white,
      selectedItemColor: Colors.blue[600],
      unselectedItemColor: Colors.grey[500],
      currentIndex: _selectedIndex,
      onTap: (index) {
        setState(() {
          _selectedIndex = index;
        });
      },
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.assignment), label: 'Học tập'),
        BottomNavigationBarItem(
          icon: Icon(Icons.notifications),
          label: 'Thông báo',
        ),
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Trang chủ'),
        BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Tìm kiếm'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Cá nhân'),
      ],
    );
  }
}

class NotificationApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Admin Notifications',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: NotificationPage(),
    );
  }
}
