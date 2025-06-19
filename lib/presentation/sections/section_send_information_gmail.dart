import 'package:flutter/material.dart';

class AccountInfoSection extends StatelessWidget {
  const AccountInfoSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Header section with user info
        Container(
          width: double.infinity,
          color: Colors.blue.shade50,
          padding: EdgeInsets.all(20),
          child: Row(
            children: [
              // Avatar
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.blue.shade600,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Icon(Icons.school, color: Colors.white, size: 30),
              ),
              SizedBox(width: 16),
              // User info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Phòng Đào Tạo',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade800,
                      ),
                    ),
                    SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(
                          Icons.access_time,
                          size: 14,
                          color: Colors.grey.shade600,
                        ),
                        SizedBox(width: 4),
                        Text(
                          '14/06/2025',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // Status badge
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.orange.shade100,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'Quan trọng',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.orange.shade700,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),

        // Content section
        Container(
          width: double.infinity,
          color: Colors.white,
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              Text(
                'Thông tin chi tiết tài khoản sinh viên',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade800,
                  height: 1.3,
                ),
              ),

              SizedBox(height: 20),

              // Greeting text
              Text(
                'Kính gửi sinh viên thân mến,',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey.shade700,
                  height: 1.4,
                ),
              ),

              SizedBox(height: 16),

              // Main content
              Text(
                'Phòng Đào tạo thông báo thông tin tài khoản sinh viên của bạn đã được cập nhật và kích hoạt thành công. Dưới đây là các thông tin chi tiết:',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey.shade700,
                  height: 1.5,
                ),
              ),

              SizedBox(height: 20),

              // Student information details
              _buildInfoItem('• Mã sinh viên: 0306221404'),
              _buildInfoItem('• Họ và tên: Trần Thị B'),
              _buildInfoItem('• Lớp: CDTH 2200E'),
              _buildInfoItem('• Chức vụ: Sinh viên'),
              _buildInfoItem('• Ngày sinh: 29/08/2004'),
              _buildInfoItem('• Trạng thái: Đã kích hoạt'),

              SizedBox(height: 20),

              // Additional note
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.blue.shade200, width: 1),
                ),
                child: Text(
                  'Lưu ý: Vui lòng bảo mật thông tin tài khoản và liên hệ Phòng Đào tạo nếu có bất kỳ thắc mắc nào.',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.blue.shade800,
                    fontStyle: FontStyle.italic,
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Helper method to build info items
  Widget _buildInfoItem(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 15,
          color: Colors.grey.shade700,
          height: 1.4,
        ),
      ),
    );
  }
}
