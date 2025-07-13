import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portal_ckc/api/model/admin_lop_hoc_phan.dart';
import 'package:portal_ckc/api/model/admin_phong.dart';
import 'package:portal_ckc/bloc/bloc_event_state/thoi_khoa_bieu_bloc.dart';
import 'package:portal_ckc/bloc/event/thoi_khoa_bieu_event.dart';

class DayTimePicker extends StatefulWidget {
  final bool enabled;
  final List<ScheduleTime> schedules;
  final ValueChanged<List<ScheduleTime>> onScheduleChanged;
  final List<Room> rooms;
  final int? selectedRoomId;
  final ValueChanged<int?> onRoomChanged;
  const DayTimePicker({
    Key? key,
    required this.enabled,
    required this.schedules,
    required this.onScheduleChanged,
    required this.rooms,
    required this.selectedRoomId,
    required this.onRoomChanged,
  }) : super(key: key);

  @override
  State<DayTimePicker> createState() => _DayTimePickerState();
}

class _DayTimePickerState extends State<DayTimePicker> {
  final List<String> _daysOfWeek = ['T2', 'T3', 'T4', 'T5', 'T6', 'T7', 'CN'];
  final List<int> _lessonNumbers = List.generate(15, (index) => index + 1);

  int? _selectedDay;
  int _startLesson = 1;
  int _endLesson = 1;
  List<ScheduleTime> _selectedSchedules = [];

  @override
  void initState() {
    super.initState();
    _selectedSchedules = List.from(widget.schedules);
  }

  void _addSchedule() {
    if (_selectedDay == null) return;

    final index = _selectedDay == 8 ? 6 : _selectedDay! - 2;
    final thuText = [
      'Thứ 2',
      'Thứ 3',
      'Thứ 4',
      'Thứ 5',
      'Thứ 6',
      'Thứ 7',
      'Chủ nhật',
    ][index];

    final selectedRoom = widget.rooms.firstWhere(
      (room) => room.id == widget.selectedRoomId,
      orElse: () =>
          Room(id: 0, ten: 'Không xác định', soLuong: 0, loaiPhong: 0),
    );

    final newSchedule = ScheduleTime(
      id: 0,
      ngay: _daysOfWeek[index],
      tietBatDau: _startLesson,
      tietKetThuc: _endLesson,
      phong: selectedRoom.ten,
      thu: thuText,
    );

    setState(() {
      _selectedSchedules.add(newSchedule);
    });

    widget.onScheduleChanged(_selectedSchedules);

    _selectedDay = null;
    _startLesson = 1;
    _endLesson = 1;
  }

  void _removeSchedule(int index) {
    final removedSchedule = _selectedSchedules[index];

    if (removedSchedule.id != null) {
      context.read<ThoiKhoaBieuBloc>().add(
        DeleteThoiKhoaBieuEvent(removedSchedule.id!),
      );
    }

    setState(() {
      _selectedSchedules.removeAt(index);
    });

    widget.onScheduleChanged(_selectedSchedules);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Lịch đã chọn:',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        ..._selectedSchedules.asMap().entries.map((entry) {
          final index = entry.key;
          final schedule = entry.value;
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 2,
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(
                vertical: 12,
                horizontal: 16,
              ),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.calendar_today,
                        size: 20,
                        color: Colors.blueAccent,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        schedule.thu,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      const Icon(
                        Icons.schedule,
                        size: 20,
                        color: Colors.deepPurple,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Tiết: ${schedule.tietBatDau} - ${schedule.tietKetThuc}',
                        style: const TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      const Icon(
                        Icons.meeting_room,
                        size: 20,
                        color: Colors.green,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Phòng: ${schedule.phong}',
                        style: const TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                ],
              ),
              trailing: widget.enabled
                  ? IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () => _removeSchedule(index),
                    )
                  : null,
            ),
          );
        }),
        if (widget.enabled) ...[
          const SizedBox(height: 16),

          DropdownButtonFormField<int>(
            value: widget.selectedRoomId,
            decoration: const InputDecoration(
              labelText: 'Phòng học',
              border: OutlineInputBorder(),
            ),
            isExpanded: true,
            items: widget.rooms.map((room) {
              return DropdownMenuItem<int>(
                value: room.id,
                child: Text(room.ten),
              );
            }).toList(),
            onChanged: (value) {
              widget.onRoomChanged(value);
            },
          ),
          const SizedBox(height: 16),

          const Text(
            'Chọn thứ:',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8.0,
            runSpacing: 8.0,
            children: List.generate(_daysOfWeek.length, (index) {
              final dayValue = index + 2; // T2 -> 2, CN -> 8
              final isSelected = _selectedDay == dayValue;
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedDay = dayValue;
                  });
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected ? Colors.blueAccent : Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.blueAccent),
                  ),
                  child: Text(
                    _daysOfWeek[index],
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.blueAccent,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              );
            }),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: DropdownButtonFormField<int>(
                  value: _startLesson,
                  decoration: const InputDecoration(
                    labelText: 'Từ tiết',
                    border: OutlineInputBorder(),
                  ),
                  items: _lessonNumbers.map((lesson) {
                    return DropdownMenuItem(
                      value: lesson,
                      child: Text('Tiết $lesson'),
                    );
                  }).toList(),
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        _startLesson = value;
                        if (_endLesson < _startLesson) {
                          _endLesson = _startLesson;
                        }
                      });
                    }
                  },
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: DropdownButtonFormField<int>(
                  value: _endLesson,
                  decoration: const InputDecoration(
                    labelText: 'Đến tiết',
                    border: OutlineInputBorder(),
                  ),
                  items: _lessonNumbers
                      .where((lesson) => lesson >= _startLesson)
                      .map((lesson) {
                        return DropdownMenuItem(
                          value: lesson,
                          child: Text('Tiết $lesson'),
                        );
                      })
                      .toList(),
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        _endLesson = value;
                      });
                    }
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: _addSchedule,
            icon: const Icon(Icons.add, size: 20),
            label: const Text(
              'Thêm lịch dạy',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              backgroundColor: Colors.blueAccent,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 4,
              shadowColor: Colors.blueAccent.withOpacity(0.5),
            ),
          ),
        ],
      ],
    );
  }
}
