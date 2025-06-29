import 'package:flutter/material.dart';
import '../../../api/model/admin_phong.dart';
import 'package:portal_ckc/presentation/sections/card/schedule_management_dropdown_selector.dart';
import 'package:portal_ckc/presentation/sections/card/schedule_management_dropdown_item.dart';
import 'package:portal_ckc/presentation/sections/button/button_custom_button.dart';

class AddEditRoomBottomSheet extends StatefulWidget {
  final Room? roomToEdit;
  final Function(Room) onSave;

  const AddEditRoomBottomSheet({
    super.key,
    this.roomToEdit,
    required this.onSave,
  });

  @override
  State<AddEditRoomBottomSheet> createState() => _AddEditRoomBottomSheetState();
}

class _AddEditRoomBottomSheetState extends State<AddEditRoomBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _tenController;
  late TextEditingController _soLuongController;
  late int _loaiPhong;

  final List<DropdownItem> _roomTypes = [
    DropdownItem(value: '1', label: 'Phòng học lý thuyết', icon: Icons.school),
    DropdownItem(value: '2', label: 'Phòng thực hành', icon: Icons.computer),
  ];

  @override
  void initState() {
    super.initState();
    _tenController = TextEditingController(text: widget.roomToEdit?.ten ?? '');
    _soLuongController = TextEditingController(
      text: widget.roomToEdit?.soLuong.toString() ?? '',
    );
    _loaiPhong = widget.roomToEdit?.loaiPhong ?? 1;
  }

  @override
  void dispose() {
    _tenController.dispose();
    _soLuongController.dispose();
    super.dispose();
  }

  void _saveRoom() {
    if (_formKey.currentState!.validate()) {
      final String ten = _tenController.text.trim();
      final int? soLuong = int.tryParse(_soLuongController.text.trim());

      if (soLuong == null || soLuong <= 0) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Sức chứa phải là số nguyên dương')),
        );
        return;
      }

      final room = Room(
        id: widget.roomToEdit?.id ?? -1, // id sẽ được backend tạo nếu -1
        ten: ten,
        soLuong: soLuong,
        loaiPhong: _loaiPhong,
      );

      widget.onSave(room);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.roomToEdit == null
                    ? 'Thêm phòng mới'
                    : 'Sửa thông tin phòng',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              Divider(),
              const SizedBox(height: 20),
              TextFormField(
                controller: _tenController,
                decoration: const InputDecoration(
                  labelText: 'Tên phòng',
                  prefixIcon: Icon(Icons.meeting_room),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Vui lòng nhập tên phòng';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _soLuongController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Sức chứa',
                  prefixIcon: Icon(Icons.people),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Vui lòng nhập sức chứa';
                  }
                  if (int.tryParse(value.trim()) == null ||
                      int.parse(value.trim()) <= 0) {
                    return 'Sức chứa phải là số nguyên dương';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              DropdownSelector(
                label: 'Loại phòng',
                selectedItem: _roomTypes.firstWhere(
                  (item) => item.value == _loaiPhong.toString(),
                ),
                items: _roomTypes,
                onChanged: (item) {
                  if (item != null) {
                    setState(() {
                      _loaiPhong = int.parse(item.value);
                    });
                  }
                },
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CustomButton(
                    text: 'Hủy',
                    onPressed: () => Navigator.pop(context),
                    backgroundColor: Colors.grey,
                    textColor: Colors.white,
                  ),
                  const SizedBox(width: 12),
                  CustomButton(
                    text: widget.roomToEdit == null ? 'Thêm' : 'Cập nhật',
                    onPressed: _saveRoom,
                    backgroundColor: Colors.blue,
                    textColor: Colors.white,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
