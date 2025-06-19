import 'package:flutter/material.dart';

class DayTimePicker extends StatefulWidget {
  final bool enabled;
  final List<Map<String, dynamic>> schedules;
  final ValueChanged<List<Map<String, dynamic>>> onScheduleChanged;

  const DayTimePicker({
    Key? key,
    required this.enabled,
    required this.schedules,
    required this.onScheduleChanged,
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
  List<Map<String, dynamic>> _selectedSchedules = [];

  @override
  void initState() {
    super.initState();
    _selectedSchedules = List.from(widget.schedules);
  }

  void _addSchedule() {
    if (_selectedDay == null) return;

    final newSchedule = {
      'day': _selectedDay!,
      'start': _startLesson,
      'end': _endLesson,
    };

    setState(() {
      _selectedSchedules.add(newSchedule);
    });

    widget.onScheduleChanged(_selectedSchedules);

    _selectedDay = null;
    _startLesson = 1;
    _endLesson = 1;
  }

  void _removeSchedule(int index) {
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
          final dayIndex = schedule['day'] - 2;
          final dayText = (dayIndex >= 0 && dayIndex < _daysOfWeek.length)
              ? _daysOfWeek[dayIndex]
              : 'CN';
          return ListTile(
            title: Text(
              '$dayText: Tiết ${schedule['start']} - ${schedule['end']}',
            ),
            trailing: widget.enabled
                ? IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => _removeSchedule(index),
                  )
                : null,
          );
        }),

        if (widget.enabled) ...[
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
              final dayValue = index + 2;
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
          ElevatedButton(
            onPressed: _addSchedule,
            child: const Text('Thêm lịch dạy'),
          ),
        ],
      ],
    );
  }
}
