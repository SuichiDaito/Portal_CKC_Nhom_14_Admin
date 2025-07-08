import 'package:flutter/material.dart';
import 'package:portal_ckc/api/model/admin_bien_bang_shcn.dart';

class ReportDetailFixedInfoCard extends StatelessWidget {
  final bool isEditing;
  final bool canEdit;
  final VoidCallback onToggleEdit;
  final VoidCallback onApprove;
  final BienBanSHCN bienBan;

  const ReportDetailFixedInfoCard({
    super.key,
    required this.isEditing,
    required this.bienBan,
    required this.canEdit,
    required this.onToggleEdit,
    required this.onApprove,
  });

  @override
  Widget build(BuildContext context) {
    final lopName = bienBan.lop.tenLop;
    final gvcnName = bienBan.gvcn.hoSo?.hoTen ?? 'Chưa có';
    final thuKyName = bienBan.thuky.hoSo?.hoTen ?? 'Chưa có';

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
          Text('Lớp: $lopName', style: const TextStyle(color: Colors.white)),
          Text('GVCN: $gvcnName', style: const TextStyle(color: Colors.white)),
          Text(
            'Thư ký: $thuKyName',
            style: const TextStyle(color: Colors.white),
          ),
          const SizedBox(height: 16),
          if (canEdit)
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
            )
          else
            const Text(
              "Biên bản đã được duyệt.",
              style: TextStyle(
                color: Colors.white,
                fontStyle: FontStyle.italic,
              ),
            ),
        ],
      ),
    );
  }
}
