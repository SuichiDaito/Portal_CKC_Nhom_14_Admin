import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:portal_ckc/api/model/admin_lop.dart';
import 'package:portal_ckc/bloc/bloc_event_state/bien_bang_shcn_bloc.dart';
import 'package:portal_ckc/bloc/event/bien_bang_shcn_event.dart';

import 'package:portal_ckc/presentation/sections/card/class_management_card.dart';

void showClassMeetingListDialog(
  BuildContext context,
  List<Lop> classList,
  Function(Lop) onTapClass,
) {
  showDialog(
    context: context,
    builder: (context) => Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        width: double.maxFinite,
        height: 400,
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Chi Tiết Danh Sách Lớp',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1976D2),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: classList.length,
                itemBuilder: (context, index) {
                  final classInfo = classList[index];
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundColor: const Color(0xFF1976D2),
                      child: Text(
                        classInfo.tenLop.substring(4, 6),
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    title: Text(
                      classInfo.tenLop,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text('${classInfo.siSo} sinh viên '),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () async {
                      Navigator.pop(context); // đóng dialog
                      final result = await context.push(
                        '/admin/meeting_minutes_admin',
                        extra: classInfo,
                      );

                      // Nếu quay lại từ chi tiết → reload
                      if (result == 'refresh') {
                        context.read<BienBangShcnBloc>().add(
                          FetchBienBan(classInfo.id),
                        );
                      }
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Đóng'),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}

void showClassDetailsDialog(BuildContext context, Lop classInfo) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(
        'Thông tin lớp ${classInfo.tenLop}',
        style: const TextStyle(color: Color(0xFF1976D2)),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDetailRow('Tên lớp:', classInfo.tenLop),
          _buildDetailRow('Sĩ số:', '${classInfo.siSo} sinh viên'),
          _buildDetailRow('Khóa:', classInfo.nienKhoa.tenNienKhoa),
        ],
      ),
      actions: [
        TextButton(
          child: const Text('Xem Chi Tiết'),
          onPressed: () {
            Navigator.pop(context);
            context.push(
              '/admin/class_detail_admin',
              extra: classInfo,
            ); // lop là đối tượng Lop
          },
        ),
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Đóng'),
        ),
      ],
    ),
  );
}

Widget _buildDetailRow(String label, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      children: [
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.grey,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(child: Text(value)),
      ],
    ),
  );
}
