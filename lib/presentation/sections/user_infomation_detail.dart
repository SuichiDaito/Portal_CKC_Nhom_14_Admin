import 'package:flutter/material.dart';
import 'package:portal_ckc/api/model/admin_thong_tin.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountInfoSection extends StatelessWidget {
  final User user;

  const AccountInfoSection({Key? key, required this.user}) : super(key: key);

  Future<String> getRoleName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('user_name_role') ?? "Không có chức vụ";
  }

  @override
  Widget build(BuildContext context) {
    final hoSo = user.hoSo;

    return Column(
      children: [
        // Header section
        Container(
          width: double.infinity,
          color: Colors.blue.shade50,
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.blue.shade600,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const Icon(Icons.school, color: Colors.white, size: 30),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  'Thông tin chi tiết tài khoản giảng viên',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade800,
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
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),

              // Dynamic info items
              _buildInfoItem('Mã giảng viên: GV00${user.id}'),
              _buildInfoItem('Họ và tên: ${hoSo?.hoTen ?? 'Chưa có'}'),
              _buildInfoItem(
                'Phòng/khoa: ${user.boMon?.nganhHoc?.khoa?.tenKhoa ?? "Không xác định"}',
              ),
              FutureBuilder<String>(
                future: getRoleName(),
                builder: (context, snapshot) {
                  String role = snapshot.data ?? "Đang tải...";
                  return _buildInfoItem('Chức vụ: $role');
                },
              ),
              _buildInfoItem('Ngày sinh: ${hoSo?.ngaySinh ?? 'Chưa có'}'),

              // _buildInfoItem(
              //   'Trạng thái: ${user.trangThai == 1 ? 'Đã kích hoạt' : 'Chưa kích hoạt'}',
              // ),
              const SizedBox(height: 20),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
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

  Widget _buildInfoItem(String text) {
    final parts = text.split(': ');
    final label = parts[0];
    final value = parts.length > 1 ? parts[1] : '';

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
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
              const SizedBox(width: 16),
              // Value
              Expanded(
                flex: 3,
                child: label.toLowerCase() == 'trạng thái'
                    ? Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: value.contains('kích hoạt')
                                ? Colors.green.shade500
                                : Colors.orange.shade500,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            value,
                            style: const TextStyle(
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
        Divider(color: Colors.grey.shade300, thickness: 0.5, height: 1),
      ],
    );
  }
}
