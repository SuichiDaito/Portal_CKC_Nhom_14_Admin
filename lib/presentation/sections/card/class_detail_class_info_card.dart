import 'package:flutter/material.dart';

class ClassInfoCard extends StatelessWidget {
  final String className;
  final int studentCount;
  final String secretaryName;
  final String teacherName;
  final void Function(String) onSelectSecretary; // thay vì VoidCallback

  const ClassInfoCard({
    super.key,
    required this.className,
    required this.studentCount,
    required this.secretaryName,
    required this.teacherName,
    required this.onSelectSecretary,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: const LinearGradient(
            colors: [Color(0xFF1976D2), Color(0xFF42A5F5)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Thông Tin Lớp Chủ Nhiệm',
              style: TextStyle(color: Colors.white70, fontSize: 14),
            ),
            const SizedBox(height: 12),
            _buildInfoRow('Tên lớp:', className),
            const SizedBox(height: 6),
            _buildInfoRow('Sĩ số:', '$studentCount'),
            const SizedBox(height: 6),
            _buildInfoRow('Thư ký:', secretaryName),
            const SizedBox(height: 6),
            _buildInfoRow('GVCN:', teacherName),
            const SizedBox(height: 16),
            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  _showSecretarySelectionDialog(context);
                },
                icon: const Icon(Icons.how_to_vote, color: Colors.white),
                label: const Text(
                  'Bầu lại Thư ký',
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white.withOpacity(0.2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(color: Colors.white),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  void _showSecretarySelectionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Chọn Thư ký mới'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text('Nguyễn Văn A'),
              onTap: () {
                Navigator.pop(context);
                onSelectSecretary('2012345'); // ID mới của thư ký
              },
            ),
            ListTile(
              title: const Text('Trần Thị B'),
              onTap: () {
                Navigator.pop(context);
                onSelectSecretary('2012346');
              },
            ),
          ],
        ),
      ),
    );
  }
}
