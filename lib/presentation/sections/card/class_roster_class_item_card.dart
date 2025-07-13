<<<<<<< HEAD
import 'package:flutter/material.dart';
import 'package:portal_ckc/api/model/admin_lop_hoc_phan.dart';

class ClassItemCard extends StatelessWidget {
  final LopHocPhan classModel;
=======
// widgets/class_item_card.dart
import 'package:flutter/material.dart';
import 'package:portal_ckc/presentation/sections/card/class_roster_teacher_info_card.dart';

class ClassItemCard extends StatelessWidget {
  final ClassModel classModel;
>>>>>>> main
  final VoidCallback onTap;

  const ClassItemCard({Key? key, required this.classModel, required this.onTap})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
    final String className = classModel.lop.tenLop ?? 'Chưa rõ';
    final String subject = classModel.tenHocPhan;
    final String status = _getTrangThaiText(classModel.trangThaiNopBangDiem);

=======
>>>>>>> main
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
<<<<<<< HEAD
                Row(
                  children: [
=======
                // Header Row
                Row(
                  children: [
                    // Class Icon
>>>>>>> main
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
<<<<<<< HEAD
=======

                    // Class Name & Subject
>>>>>>> main
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
<<<<<<< HEAD
                            className,
=======
                            classModel.className,
>>>>>>> main
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
<<<<<<< HEAD
                            subject,
=======
                            classModel.subject,
>>>>>>> main
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
<<<<<<< HEAD
                    _buildStatusBadge(status),
                  ],
                ),
                const SizedBox(height: 12),
=======

                    // Status Badge
                    _buildStatusBadge(classModel.status),
                  ],
                ),

                const SizedBox(height: 12),

                // Class Details
>>>>>>> main
                Row(
                  children: [
                    _buildDetailItem(
                      Icons.people_outline,
<<<<<<< HEAD
                      '${classModel.soLuongDangKy} sinh viên',
=======
                      '${classModel.studentCount} SV',
>>>>>>> main
                      Colors.blue[600]!,
                    ),
                    const SizedBox(width: 16),
                    _buildDetailItem(
<<<<<<< HEAD
                      classModel.loaiMon == 0
                          ? Icons
                                .menu_book_outlined // Icon cho Lý thuyết
                          : Icons.handyman_outlined, // Icon cho Thực hành
                      classModel.loaiMon == 0 ? 'Lý thuyết' : 'Thực hành',
                      Colors.deepOrange[600]!,
=======
                      Icons.schedule_outlined,
                      classModel.schedule,
                      Colors.green[600]!,
                    ),
                  ],
                ),

                const SizedBox(height: 8),

                Row(
                  children: [
                    _buildDetailItem(
                      Icons.location_on_outlined,
                      classModel.room,
                      Colors.orange[600]!,
                    ),
                    const SizedBox(width: 16),
                    _buildDetailItem(
                      Icons.calendar_today_outlined,
                      classModel.semester,
                      Colors.purple[600]!,
>>>>>>> main
                    ),
                  ],
                ),

                const SizedBox(height: 12),
<<<<<<< HEAD
=======

                // Action Button
>>>>>>> main
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
<<<<<<< HEAD
=======
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
>>>>>>> main
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

<<<<<<< HEAD
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

=======
>>>>>>> main
  Widget _buildStatusBadge(String status) {
    Color backgroundColor;
    Color textColor;

    switch (status.toLowerCase()) {
      case 'đang diễn ra':
<<<<<<< HEAD
        backgroundColor = Colors.green[100]!;
        textColor = Colors.green[700]!;
        break;
      case 'đã nộp điểm':
        backgroundColor = const Color.fromARGB(255, 94, 173, 215)!;
        textColor = Colors.white;
        break;
      case 'chưa diễn ra':
=======
      case 'active':
        backgroundColor = Colors.green[100]!;
        textColor = Colors.green[700]!;
        break;
      case 'đã kết thúc':
      case 'completed':
        backgroundColor = Colors.grey[100]!;
        textColor = Colors.grey[700]!;
        break;
      case 'sắp diễn ra':
      case 'upcoming':
>>>>>>> main
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
