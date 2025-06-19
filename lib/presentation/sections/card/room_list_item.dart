import 'package:flutter/material.dart';
import 'package:portal_ckc/presentation/sections/button/button_custom_button.dart';
import 'package:portal_ckc/presentation/sections/card/schedule_management_dropdown_item.dart';
import 'package:portal_ckc/presentation/sections/card/schedule_management_dropdown_selector.dart';

enum RoomType { lectureHall, laboratory, meetingRoom, other }

enum RoomStatus { available, inUse, maintenance }

class Room {
  final String id; // ID duy nhất của phòng
  String name;
  int capacity; // Sức chứa
  RoomType type;
  RoomStatus status;

  Room({
    required this.id,
    required this.name,
    required this.capacity,
    required this.type,
    required this.status,
  });

  // Helper to create a copy for editing
  Room copyWith({
    String? id,
    String? name,
    int? capacity,
    RoomType? type,
    RoomStatus? status,
  }) {
    return Room(
      id: id ?? this.id,
      name: name ?? this.name,
      capacity: capacity ?? this.capacity,
      type: type ?? this.type,
      status: status ?? this.status,
    );
  }
}

class RoomListItem extends StatefulWidget {
  final int index;
  final Room room;
  final ValueChanged<Room> onUpdateStatus; // Callback khi cập nhật trạng thái

  const RoomListItem({
    Key? key,
    required this.index,
    required this.room,
    required this.onUpdateStatus,
  }) : super(key: key);

  @override
  _RoomListItemState createState() => _RoomListItemState();
}

class _RoomListItemState extends State<RoomListItem> {
  bool _isEditingStatus = false;
  late RoomStatus _selectedStatus;

  @override
  void initState() {
    super.initState();
    _selectedStatus = widget.room.status;
  }

  // Cập nhật trạng thái khi widget được rebuild với dữ liệu mới
  @override
  void didUpdateWidget(covariant RoomListItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.room.status != oldWidget.room.status) {
      _selectedStatus = widget.room.status;
      _isEditingStatus =
          false; // Tắt chế độ sửa nếu trạng thái gốc đã được cập nhật
    }
  }

  String _getRoomTypeDisplay(RoomType type) {
    switch (type) {
      case RoomType.lectureHall:
        return 'Phòng học lý thuyết';
      case RoomType.laboratory:
        return 'Phòng thí nghiệm';
      case RoomType.meetingRoom:
        return 'Phòng họp';
      case RoomType.other:
        return 'Khác';
    }
  }

  String _getRoomStatusDisplay(RoomStatus status) {
    switch (status) {
      case RoomStatus.available:
        return 'Đang trống';
      case RoomStatus.inUse:
        return 'Đang sử dụng';
      case RoomStatus.maintenance:
        return 'Đang bảo trì';
    }
  }

  Color _getStatusColor(RoomStatus status) {
    switch (status) {
      case RoomStatus.available:
        return Colors.green;
      case RoomStatus.inUse:
        return Colors.orange;
      case RoomStatus.maintenance:
        return Colors.red;
    }
  }

  List<DropdownItem> _getStatusOptions() {
    return RoomStatus.values.map((status) {
      return DropdownItem(
        value: status.toString(),
        label: _getRoomStatusDisplay(status),
        icon: _getStatusIcon(status),
      );
    }).toList();
  }

  IconData _getStatusIcon(RoomStatus status) {
    switch (status) {
      case RoomStatus.available:
        return Icons.check_circle_outline;
      case RoomStatus.inUse:
        return Icons.schedule;
      case RoomStatus.maintenance:
        return Icons.build_circle;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      elevation: 2.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${widget.index + 1}. Tên phòng: ${widget.room.name}',
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'Sức chứa: ${widget.room.capacity}',
              style: const TextStyle(fontSize: 15, color: Colors.black87),
            ),
            const SizedBox(height: 4),
            Text(
              'Loại phòng: ${_getRoomTypeDisplay(widget.room.type)}',
              style: const TextStyle(fontSize: 15, color: Colors.black87),
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                const Text(
                  'Trạng thái:',
                  style: TextStyle(fontSize: 15, color: Colors.black87),
                ),
                const SizedBox(width: 8),
                if (!_isEditingStatus)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: _getStatusColor(
                        widget.room.status,
                      ).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        color: _getStatusColor(widget.room.status),
                      ),
                    ),
                    child: Text(
                      _getRoomStatusDisplay(widget.room.status),
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: _getStatusColor(widget.room.status),
                      ),
                    ),
                  ),
                if (_isEditingStatus)
                  Expanded(
                    child: Builder(
                      builder: (context) {
                        final statusOptions =
                            _getStatusOptions(); // ✅ dùng 1 biến duy nhất
                        return DropdownSelector(
                          label: '',
                          selectedItem: statusOptions.firstWhere(
                            (item) => item.value == _selectedStatus.toString(),
                          ),
                          items: statusOptions,
                          onChanged: (item) {
                            if (item != null) {
                              setState(() {
                                _selectedStatus = RoomStatus.values.firstWhere(
                                  (e) => e.toString() == item.value,
                                );
                              });
                            }
                          },
                        );
                      },
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 12),
            Align(
              alignment: Alignment.centerRight,
              child: CustomButton(
                text: _isEditingStatus ? 'Lưu trạng thái' : 'Sửa trạng thái',
                onPressed: () {
                  if (_isEditingStatus) {
                    // Lưu trạng thái mới
                    widget.onUpdateStatus(
                      widget.room.copyWith(status: _selectedStatus),
                    );
                    setState(() {
                      _isEditingStatus = false;
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Đã cập nhật trạng thái phòng.'),
                      ),
                    );
                  } else {
                    // Chuyển sang chế độ chỉnh sửa
                    setState(() {
                      _isEditingStatus = true;
                    });
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
