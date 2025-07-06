import 'package:flutter/material.dart';
import 'package:portal_ckc/api/model/admin_danh_sach_lop.dart';

class ClassInfoCard extends StatelessWidget {
  final String className;
  final int studentCount;
  final String secretaryName;
  final String teacherName;
  final List<StudentWithRole> studentList;
  final void Function(int) onSelectSecretary;

  const ClassInfoCard({
    super.key,
    required this.className,
    required this.studentCount,
    required this.secretaryName,
    required this.teacherName,
    required this.studentList,
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
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
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
    final selectableStudents = studentList
        .where((sv) => sv.sinhVien.trangThai == 0)
        .toList();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white, // Nền trắng
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Center(
          child: Text(
            'Chọn Thư ký mới',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Color(0xFF1976D2),
            ),
            textAlign: TextAlign.center,
          ),
        ),
        content: SizedBox(
          height: 300,
          width: 300,
          child: ListView.separated(
            itemCount: selectableStudents.length,
            separatorBuilder: (_, __) => const Divider(height: 8),
            itemBuilder: (context, index) {
              final sv = selectableStudents[index];
              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: const Color(0xFF1976D2),
                  child: Text(
                    sv.sinhVien.hoSo.hoTen.substring(0, 1).toUpperCase(),
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                title: Text(
                  sv.sinhVien.hoSo.hoTen,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                subtitle: Text("MSSV: ${sv.sinhVien.maSv}"),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                tileColor: Colors.grey[100],
                onTap: () {
                  Navigator.pop(context);
                  onSelectSecretary(sv.sinhVien.id);
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
