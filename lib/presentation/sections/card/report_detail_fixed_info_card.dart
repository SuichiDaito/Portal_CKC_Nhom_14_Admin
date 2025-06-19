import 'package:flutter/material.dart';

class ReportDetailFixedInfoCard extends StatelessWidget {
  final bool isEditing;
  final VoidCallback onToggleEdit;
  final VoidCallback onApprove;

  const ReportDetailFixedInfoCard({
    super.key,
    required this.isEditing,
    required this.onToggleEdit,
    required this.onApprove,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: const LinearGradient(
          colors: [Color(0xFF1976D2), Color(0xFF42A5F5)],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Lớp: 22DTH3', style: TextStyle(color: Colors.white)),
          const Text(
            'GVCN: ThS. Nguyễn Văn A',
            style: TextStyle(color: Colors.white),
          ),
          const Text(
            'Bí thư: Nguyễn Thị B',
            style: TextStyle(color: Colors.white),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.cyan,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  onPressed: onToggleEdit,
                  icon: const Icon(Icons.edit),
                  label: Text(isEditing ? 'Tắt sửa' : 'Sửa'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  onPressed: onApprove,
                  icon: const Icon(Icons.check_circle),
                  label: const Text('Duyệt biên bản'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
