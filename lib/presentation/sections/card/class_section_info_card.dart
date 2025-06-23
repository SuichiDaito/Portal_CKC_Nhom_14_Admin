import 'package:flutter/material.dart';

class ClassSectionInfoCard extends StatefulWidget {
  final String tenLop;
  final String tenHocPhan;
  final int loaiLopHocPhan; // 0 = Thực hành, 1 = Lý thuyết
  final String tenChuongTrinhDaoTao;
  final void Function(bool isEditing)? onEditChanged;

  const ClassSectionInfoCard({
    super.key,
    required this.tenLop,
    required this.tenHocPhan,
    required this.loaiLopHocPhan,
    required this.tenChuongTrinhDaoTao,
    this.onEditChanged,
  });

  @override
  State<ClassSectionInfoCard> createState() => _ClassSectionInfoCardState();
}

class _ClassSectionInfoCardState extends State<ClassSectionInfoCard> {
  bool isEditing = false;

  String getLoaiLopText(int loai) {
    switch (loai) {
      case 0:
        return 'Thực hành';
      case 1:
        return 'Lý thuyết';
      default:
        return 'Không xác định';
    }
  }

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
              'Thông Tin Lớp Học Phần',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            _buildInfoRow(Icons.class_, 'Tên lớp:', widget.tenLop),
            const SizedBox(height: 6),
            _buildInfoRow(Icons.book, 'Tên học phần:', widget.tenHocPhan),
            const SizedBox(height: 6),
            _buildInfoRow(
              Icons.category,
              'Loại lớp:',
              getLoaiLopText(widget.loaiLopHocPhan),
            ),
            const SizedBox(height: 6),
            _buildInfoRow(
              Icons.school,
              'Chương trình:',
              widget.tenChuongTrinhDaoTao,
            ),
            const SizedBox(height: 16),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.blue,
                  backgroundColor: Colors.white,
                ),
                onPressed: () {
                  setState(() => isEditing = !isEditing);
                  widget.onEditChanged?.call(isEditing);
                },
                icon: Icon(isEditing ? Icons.save : Icons.edit),
                label: Text(isEditing ? 'Lưu' : 'Sửa'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 18, color: Colors.white),
        const SizedBox(width: 6),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(width: 6),
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
}
