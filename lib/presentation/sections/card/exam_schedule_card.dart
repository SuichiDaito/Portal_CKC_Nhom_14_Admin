import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:portal_ckc/api/model/admin_lich_thi.dart';
import 'package:portal_ckc/presentation/sections/button/build_date_field.dart';
import 'package:portal_ckc/presentation/sections/button/build_time_field.dart';
import 'package:portal_ckc/presentation/sections/button/button_custom_button.dart';
import 'package:portal_ckc/presentation/sections/button/info_row_dropdown_button.dart';
import 'package:portal_ckc/presentation/sections/card/build_infor_cart.dart';
import 'package:portal_ckc/presentation/sections/card/schedule_management_dropdown_item.dart';

class ExamScheduleCard extends StatefulWidget {
  final ExamSchedule schedule;
  final ValueChanged<ExamSchedule> onSave;
  final List<DropdownItem> lecturers;
  final List<DropdownItem> rooms;
  final int? trangThaiNopDiem;
  final bool isNew;
  final List<int> existingAttempts;
  const ExamScheduleCard({
    Key? key,
    required this.schedule,
    required this.onSave,
    required this.lecturers,
    required this.rooms,
    required this.existingAttempts,
    required this.trangThaiNopDiem,
    required this.isNew,
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
  List<DropdownItem> _getAllowedExamAttempts() {
    final attempts = <DropdownItem>[];
    if (widget.trangThaiNopDiem == 0 && !widget.existingAttempts.contains(1)) {
      attempts.add(_examAttempts.firstWhere((e) => e.value == '1'));
    }
    if (widget.trangThaiNopDiem == 1 && !widget.existingAttempts.contains(2)) {
      attempts.add(_examAttempts.firstWhere((e) => e.value == '2'));
    }
    return attempts;
  }

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
    _durationController = TextEditingController(
      text: durationMinutes.toString(),
    );
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
      final int totalMinutes = int.parse(_durationController.text.trim());
      final int selectedAttempt =
          int.tryParse(_selectedExamAttempt?.value ?? '1') ?? 1;

      final allowedAttempts = _getAllowedExamAttempts()
          .map((e) => int.parse(e.value))
          .toList();

      if (!allowedAttempts.contains(selectedAttempt)) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Lần thi không hợp lệ!')));
        return;
      }

      final updated = _currentSchedule.copyWith(
        idGiamThi1: int.tryParse(_selectedProctor1?.value ?? '0') ?? 0,
        idGiamThi2: int.tryParse(_selectedProctor2?.value ?? '0') ?? 0,
        idPhongThi: int.tryParse(_selectedRoom?.value ?? '0') ?? 0,
        lanThi: selectedAttempt,
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

            if (widget.trangThaiNopDiem != 0)
              const Padding(
                padding: EdgeInsets.only(bottom: 12),
                child: Text(
                  'Không thể chỉnh sửa do điểm đã nộp.',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            InfoRowDropdown(
              label: 'Giám thị 1',
              selectedItem: _selectedProctor1,
              items: _lecturers,
              onChanged: (val) => setState(() => _selectedProctor1 = val),
              isEditing: _isEditing,
            ),
            InfoRowDropdown(
              label: 'Giám thị 2',
              selectedItem: _selectedProctor2,
              items: _lecturers,
              onChanged: (val) => setState(() => _selectedProctor2 = val),
              isEditing: _isEditing,
            ),

            InfoRowDateField(
              label: 'Ngày thi',
              dateStr: _currentSchedule.ngayThi,
              isEditing: _isEditing,
              onSelectDate: () => _selectDate(context),
            ),
            InfoRowTimeField(
              label: 'Giờ bắt đầu',
              timeStr: _currentSchedule.gioBatDau,
              isEditing: _isEditing,
              onSelectTime: () => _selectTime(context),
            ),
            buildInfoRow(
              'Thời gian thi (phút)',
              _durationController,
              _isEditing,
              keyboardType: TextInputType.number,
            ),

            InfoRowDropdown(
              label: 'Phòng thi',
              selectedItem: _selectedRoom,
              items: _rooms,
              onChanged: (val) => setState(() => _selectedRoom = val),
              isEditing: _isEditing,
            ),
            InfoRowDropdown(
              label: 'Lần thi',
              selectedItem: _selectedExamAttempt,
              items: _getAllowedExamAttempts(),
              onChanged: (val) => setState(() => _selectedExamAttempt = val),
              isEditing: _isEditing,
            ),

            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (_isEditing)
                  CustomButton(
                    text: 'Thoát',
                    onPressed: () {
                      setState(() {
                        _isEditing = false;
                        _currentSchedule = widget.schedule;
                        _durationController.text = _currentSchedule.thoiGianThi
                            .toString();
                        _selectedExamAttempt = DropdownItem(
                          value: _currentSchedule.lanThi.toString(),
                          label: 'Lần ${_currentSchedule.lanThi}',
                          icon: Icons.numbers,
                        );
                      });
                    },
                  ),
                const SizedBox(width: 12),
                CustomButton(
                  text: _isEditing ? 'Lưu' : 'Chỉnh sửa',
                  onPressed: () {
                    final now = DateTime.now();
                    final ngayThiDate = DateTime.parse(
                      _currentSchedule.ngayThi,
                    );
                    final isNgayThiLocked = !now.isBefore(
                      DateTime(
                        ngayThiDate.year,
                        ngayThiDate.month,
                        ngayThiDate.day,
                      ),
                    );
                    final isLocked =
                        !widget.isNew &&
                        (widget.trangThaiNopDiem != 0 || isNgayThiLocked);
                    if (_isEditing) {
                      _saveChanges();
                    } else {
                      if (!isLocked) {
                        _toggleEditMode();
                      } else {
                        String reason = '';
                        if (widget.trangThaiNopDiem != 0) {
                          reason = 'Không thể chỉnh sửa. Điểm đã nộp!';
                        } else if (isNgayThiLocked) {
                          reason =
                              'Không thể chỉnh sửa do ngày thi đã đến hoặc đã qua!';
                        }
                        ScaffoldMessenger.of(
                          context,
                        ).showSnackBar(SnackBar(content: Text(reason)));
                      }
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
