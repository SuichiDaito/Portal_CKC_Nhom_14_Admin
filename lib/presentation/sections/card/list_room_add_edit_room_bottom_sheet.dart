import 'package:flutter/material.dart';
import 'package:portal_ckc/presentation/sections/button/button_custom_button.dart';
import 'package:portal_ckc/presentation/sections/card/room_list_item.dart';
import 'package:portal_ckc/presentation/sections/card/schedule_management_dropdown_item.dart';
import 'package:portal_ckc/presentation/sections/card/schedule_management_dropdown_selector.dart';

class AddEditRoomBottomSheet extends StatefulWidget {
  final Room? roomToEdit; // Null nếu là thêm mới, có giá trị nếu là chỉnh sửa
  final Function(Room) onSave;

  const AddEditRoomBottomSheet({
    Key? key,
    this.roomToEdit,
    required this.onSave,
  }) : super(key: key);

  @override
  _AddEditRoomBottomSheetState createState() => _AddEditRoomBottomSheetState();
}

class _AddEditRoomBottomSheetState extends State<AddEditRoomBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _capacityController;
  late RoomType _selectedType;
  late RoomStatus _selectedStatus;

  late List<DropdownItem> _roomTypeOptions;
  late List<DropdownItem> _roomStatusOptions;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(
      text: widget.roomToEdit?.name ?? '',
    );
    _capacityController = TextEditingController(
      text: widget.roomToEdit?.capacity.toString() ?? '',
    );
    _selectedType = widget.roomToEdit?.type ?? RoomType.lectureHall;
    _selectedStatus = widget.roomToEdit?.status ?? RoomStatus.available;

    // ✅ Khởi tạo danh sách 1 lần
    _roomTypeOptions = _getRoomTypeOptions();
    _roomStatusOptions = _getRoomStatusOptions();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _capacityController.dispose();
    super.dispose();
  }

  List<DropdownItem> _getRoomTypeOptions() {
    return RoomType.values.map((type) {
      String label;
      switch (type) {
        case RoomType.lectureHall:
          label = 'Phòng học lý thuyết';
          break;
        case RoomType.laboratory:
          label = 'Phòng thực hành';
          break;
        case RoomType.meetingRoom:
          label = 'Phòng họp';
          break;
        case RoomType.other:
          label = 'Khác';
          break;
      }
      return DropdownItem(
        value: type.toString(),
        label: label,
        icon: Icons.room,
      );
    }).toList();
  }

  List<DropdownItem> _getRoomStatusOptions() {
    return RoomStatus.values.map((status) {
      String label;
      switch (status) {
        case RoomStatus.available:
          label = 'Đang hoạt động';
          break;
        case RoomStatus.inUse:
          label = 'Tạm khóa';
          break;
        case RoomStatus.maintenance:
          label = 'Đã khóa';
          break;
      }
      return DropdownItem(
        value: status.toString(),
        label: label,
        icon: Icons.keyboard_option_key,
      );
    }).toList();
  }

  void _saveRoom() {
    if (_formKey.currentState!.validate()) {
      final String name = _nameController.text.trim();
      final int? capacity = int.tryParse(_capacityController.text.trim());

      if (capacity == null || capacity <= 0) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Sức chứa phải là một số dương.')),
        );
        return;
      }

      Room newRoom;
      if (widget.roomToEdit == null) {
        newRoom = Room(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          name: name,
          capacity: capacity,
          type: _selectedType,
          status: _selectedStatus,
        );
      } else {
        newRoom = widget.roomToEdit!.copyWith(
          name: name,
          capacity: capacity,
          type: _selectedType,
          status: _selectedStatus,
        );
      }

      widget.onSave(newRoom);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white, // ✅ Nền xanh
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      padding: EdgeInsets.only(
        top: 20,
        left: 16,
        right: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom + 16,
      ),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Theme(
            data: Theme.of(context).copyWith(
              inputDecorationTheme: InputDecorationTheme(
                labelStyle: const TextStyle(color: Colors.black), // label trắng
                border: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.black),
                  borderRadius: BorderRadius.circular(8),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.blue,
                  ), // viền trắng khi chưa focus
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.blue,
                  ), // viền trắng khi focus
                  borderRadius: BorderRadius.circular(8),
                ),
                prefixIconColor: Colors.blue,
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.roomToEdit == null
                      ? 'Thêm phòng mới'
                      : 'Sửa thông tin phòng',
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue, // ✅ chữ trắng
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _nameController,
                  style: const TextStyle(color: Colors.black), // text trắng
                  decoration: const InputDecoration(
                    labelText: 'Tên phòng',
                    prefixIcon: Icon(Icons.meeting_room),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Vui lòng nhập tên phòng.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 32),
                TextFormField(
                  controller: _capacityController,
                  keyboardType: TextInputType.number,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    labelText: 'Sức chứa',
                    prefixIcon: Icon(Icons.people),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Vui lòng nhập sức chứa.';
                    }
                    if (int.tryParse(value.trim()) == null ||
                        int.parse(value.trim()) <= 0) {
                      return 'Sức chứa phải là một số nguyên dương.';
                    }
                    return null;
                  },
                ),
                DropdownSelector(
                  label: 'Loại phòng',
                  selectedItem: _roomTypeOptions.firstWhere(
                    (item) => item.value == _selectedType.toString(),
                  ),
                  items: _roomTypeOptions,
                  onChanged: (item) {
                    if (item != null) {
                      setState(() {
                        _selectedType = RoomType.values.firstWhere(
                          (e) => e.toString() == item.value,
                        );
                      });
                    }
                  },
                ),
                DropdownSelector(
                  label: 'Trạng thái',
                  selectedItem: _roomStatusOptions.firstWhere(
                    (item) => item.value == _selectedStatus.toString(),
                  ),
                  items: _roomStatusOptions,
                  onChanged: (item) {
                    if (item != null) {
                      setState(() {
                        _selectedStatus = RoomStatus.values.firstWhere(
                          (e) => e.toString() == item.value,
                        );
                      });
                    }
                  },
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CustomButton(
                      text: 'Quay lại',
                      onPressed: () => Navigator.pop(context),
                      backgroundColor: Colors.blue,
                      textColor: Colors.white,
                    ),
                    const SizedBox(width: 12),
                    CustomButton(
                      text: widget.roomToEdit == null ? 'Thêm' : 'Cập nhật',
                      onPressed: _saveRoom,
                      backgroundColor: Colors.cyan,
                      textColor: Colors.white,
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
}
