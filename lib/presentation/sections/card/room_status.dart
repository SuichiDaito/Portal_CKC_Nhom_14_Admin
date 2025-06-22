import 'package:flutter/material.dart';
import 'package:portal_ckc/api/model/admin_phong.dart';
import 'package:portal_ckc/presentation/sections/button/button_custom_button.dart';
import 'package:portal_ckc/presentation/sections/card/room_list_item.dart';

class RoomStatusFilter extends StatelessWidget {
  final RoomStatus? currentFilter;
  final ValueChanged<RoomStatus?> onFilterChanged;

  const RoomStatusFilter({
    Key? key,
    required this.currentFilter,
    required this.onFilterChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildFilterButton('Tất cả', null),
            const SizedBox(width: 8),
            _buildFilterButton('Sẵn sàng', RoomStatus.available),
            const SizedBox(width: 8),
            _buildFilterButton('Đang sử dụng', RoomStatus.inUse),
            const SizedBox(width: 8),
            _buildFilterButton('Bảo trì', RoomStatus.maintenance),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterButton(String text, RoomStatus? status) {
    final bool isSelected = currentFilter == status;
    return CustomButton(
      text: text,
      onPressed: () => onFilterChanged(status),
      backgroundColor: isSelected ? Colors.blueAccent : Colors.grey.shade300,
      textColor: isSelected ? Colors.white : Colors.black87,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      borderRadius: BorderRadius.circular(20),
    );
  }
}
