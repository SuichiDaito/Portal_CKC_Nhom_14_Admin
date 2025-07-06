import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:portal_ckc/api/model/admin_lich_thi.dart';
import 'package:portal_ckc/presentation/sections/button/button_custom_button.dart';
import 'package:portal_ckc/presentation/sections/card/build_infor_cart.dart';
import 'package:portal_ckc/presentation/sections/card/schedule_management_dropdown_item.dart';

class ExamScheduleCard extends StatefulWidget {
  final ExamSchedule schedule;
  final ValueChanged<ExamSchedule> onSave;
  final List<DropdownItem> lecturers;
  final List<DropdownItem> rooms;
  const ExamScheduleCard({
    Key? key,
    required this.schedule,
    required this.onSave,
    required this.lecturers,
    required this.rooms,
  }) : super(key: key);

  @override
  State<ExamScheduleCard> createState() => _ExamScheduleCardState();
}

class _ExamScheduleCardState extends State<ExamScheduleCard> {
  late ExamSchedule _currentSchedule;
  bool _isEditing = false;
  late TextEditingController _durationController;
  DropdownItem? _selectedProctor1;
  DropdownItem? _selectedProctor2;
  DropdownItem? _selectedRoom;
  DropdownItem? _selectedExamAttempt;

  final List<DropdownItem> _lecturers = [];
  late List<DropdownItem> _rooms;
  final List<DropdownItem> _examAttempts = [
    DropdownItem(value: '1', label: 'Lần 1', icon: Icons.expand_more),
    DropdownItem(value: '2', label: 'Lần 2', icon: Icons.expand_more),
  ];

  @override
  void initState() {
    super.initState();
    _rooms = widget.rooms;

    _lecturers.addAll(widget.lecturers);
    _currentSchedule = widget.schedule;
    _selectedProctor1 = DropdownItem(
      value: _currentSchedule.idGiamThi1.toString(),
      label: _currentSchedule.giamThi1?.hoSo?.hoTen ?? 'Chưa có',
      icon: Icons.people,
    );
    _selectedProctor2 = DropdownItem(
      value: _currentSchedule.idGiamThi2.toString(),
      label: _currentSchedule.giamThi2?.hoSo?.hoTen ?? 'Chưa có',
      icon: Icons.people,
    );
    _selectedRoom = DropdownItem(
      value: _currentSchedule.idPhongThi.toString(),
      label: _currentSchedule.phong?.ten ?? 'Chưa có',
      icon: Icons.room,
    );
    _selectedExamAttempt = DropdownItem(
      value: _currentSchedule.lanThi.toString(),
      label: 'Lần ${_currentSchedule.lanThi}',
      icon: Icons.numbers,
    );
    final int durationMinutes = _currentSchedule.thoiGianThi;
    final int hours = durationMinutes ~/ 60;
    final int minutes = durationMinutes % 60;
    final String formattedDuration =
        '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}';

    _durationController = TextEditingController(text: formattedDuration);
  }

  @override
  void dispose() {
    _durationController.dispose();
    super.dispose();
  }

  void _toggleEditMode() {
    setState(() => _isEditing = !_isEditing);
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateFormat('yyyy-MM-dd').parse(_currentSchedule.ngayThi),
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now().add(const Duration(days: 365 * 5)),
    );
    if (picked != null) {
      setState(() {
        _currentSchedule = _currentSchedule.copyWith(
          ngayThi: DateFormat('yyyy-MM-dd').format(picked),
        );
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(
        DateFormat('HH:mm').parse(_currentSchedule.gioBatDau),
      ),
    );
    if (picked != null) {
      final now = DateTime.now();
      final updatedTime = DateTime(
        now.year,
        now.month,
        now.day,
        picked.hour,
        picked.minute,
      );
      setState(() {
        _currentSchedule = _currentSchedule.copyWith(
          gioBatDau: DateFormat('HH:mm').format(updatedTime),
        );
      });
    }
  }

  void _saveChanges() {
    try {
      final parts = _durationController.text.split(':');
      final int totalMinutes = int.parse(parts[0]) * 60 + int.parse(parts[1]);

      final updated = _currentSchedule.copyWith(
        idGiamThi1: int.tryParse(_selectedProctor1?.value ?? '0') ?? 0,
        idGiamThi2: int.tryParse(_selectedProctor2?.value ?? '0') ?? 0,
        idPhongThi: int.tryParse(_selectedRoom?.value ?? '0') ?? 0,
        lanThi: int.tryParse(_selectedExamAttempt?.value ?? '1') ?? 1,
        thoiGianThi: totalMinutes,
      );
      widget.onSave(updated);
      _toggleEditMode();
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Đang cập nhật lịch thi!')));
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Lỗi khi lưu: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Lớp: ${_currentSchedule.lopHocPhan.lop.tenLop} - ${_currentSchedule.lopHocPhan.tenHocPhan}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            _buildInfoRowDropdown(
              'Giám thị 1',
              _selectedProctor1,
              _lecturers,
              (val) => setState(() => _selectedProctor1 = val),
            ),
            _buildInfoRowDropdown(
              'Giám thị 2',
              _selectedProctor2,
              _lecturers,
              (val) => setState(() => _selectedProctor2 = val),
            ),
            _buildDateField('Ngày thi', _currentSchedule.ngayThi),
            _buildTimeField('Giờ bắt đầu', _currentSchedule.gioBatDau),
            buildInfoRow(
              'Thời gian thi (phút)',
              _durationController,
              _isEditing,
              keyboardType: TextInputType.number,
            ),
            _buildInfoRowDropdown(
              'Phòng thi',
              _selectedRoom,
              _rooms,
              (val) => setState(() => _selectedRoom = val),
            ),
            _buildInfoRowDropdown(
              'Lần thi',
              _selectedExamAttempt,
              _examAttempts,
              (val) => setState(() => _selectedExamAttempt = val),
            ),
            const SizedBox(height: 16),
            Align(
              alignment: Alignment.centerRight,
              child: CustomButton(
                text: _isEditing ? 'Lưu' : 'Chỉnh sửa',
                onPressed: _isEditing ? _saveChanges : _toggleEditMode,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRowDropdown(
    String label,
    DropdownItem? selectedItem,
    List<DropdownItem> items,
    ValueChanged<DropdownItem?> onChanged,
  ) {
    final validSelectedItem = items.any((e) => e.value == selectedItem?.value)
        ? selectedItem
        : null;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 140,
            child: Padding(
              padding: const EdgeInsets.only(top: 14),
              child: Text(label, style: const TextStyle(fontSize: 14)),
            ),
          ),
          Expanded(
            child: DropdownButtonFormField<DropdownItem>(
              value: validSelectedItem,
              items: items
                  .map((e) => DropdownMenuItem(value: e, child: Text(e.label)))
                  .toList(),
              onChanged: _isEditing ? onChanged : null,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 14,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDateField(String label, String dateStr) {
    final date = DateFormat('yyyy-MM-dd').parse(dateStr);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          SizedBox(width: 140, child: Text(label)),
          Expanded(
            child: GestureDetector(
              onTap: _isEditing ? () => _selectDate(context) : null,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(4),
                  color: Colors.grey.shade100,
                ),
                child: Text(DateFormat('dd/MM/yyyy').format(date)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeField(String label, String time) {
    final String formattedTime;
    if (time.split(':').length == 3) {
      formattedTime = DateFormat(
        'HH:mm',
      ).format(DateFormat('HH:mm:ss').parse(time));
    } else {
      formattedTime = DateFormat(
        'HH:mm',
      ).format(DateFormat('HH:mm').parse(time));
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          SizedBox(width: 140, child: Text(label)),
          Expanded(
            child: GestureDetector(
              onTap: _isEditing ? () => _selectTime(context) : null,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(4),
                  color: Colors.grey.shade100,
                ),
                child: Text(formattedTime),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
