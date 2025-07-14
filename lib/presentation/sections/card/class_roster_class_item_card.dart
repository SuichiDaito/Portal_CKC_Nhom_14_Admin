import 'package:flutter/material.dart';
import 'package:portal_ckc/api/model/admin_lop_hoc_phan.dart';

class ClassItemCard extends StatelessWidget {
  final LopHocPhan classModel;
  final VoidCallback onTap;

  const ClassItemCard({Key? key, required this.classModel, required this.onTap})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String className = classModel.lop.tenLop ?? 'Chưa rõ';
    final String subject = classModel.tenHocPhan;
    final String status = _getTrangThaiText(classModel.trangThaiNopBangDiem);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.blue[50],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(
                        Icons.class_,
                        color: Colors.blue[600],
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            className,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            subject,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    _buildStatusBadge(status),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    _buildDetailItem(
                      Icons.people_outline,
                      '${classModel.soLuongDangKy} sinh viên',
                      Colors.blue[600]!,
                    ),
                    const SizedBox(width: 16),
                    _buildDetailItem(
                      classModel.loaiMon == 0
                          ? Icons.menu_book_outlined
                          : Icons.handyman_outlined,
                      classModel.loaiMon == 0 ? 'Lý thuyết' : 'Thực hành',
                      Colors.deepOrange[600]!,
                    ),
                  ],
                ),

                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton.icon(
                      onPressed: onTap,
                      icon: Icon(
                        Icons.visibility_outlined,
                        size: 16,
                        color: Colors.blue[600],
                      ),
                      label: Text(
                        'Xem chi tiết',
                        style: TextStyle(
                          color: Colors.blue[600],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _getTrangThaiText(int? TrangThaiNopDiem) {
    switch (TrangThaiNopDiem) {
      case 0:
        return 'Đang diễn ra';
      case 1:
        return 'Đang diễn ra';
      case 2:
        return 'Đang diễn ra';
      case 3:
        return 'Đã nộp điểm';
      default:
        return 'Không rõ';
    }
  }

  Widget _buildStatusBadge(String status) {
    Color backgroundColor;
    Color textColor;

    switch (status.toLowerCase()) {
      case 'đang diễn ra':
        backgroundColor = Colors.green[100]!;
        textColor = Colors.green[700]!;
        break;
      case 'đã nộp điểm':
        backgroundColor = const Color.fromARGB(255, 94, 173, 215)!;
        textColor = Colors.white;
        break;
      case 'chưa diễn ra':
        backgroundColor = Colors.blue[100]!;
        textColor = Colors.blue[700]!;
        break;
      default:
        backgroundColor = Colors.orange[100]!;
        textColor = Colors.orange[700]!;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        status,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: textColor,
        ),
      ),
    );
  }

  Widget _buildDetailItem(IconData icon, String text, Color color) {
    return Expanded(
      child: Row(
        children: [
          Icon(icon, size: 16, color: color),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              text,
              style: TextStyle(fontSize: 13, color: Colors.grey[700]),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
