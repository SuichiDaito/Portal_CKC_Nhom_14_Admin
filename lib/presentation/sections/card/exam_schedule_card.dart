import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:portal_ckc/presentation/sections/button/button_custom_button.dart';
import 'package:portal_ckc/presentation/sections/card/build_infor_cart.dart';
import 'package:portal_ckc/presentation/sections/card/schedule_management_dropdown_item.dart';

enum ExamStatus { scheduled, completed, cancelled }

class ExamSchedule {
  final String id; // Unique ID for the exam schedule item
  final String className;
  String proctor1; // Giám thị 1
  String proctor2; // Giám thị 2
  DateTime examDate;
  String startTime; // e.g., "07:30"
  int durationMinutes; // Thời gian thi, ví dụ 90 phút
  String room;
  int examAttempt; // Lần thi (lần 1, lần 2)
  ExamStatus status;

  ExamSchedule({
    required this.id,
    required this.className,
    required this.proctor1,
    required this.proctor2,
    required this.examDate,
    required this.startTime,
    required this.durationMinutes,
    required this.room,
    required this.examAttempt,
    this.status = ExamStatus.scheduled, // Mặc định là đã lên lịch
  });

  // Helper to create a copy for editing
  ExamSchedule copyWith({
    String? id,
    String? className,
    String? proctor1,
    String? proctor2,
    DateTime? examDate,
    String? startTime,
    int? durationMinutes,
    String? room,
    int? examAttempt,
    ExamStatus? status,
  }) {
    return ExamSchedule(
      id: id ?? this.id,
      className: className ?? this.className,
      proctor1: proctor1 ?? this.proctor1,
      proctor2: proctor2 ?? this.proctor2,
      examDate: examDate ?? this.examDate,
      startTime: startTime ?? this.startTime,
      durationMinutes: durationMinutes ?? this.durationMinutes,
      room: room ?? this.room,
      examAttempt: examAttempt ?? this.examAttempt,
      status: status ?? this.status,
    );
  }
}

class ExamScheduleCard extends StatefulWidget {
  final ExamSchedule schedule;
  final ValueChanged<ExamSchedule> onSave; // Callback khi lưu thay đổi

  const ExamScheduleCard({
    Key? key,
    required this.schedule,
    required this.onSave,
  }) : super(key: key);

  @override
  _ExamScheduleCardState createState() => _ExamScheduleCardState();
}

class _ExamScheduleCardState extends State<ExamScheduleCard> {
  late ExamSchedule _currentSchedule; // Bản sao để chỉnh sửa
  bool _isEditing = false; // Trạng thái chỉnh sửa
  late TextEditingController _proctor1Controller;
  late TextEditingController _proctor2Controller;
  late TextEditingController _roomController;
  late TextEditingController _examAttemptController;
  late TextEditingController _durationController;
  DropdownItem? _selectedProctor1;
  DropdownItem? _selectedProctor2;

  final List<DropdownItem> _lecturers = [
    DropdownItem(value: 'GV001', label: 'Nguyễn Văn A', icon: Icons.person),
    DropdownItem(value: 'GV002', label: 'Trần Thị B', icon: Icons.person),
  ];
  DropdownItem? _selectedRoom;
  DropdownItem? _selectedExamAttempt;
  final List<DropdownItem> _rooms = [
    DropdownItem(value: 'P.101', label: 'P.101', icon: Icons.meeting_room),
    DropdownItem(value: 'P.102', label: 'P.102', icon: Icons.class_),
    DropdownItem(value: 'P.201', label: 'P.201', icon: Icons.location_city),
  ];

  final List<DropdownItem> _examAttempts = [
    DropdownItem(value: '1', label: 'Lần 1', icon: Icons.filter_1),
    DropdownItem(value: '2', label: 'Lần 2', icon: Icons.filter_2),
  ];

  @override
  void initState() {
    super.initState();
    _currentSchedule = widget.schedule.copyWith(); // Tạo bản sao khi khởi tạo
    _initializeControllers();
  }

  // Cập nhật controller khi widget được rebuild với dữ liệu mới
  @override
  void didUpdateWidget(covariant ExamScheduleCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.schedule.id != oldWidget.schedule.id ||
        widget.schedule.status != oldWidget.schedule.status) {
      _currentSchedule = widget.schedule.copyWith();
      _initializeControllers();
      _isEditing = false; // Reset editing state if underlying data changes
    }
  }

  void _initializeControllers() {
    _proctor1Controller = TextEditingController(
      text: _currentSchedule.proctor1,
    );
    _proctor2Controller = TextEditingController(
      text: _currentSchedule.proctor2,
    );
    _roomController = TextEditingController(text: _currentSchedule.room);
    _examAttemptController = TextEditingController(
      text: _currentSchedule.examAttempt.toString(),
    );
    _durationController = TextEditingController(
      text: _currentSchedule.durationMinutes.toString(),
    );
  }

  @override
  void dispose() {
    _proctor1Controller.dispose();
    _proctor2Controller.dispose();
    _roomController.dispose();
    _examAttemptController.dispose();
    _durationController.dispose();
    super.dispose();
  }

  void _toggleEditMode() {
    setState(() {
      _isEditing = !_isEditing;
      if (!_isEditing) {
        // Nếu chuyển từ editing sang non-editing (nhấn Hủy hoặc sau khi Lưu)
        // Reset lại dữ liệu hiển thị về dữ liệu gốc của widget nếu không lưu
        _currentSchedule = widget.schedule.copyWith();
        _initializeControllers();
      }
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _currentSchedule.examDate,
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now().add(const Duration(days: 365 * 5)),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(
              primary: Colors.blueAccent, // Header background color
              onPrimary: Colors.white, // Header text color
              onSurface: Colors.black87, // Body text color
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Colors.blueAccent, // Button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _currentSchedule.examDate) {
      setState(() {
        _currentSchedule.examDate = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(
        DateFormat('HH:mm').parse(_currentSchedule.startTime),
      ),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(
              primary: Colors.blueAccent, // Header background color
              onPrimary: Colors.white, // Header text color
              onSurface: Colors.black87, // Body text color
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Colors.blueAccent, // Button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        _currentSchedule.startTime = picked.format(context);
      });
    }
  }

  void _saveChanges() {
    try {
      final newProctor1 = _proctor1Controller.text;
      final newProctor2 = _proctor2Controller.text;
      final newRoom = _roomController.text;
      final newAttempt = int.parse(_examAttemptController.text);
      final newDuration = int.parse(_durationController.text);

      _currentSchedule.proctor1 = newProctor1;
      _currentSchedule.proctor2 = newProctor2;
      _currentSchedule.room = newRoom;
      _currentSchedule.examAttempt = newAttempt;
      _currentSchedule.durationMinutes = newDuration;

      widget.onSave(_currentSchedule); // Gửi dữ liệu đã cập nhật lên widget cha
      _isEditing = false; // Tắt chế độ chỉnh sửa sau khi lưu
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Đã lưu thay đổi lịch thi!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Lỗi khi lưu: Vui lòng kiểm tra lại dữ liệu. $e'),
        ),
      );
    }
  }

  Color _getStatusColor(ExamStatus status) {
    switch (status) {
      case ExamStatus.scheduled:
        return Colors.blueAccent;
      case ExamStatus.completed:
        return Colors.green;
      case ExamStatus.cancelled:
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  String _getStatusText(ExamStatus status) {
    switch (status) {
      case ExamStatus.scheduled:
        return 'Đã lên lịch';
      case ExamStatus.completed:
        return 'Đã hoàn thành';
      case ExamStatus.completed:
        return 'Đã hủy';
      default:
        return 'Không xác định';
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool canEdit = widget.schedule.status != ExamStatus.completed;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      elevation: 2.0,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Lớp: ${widget.schedule.className}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
            const SizedBox(height: 8),
            _buildInfoRowDropdown(
              label: 'Giám thị 1:',
              selectedItem: _selectedProctor1,
              items: _lecturers,
              onChanged: (value) {
                setState(() {
                  _selectedProctor1 = value;
                });
              },
              isEnabled: _isEditing && canEdit,
            ),

            _buildInfoRowDropdown(
              label: 'Giám thị 2:',
              selectedItem: _selectedProctor2,
              items: _lecturers,
              onChanged: (value) {
                setState(() {
                  _selectedProctor2 = value;
                });
              },
              isEnabled: _isEditing && canEdit,
            ),

            _buildDateField(
              'Ngày thi:',
              _currentSchedule.examDate,
              _isEditing && canEdit,
            ),
            _buildTimeField(
              'Giờ thi bắt đầu:',
              _currentSchedule.startTime,
              _isEditing && canEdit,
            ),
            buildInfoRow(
              'Thời gian thi (phút):',
              _durationController,
              _isEditing && canEdit,
              keyboardType: TextInputType.number,
              icon: Icons.access_time, // icon đồng hồ
            ),

            _buildInfoRowDropdown(
              label: 'Phòng thi:',
              selectedItem: _selectedRoom,
              items: _rooms,
              onChanged: (value) {
                setState(() {
                  _selectedRoom = value;
                });
              },
              isEnabled: _isEditing && canEdit,
            ),

            _buildInfoRowDropdown(
              label: 'Lần thi:',
              selectedItem: _selectedExamAttempt,
              items: _examAttempts,
              onChanged: (value) {
                setState(() {
                  _selectedExamAttempt = value;
                });
              },
              isEnabled: _isEditing && canEdit,
            ),

            const SizedBox(height: 8),
            Row(
              children: [
                const Text(
                  'Trạng thái:',
                  style: TextStyle(fontSize: 15, color: Colors.black87),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: _getStatusColor(
                      widget.schedule.status,
                    ).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                      color: _getStatusColor(widget.schedule.status),
                    ),
                  ),
                  child: Text(
                    _getStatusText(widget.schedule.status),
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: _getStatusColor(widget.schedule.status),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Align(
              alignment: Alignment.centerRight,
              child: CustomButton(
                text: _isEditing ? 'Lưu' : 'Thay đổi',
                onPressed: canEdit
                    ? (_isEditing ? _saveChanges : _toggleEditMode)
                    : () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Không thể sửa lịch thi đã hoàn thành.',
                            ),
                          ),
                        );
                      },
                isEnabled:
                    canEdit, // Nút bị vô hiệu hóa nếu trạng thái là "Đã hoàn thành"
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRowDropdown({
    required String label,
    required DropdownItem? selectedItem,
    required List<DropdownItem> items,
    required ValueChanged<DropdownItem?> onChanged,
    bool isEnabled = true,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 150,
            child: Text(
              label,
              style: const TextStyle(fontSize: 15, color: Colors.black87),
            ),
          ),
          Expanded(
            child: DropdownButtonFormField<DropdownItem>(
              value: selectedItem,
              hint: Row(
                // 👈 Thêm placeholder kèm icon
                children: const [
                  Icon(Icons.list_alt, color: Colors.grey),
                  SizedBox(width: 8),
                  Text('====', style: TextStyle(color: Colors.grey)),
                ],
              ),
              items: items.map((item) {
                return DropdownMenuItem<DropdownItem>(
                  value: item,
                  child: Row(
                    children: [
                      if (item.icon != null) ...[
                        Icon(item.icon, size: 20, color: Colors.blueAccent),
                        const SizedBox(width: 8),
                      ],
                      Text(item.label),
                    ],
                  ),
                );
              }).toList(),
              onChanged: isEnabled ? onChanged : null,
              decoration: InputDecoration(
                isDense: true,
                filled: true,
                fillColor: isEnabled
                    ? Colors.white
                    : const Color.fromARGB(255, 249, 247, 247),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 10,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.blue, width: 2),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              icon: const Icon(Icons.arrow_drop_down),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDateField(String label, DateTime date, bool isEnabled) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 150,
            child: Text(
              label,
              style: const TextStyle(fontSize: 15, color: Colors.black87),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: isEnabled ? () => _selectDate(context) : null,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 10.0,
                  horizontal: 10.0,
                ),
                decoration: BoxDecoration(
                  border: isEnabled
                      ? Border.all(color: Colors.grey)
                      : null, // hoặc Border.all(color: Colors.transparent)
                  borderRadius: BorderRadius.circular(4.0),
                  color: isEnabled ? Colors.white : Colors.grey.shade100,
                ),

                child: Text(
                  DateFormat('dd/MM/yyyy').format(date),
                  style: TextStyle(
                    fontSize: 16,
                    color: isEnabled ? Colors.black : Colors.grey.shade700,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeField(String label, String time, bool isEnabled) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 150,
            child: Text(
              label,
              style: const TextStyle(fontSize: 15, color: Colors.black87),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: isEnabled ? () => _selectTime(context) : null,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 10.0,
                  horizontal: 10.0,
                ),
                decoration: BoxDecoration(
                  border: isEnabled
                      ? Border.all(color: Colors.grey)
                      : null, // hoặc Border.all(color: Colors.transparent)
                  borderRadius: BorderRadius.circular(4.0),
                  color: isEnabled ? Colors.white : Colors.grey.shade100,
                ),

                child: Text(
                  time,
                  style: TextStyle(
                    fontSize: 16,
                    color: isEnabled ? Colors.black : Colors.grey.shade700,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
