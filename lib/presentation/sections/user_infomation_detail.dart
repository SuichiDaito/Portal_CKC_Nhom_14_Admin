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
                      'Thông tin chi tiết tài khoản sinh viên',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade800,
                      ),
                    ),
                    SizedBox(height: 4),
                  ],
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
              SizedBox(height: 20),

              // Student information details
              _buildInfoItem('Mã sinh viên: 0306221404'),
              _buildInfoItem('Họ và tên: Trần Thị B'),
              _buildInfoItem('Lớp: CDTH 2200E'),
              _buildInfoItem('Chức vụ: Sinh viên'),
              _buildInfoItem('Ngày sinh: 29/08/2004'),
              _buildInfoItem('Trạng thái: Đã kích hoạt'),

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
    // Tách label và value từ text
    List<String> parts = text.split(': ');
    String label = parts[0].replaceAll('• ', '');
    String value = parts.length > 1 ? parts[1] : '';

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Label
              Expanded(
                flex: 2,
                child: Text(
                  label,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey.shade600,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(width: 16),
              // Value
              Expanded(
                flex: 3,
                child: label.toLowerCase() == 'trạng thái'
                    ? Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.green.shade500,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            'Hoạt động',
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      )
                    : Text(
                        value,
                        textAlign: TextAlign.end,
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey.shade800,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
              ),
            ],
          ),
        ),
        // Divider
        Divider(color: Colors.grey.shade300, thickness: 0.5, height: 1),
      ],
    );
  }
}
