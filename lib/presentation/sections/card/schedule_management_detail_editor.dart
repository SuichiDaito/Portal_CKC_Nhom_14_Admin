import 'package:flutter/material.dart';
import 'package:portal_ckc/presentation/sections/button/button_custom_button.dart';
import 'package:portal_ckc/presentation/sections/card/schedule_management_class_info_display.dart';
import 'package:portal_ckc/presentation/sections/card/schedule_management_day_time_picker.dart';
import 'package:portal_ckc/presentation/sections/card/schedule_management_detail_model.dart';

class ScheduleDetailEditor extends StatefulWidget {
  final ClassSchedule classSchedule;
  final ValueChanged<ScheduleDetail> onSave;

  const ScheduleDetailEditor({
    Key? key,
    required this.classSchedule,
    required this.onSave,
  }) : super(key: key);

  @override
  _ScheduleDetailEditorState createState() => _ScheduleDetailEditorState();
}

class _ScheduleDetailEditorState extends State<ScheduleDetailEditor> {
  late ScheduleDetail _currentDetails;
  late TextEditingController _roomController;
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    // Tạo bản sao để chỉnh sửa, không ảnh hưởng trực tiếp đến dữ liệu gốc
    _currentDetails = widget.classSchedule.details.copyWith();
    _roomController = TextEditingController(text: _currentDetails.room);
  }

  @override
  void dispose() {
    _roomController.dispose();
    super.dispose();
  }

  void _toggleEditMode() {
    setState(() {
      _isEditing = !_isEditing;
      if (!_isEditing) {
        // Reset về trạng thái ban đầu nếu hủy chỉnh sửa (có thể thêm confirm dialog)
        _currentDetails = widget.classSchedule.details.copyWith();
        _roomController.text = _currentDetails.room;
      }
    });
  }

  void _saveChanges() {
    setState(() {
      _currentDetails.room = _roomController.text;
      widget.onSave(_currentDetails); // Truyền dữ liệu đã cập nhật lên parent
      _isEditing = false;
    });
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Đã lưu thay đổi lịch học!')));
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
      elevation: 2.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClassInfoDisplay(classSchedule: widget.classSchedule),
            const SizedBox(height: 16),
            const Text(
              'Thông tin chi tiết lịch học:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _roomController,
              enabled: _isEditing,
              decoration: InputDecoration(
                labelText: 'Phòng',
                border: const OutlineInputBorder(),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: _isEditing
                        ? Colors.blueAccent
                        : Colors.grey.shade300,
                  ),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                ),
                filled: true,
                fillColor: _isEditing ? Colors.white : Colors.grey.shade100,
              ),
            ),
            const SizedBox(height: 12),
            DayTimePicker(
              enabled: _isEditing,
              schedules: _currentDetails.schedules,
              onScheduleChanged: (schedules) {
                if (_isEditing) {
                  setState(() {
                    _currentDetails.schedules = schedules;
                  });
                }
              },
            ),

            const SizedBox(height: 16),
            Align(
              alignment: Alignment.centerRight,
              child: CustomButton(
                text: _isEditing ? 'Lưu' : 'Thay đổi',
                onPressed: () {
                  if (_isEditing) {
                    _saveChanges();
                  } else {
                    _toggleEditMode();
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
