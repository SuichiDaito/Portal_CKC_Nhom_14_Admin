import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:portal_ckc/presentation/pages/page_notification_detail_admin.dart';
import 'package:portal_ckc/presentation/sections/notifications_home_admin.dart';

// Main Notifications Page
class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  String selectedFilter = 'Tất cả';

  @override
  Widget build(BuildContext context) {
    return Column(
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
                  NotificationsHomeAdmin(
                    typeNotification: 'Thông báo khoa',
                    contentNotification: 'Thông báo mới nhất',
                    date: '24/06/2025',
                  ),
               
                SizedBox(height: 20),
                NotificationsHomeAdmin(
                  typeNotification: 'Thông báo giáo viên',
                  contentNotification: 'Thông báo mới nhất',
                  date: '24/06/2025',
                ),
                SizedBox(height: 20),
                NotificationsHomeAdmin(
                  typeNotification: 'Thông báo lớp',
                  contentNotification: 'Thông báo mới nhất',
                  date: '24/06/2025',
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFilterTabs() {
    final filters = ['Tất cả', 'Khoa', 'Lớp', 'Giảng viên'];
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: filters.map((filter) {
          final isSelected = selectedFilter == filter;
          return Padding(
            padding: EdgeInsets.only(right: 12),
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
}
