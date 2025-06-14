import 'package:flutter/material.dart';

class AccountInfoSection extends StatelessWidget {
  const AccountInfoSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.1),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Content
          Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                _buildInfoRow(
                  label: 'Tài khoản',
                  value: '0306221404',
                  icon: Icons.person,
                  iconColor: Colors.blue,
                ),
                Divider(),
                const SizedBox(height: 2),
                _buildInfoRow(
                  label: 'Tên sinh viên',
                  value: 'Trần Thị B',
                  icon: Icons.badge,
                  iconColor: Colors.green,
                ),
                Divider(),
                const SizedBox(height: 2),
                _buildInfoRow(
                  label: 'Lớp',
                  value: 'CDTH 2200E',
                  icon: Icons.school,
                  iconColor: Colors.orange,
                ),
                Divider(),
                const SizedBox(height: 2),
                _buildInfoRow(
                  label: 'MSSV',
                  value: '0306221404',
                  icon: Icons.confirmation_number,
                  iconColor: Colors.red,
                  isHighlight: true,
                ),
                Divider(),
                const SizedBox(height: 2),
                _buildInfoRow(
                  label: 'Ngày sinh',
                  value: '29/08/2004',
                  icon: Icons.cake,
                  iconColor: Colors.purple,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow({
    required String label,
    required String value,
    required IconData icon,
    required Color iconColor,
    bool isHighlight = false,
  }) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          // Icon
          const SizedBox(width: 5),
          // Label and Value
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  value,
                  style: TextStyle(
                    color: isHighlight ? Colors.red : Colors.black87,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Widget để sử dụng trong page
// class AccountInfoPage extends StatelessWidget {
//   const AccountInfoPage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[50],
//       appBar: AppBar(
//         elevation: 0,
//         backgroundColor: Colors.transparent,
//         title: const Text(
//           'Thông tin sinh viên',
//           style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w600),
//         ),
//         centerTitle: true,
//         leading: IconButton(
//           onPressed: () => Navigator.pop(context),
//           icon: const Icon(Icons.arrow_back_ios, color: Colors.blue),
//         ),
//       ),
//       body: const SingleChildScrollView(
//         child: Column(children: [AccountInfoSection(), SizedBox(height: 20)]),
//       ),
//     );
//   }
// }
