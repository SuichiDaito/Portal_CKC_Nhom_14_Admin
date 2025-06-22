import 'package:flutter/material.dart';
import 'package:portal_ckc/api/model/admin_phong.dart';

class RoomListItem extends StatelessWidget {
  final int index;
  final Room room;

  const RoomListItem({super.key, required this.index, required this.room});

  String _getRoomTypeName(int type) {
    switch (type) {
      case 1:
        return 'Phòng học lý thuyết';
      case 2:
        return 'Phòng thực hành';
      case 3:
        return 'Phòng họp';
      default:
        return 'Khác';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 2,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${room.ten}',
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
            Divider(),
            const SizedBox(height: 6),
            Text('Sức chứa: ${room.soLuong}'),
            const SizedBox(height: 4),
            Text('Loại phòng: ${_getRoomTypeName(room.loaiPhong)}'),
          ],
        ),
      ),
    );
  }
}
