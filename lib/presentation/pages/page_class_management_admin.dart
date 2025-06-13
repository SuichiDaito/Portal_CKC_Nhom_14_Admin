import 'package:flutter/material.dart';
import 'package:portal_ckc/presentation/sections/schedule_card.dart';

// Models
class ClassSection {
  final String id;
  final String className;
  final String subject;
  final String type; // LT, TH
  final String department;
  final String instructor;
  final List<WeekSchedule> schedules;

  ClassSection({
    required this.id,
    required this.className,
    required this.subject,
    required this.type,
    required this.department,
    required this.instructor,
    this.schedules = const [],
  });
}

class WeekSchedule {
  final String id;
  final String classSectionId;
  final int week;
  final int dayOfWeek; // 2-7 (Mon-Sat)
  final int startPeriod;
  final int endPeriod;
  final String instructor;

  WeekSchedule({
    required this.id,
    required this.classSectionId,
    required this.week,
    required this.dayOfWeek,
    required this.startPeriod,
    required this.endPeriod,
    required this.instructor,
  });
}

// Main Screen
class PageClassManagementAdmin extends StatefulWidget {
  @override
  _PageClassManagementAdminState createState() =>
      _PageClassManagementAdminState();
}

class _PageClassManagementAdminState extends State<PageClassManagementAdmin> {
  List<ClassSection> classSections = [
    ClassSection(
      id: '1',
      className: 'CNPM01',
      subject: 'Công nghệ phần mềm',
      type: 'LT',
      department: 'Khoa CNTT',
      instructor: 'TS. Nguyễn Văn A',
    ),
    ClassSection(
      id: '2',
      className: 'CNPM01_TH',
      subject: 'Công nghệ phần mềm',
      type: 'TH',
      department: 'Khoa CNTT',
      instructor: 'ThS. Trần Thị B',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quản lý lớp học phần'),
        backgroundColor: Colors.blue[600],
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        color: Colors.grey[50],
        child: ListView.builder(
          padding: EdgeInsets.all(16),
          itemCount: classSections.length,
          itemBuilder: (context, index) {
            return ClassSectionCard(
              classSection: classSections[index],
              onEditInstructor: () => _editInstructor(classSections[index]),
              onManageSchedule: () => _manageSchedule(classSections[index]),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addNewClass(),
        child: Icon(Icons.add),
        backgroundColor: Colors.blue[600],
      ),
    );
  }

  void _editInstructor(ClassSection classSection) {
    showDialog(
      context: context,
      builder: (context) => EditInstructorDialog(
        classSection: classSection,
        onSave: (newInstructor) {
          setState(() {
            int index = classSections.indexWhere(
              (c) => c.id == classSection.id,
            );
            if (index != -1) {
              classSections[index] = ClassSection(
                id: classSection.id,
                className: classSection.className,
                subject: classSection.subject,
                type: classSection.type,
                department: classSection.department,
                instructor: newInstructor,
                schedules: classSection.schedules,
              );
            }
          });
        },
      ),
    );
  }

  void _manageSchedule(ClassSection classSection) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            ScheduleManagementScreen(classSection: classSection),
      ),
    );
  }

  void _addNewClass() {
    // Implement add new class functionality
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Tính năng thêm lớp mới sẽ được phát triển')),
    );
  }
}

// Class Section Card Widget
class ClassSectionCard extends StatelessWidget {
  final ClassSection classSection;
  final VoidCallback onEditInstructor;
  final VoidCallback onManageSchedule;

  const ClassSectionCard({
    Key? key,
    required this.classSection,
    required this.onEditInstructor,
    required this.onManageSchedule,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: classSection.type == 'LT'
                        ? Colors.blue[100]
                        : Colors.green[100],
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    classSection.type,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: classSection.type == 'LT'
                          ? Colors.blue[800]
                          : Colors.green[800],
                    ),
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    classSection.className,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            _buildInfoRow(Icons.book, 'Môn học', classSection.subject),
            SizedBox(height: 8),
            _buildInfoRow(
              Icons.business,
              'Khoa/Bộ môn',
              classSection.department,
            ),
            SizedBox(height: 8),
            _buildInfoRow(Icons.person, 'Giảng viên', classSection.instructor),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: onEditInstructor,
                    icon: Icon(Icons.edit, size: 18),
                    label: Text('Sửa GV'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange[400],
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: onManageSchedule,
                    icon: Icon(Icons.schedule, size: 18),
                    label: Text('Lịch tuần'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue[600],
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 16, color: Colors.grey[600]),
        SizedBox(width: 8),
        Text(
          '$label: ',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: Colors.grey[700],
          ),
        ),
        Expanded(
          child: Text(value, style: TextStyle(color: Colors.grey[800])),
        ),
      ],
    );
  }
}

// Edit Instructor Dialog
class EditInstructorDialog extends StatefulWidget {
  final ClassSection classSection;
  final Function(String) onSave;

  const EditInstructorDialog({
    Key? key,
    required this.classSection,
    required this.onSave,
  }) : super(key: key);

  @override
  _EditInstructorDialogState createState() => _EditInstructorDialogState();
}

class _EditInstructorDialogState extends State<EditInstructorDialog> {
  late TextEditingController _controller;
  final List<String> danhSachGiangVien = [
    'Nguyễn Văn A',
    'Trần Thị B',
    'Lê Văn C',
    'Phạm Thị D',
  ];

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.classSection.instructor);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Phân công giảng viên'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Lớp: ${widget.classSection.className}'),
          SizedBox(height: 16),
          TextField(
            controller: _controller,
            decoration: InputDecoration(
              labelText: 'Tên giảng viên',
              border: OutlineInputBorder(),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: Text('Hủy')),
        ElevatedButton(
          onPressed: () {
            widget.onSave(_controller.text);
            Navigator.pop(context);
          },
          child: Text('Lưu'),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

// Schedule Management Screen
class ScheduleManagementScreen extends StatefulWidget {
  final ClassSection classSection;

  const ScheduleManagementScreen({Key? key, required this.classSection})
    : super(key: key);

  @override
  _ScheduleManagementScreenState createState() =>
      _ScheduleManagementScreenState();
}

class _ScheduleManagementScreenState extends State<ScheduleManagementScreen> {
  List<WeekSchedule> schedules = [];
  bool showScheduleForm = false;

  @override
  void initState() {
    super.initState();
    // Load existing schedules
    schedules = widget.classSection.schedules;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lịch tuần - ${widget.classSection.className}'),
        backgroundColor: Colors.blue[600],
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16),
            color: Colors.blue[50],
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Thông tin lớp học phần',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                SizedBox(height: 8),
                Text('Lớp: ${widget.classSection.className}'),
                Text('Môn: ${widget.classSection.subject}'),
                Text('Giảng viên: ${widget.classSection.instructor}'),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () =>
                        setState(() => showScheduleForm = !showScheduleForm),
                    icon: Icon(Icons.add),
                    label: Text('Tạo lịch tuần'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green[600],
                      foregroundColor: Colors.white,
                    ),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _showCopyDialog,
                    icon: Icon(Icons.copy),
                    label: Text('Copy lịch'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange[600],
                      foregroundColor: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (showScheduleForm)
            ScheduleForm(
              classSection: widget.classSection,
              onSave: (schedule) {
                setState(() {
                  schedules.add(schedule);
                  showScheduleForm = false;
                });
              },
              onCancel: () => setState(() => showScheduleForm = false),
            ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 16),
              itemCount: schedules.length,
              itemBuilder: (context, index) {
                return ScheduleCard(
                  schedule: schedules[index],
                  onEdit: () => _editSchedule(schedules[index]),
                  onDelete: () => _deleteSchedule(schedules[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _editSchedule(WeekSchedule schedule) {
    // Implement edit functionality
  }

  void _deleteSchedule(WeekSchedule schedule) {
    setState(() {
      schedules.removeWhere((s) => s.id == schedule.id);
    });
  }

  void _showCopyDialog() {
    showDialog(
      context: context,
      builder: (context) => CopyScheduleDialog(
        schedules: schedules,
        onCopy: (fromWeek, toWeek) {
          // Implement copy functionality
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Đã copy lịch từ tuần $fromWeek đến tuần $toWeek'),
            ),
          );
        },
      ),
    );
  }
}

// Schedule Form Widget
class ScheduleForm extends StatefulWidget {
  final ClassSection classSection;
  final Function(WeekSchedule) onSave;
  final VoidCallback onCancel;

  const ScheduleForm({
    Key? key,
    required this.classSection,
    required this.onSave,
    required this.onCancel,
  }) : super(key: key);

  @override
  _ScheduleFormState createState() => _ScheduleFormState();
}

class _ScheduleFormState extends State<ScheduleForm> {
  int selectedWeek = 1;
  int selectedDay = 2; // Monday
  int startPeriod = 1;
  int endPeriod = 2;
  late String instructor;

  final List<String> dayNames = [
    '',
    '',
    'Thứ 2',
    'Thứ 3',
    'Thứ 4',
    'Thứ 5',
    'Thứ 6',
    'Thứ 7',
  ];

  @override
  void initState() {
    super.initState();
    instructor = widget.classSection.instructor;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(16),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Tạo lịch tuần mới',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<int>(
                    value: selectedWeek,
                    decoration: InputDecoration(
                      labelText: 'Tuần',
                      border: OutlineInputBorder(),
                    ),
                    items: List.generate(16, (index) => index + 1)
                        .map(
                          (week) => DropdownMenuItem(
                            value: week,
                            child: Text('Tuần $week'),
                          ),
                        )
                        .toList(),
                    onChanged: (value) => setState(() => selectedWeek = value!),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: DropdownButtonFormField<int>(
                    value: selectedDay,
                    decoration: InputDecoration(
                      labelText: 'Thứ',
                      border: OutlineInputBorder(),
                    ),
                    items: [2, 3, 4, 5, 6, 7]
                        .map(
                          (day) => DropdownMenuItem(
                            value: day,
                            child: Text(dayNames[day]),
                          ),
                        )
                        .toList(),
                    onChanged: (value) => setState(() => selectedDay = value!),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<int>(
                    value: startPeriod,
                    decoration: InputDecoration(
                      labelText: 'Tiết bắt đầu',
                      border: OutlineInputBorder(),
                    ),
                    items: List.generate(12, (index) => index + 1)
                        .map(
                          (period) => DropdownMenuItem(
                            value: period,
                            child: Text('Tiết $period'),
                          ),
                        )
                        .toList(),
                    onChanged: (value) => setState(() => startPeriod = value!),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: DropdownButtonFormField<int>(
                    value: endPeriod,
                    decoration: InputDecoration(
                      labelText: 'Tiết kết thúc',
                      border: OutlineInputBorder(),
                    ),
                    items: List.generate(12, (index) => index + 1)
                        .where((period) => period >= startPeriod)
                        .map(
                          (period) => DropdownMenuItem(
                            value: period,
                            child: Text('Tiết $period'),
                          ),
                        )
                        .toList(),
                    onChanged: (value) => setState(() => endPeriod = value!),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: widget.onCancel,
                    child: Text('Hủy'),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _saveSchedule,
                    child: Text('Lưu'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue[600],
                      foregroundColor: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _saveSchedule() {
    final schedule = WeekSchedule(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      classSectionId: widget.classSection.id,
      week: selectedWeek,
      dayOfWeek: selectedDay,
      startPeriod: startPeriod,
      endPeriod: endPeriod,
      instructor: instructor,
    );
    widget.onSave(schedule);
  }
}

// Copy Schedule Dialog
class CopyScheduleDialog extends StatefulWidget {
  final List<WeekSchedule> schedules;
  final Function(int, int) onCopy;

  const CopyScheduleDialog({
    Key? key,
    required this.schedules,
    required this.onCopy,
  }) : super(key: key);

  @override
  _CopyScheduleDialogState createState() => _CopyScheduleDialogState();
}

class _CopyScheduleDialogState extends State<CopyScheduleDialog> {
  int fromWeek = 1;
  int toWeek = 2;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Copy lịch tuần'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          DropdownButtonFormField<int>(
            value: fromWeek,
            decoration: InputDecoration(
              labelText: 'Từ tuần',
              border: OutlineInputBorder(),
            ),
            items: List.generate(16, (index) => index + 1)
                .map(
                  (week) =>
                      DropdownMenuItem(value: week, child: Text('Tuần $week')),
                )
                .toList(),
            onChanged: (value) => setState(() => fromWeek = value!),
          ),
          SizedBox(height: 16),
          DropdownButtonFormField<int>(
            value: toWeek,
            decoration: InputDecoration(
              labelText: 'Đến tuần',
              border: OutlineInputBorder(),
            ),
            items: List.generate(16, (index) => index + 1)
                .map(
                  (week) =>
                      DropdownMenuItem(value: week, child: Text('Tuần $week')),
                )
                .toList(),
            onChanged: (value) => setState(() => toWeek = value!),
          ),
        ],
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: Text('Hủy')),
        ElevatedButton(
          onPressed: () {
            widget.onCopy(fromWeek, toWeek);
            Navigator.pop(context);
          },
          child: Text('Copy'),
        ),
      ],
    );
  }
}
