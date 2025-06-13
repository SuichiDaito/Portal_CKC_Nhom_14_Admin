import 'package:flutter/material.dart';

class PageTeachingScheduleAdmin extends StatefulWidget {
  @override
  _PageTeachingScheduleAdminState createState() =>
      _PageTeachingScheduleAdminState();
}

class _PageTeachingScheduleAdminState extends State<PageTeachingScheduleAdmin> {
  int selectedWeek = 1;
  String? selectedDay;
  int fromWeek = 1;
  int toWeek = 1;

  void _showAddSubjectDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Thêm môn học mới'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Tên môn học',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 12),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Lớp học',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 12),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Loại môn',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 12),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Phòng học',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 12),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Tiết học (VD: 1-3)',
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Hủy'),
            ),
            ElevatedButton(
              onPressed: () {
                // Xử lý thêm môn học
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Đã thêm môn học thành công!')),
                );
              },
              child: Text('Thêm'),
            ),
          ],
        );
      },
    );
  }

  // Dữ liệu mẫu thời khóa biểu
  final Map<String, Map<String, List<Subject>>> scheduleData = {
    'Thứ 2': {
      'Sáng': [
        Subject('Chính trị', 'CĐTH22ĐĐE', 'Đại cương', 'F7.4', '1-3'),
        Subject('Toán cao cấp', 'CĐTH22ĐĐE', 'Cơ sở', 'F7.5', '4-6'),
      ],
      'Chiều': [
        Subject('Tiếng Anh', 'CĐTH22ĐĐE', 'Cơ sở', 'F7.3', '7-9'),
        Subject('Tin học văn phòng', 'CĐTH22ĐĐE', 'Đại cương', 'F7.6', '10-12'),
      ],
      'Tối': [
        Subject('Thể dục', 'CĐTH22ĐĐE', 'Đại cương', 'Sân thể thao', '13-15'),
      ],
    },
    'Thứ 3': {
      'Sáng': [
        Subject('Lập trình Java', 'CĐTH22ĐĐE', 'Chuyên môn', 'F7.7', '1-3'),
        Subject('Cơ sở dữ liệu', 'CĐTH22ĐĐE', 'Chuyên môn', 'F7.8', '4-6'),
      ],
      'Chiều': [
        Subject('Mạng máy tính', 'CĐTH22ĐĐE', 'Chuyên môn', 'F7.9', '7-9'),
        Subject('Hệ điều hành', 'CĐTH22ĐĐE', 'Chuyên môn', 'F7.10', '10-12'),
      ],
      'Tối': [],
    },
    'Thứ 4': {
      'Sáng': [
        Subject('Kinh tế chính trị', 'CĐTH22ĐĐE', 'Đại cương', 'F7.2', '1-3'),
        Subject('Triết học', 'CĐTH22ĐĐE', 'Đại cương', 'F7.3', '4-6'),
      ],
      'Chiều': [
        Subject(
          'Phát triển ứng dụng',
          'CĐTH22ĐĐE',
          'Chuyên môn',
          'F7.11',
          '7-9',
        ),
        Subject('Thực hành dự án', 'CĐTH22ĐĐE', 'Chuyên môn', 'F7.12', '10-12'),
      ],
      'Tối': [],
    },
    'Thứ 5': {
      'Sáng': [
        Subject('An toàn thông tin', 'CĐTH22ĐĐE', 'Chuyên môn', 'F7.13', '1-3'),
        Subject(
          'Phân tích thiết kế',
          'CĐTH22ĐĐE',
          'Chuyên môn',
          'F7.14',
          '4-6',
        ),
      ],
      'Chiều': [
        Subject('Quản trị mạng', 'CĐTH22ĐĐE', 'Chuyên môn', 'F7.15', '7-9'),
        Subject(
          'Kỹ thuật phần mềm',
          'CĐTH22ĐĐE',
          'Chuyên môn',
          'F7.16',
          '10-12',
        ),
      ],
      'Tối': [Subject('Seminar', 'CĐTH22ĐĐE', 'Chuyên môn', 'F7.17', '13-15')],
    },
    'Thứ 6': {
      'Sáng': [
        Subject('Đồ án tốt nghiệp', 'CĐTH22ĐĐE', 'Chuyên môn', 'F7.18', '1-6'),
      ],
      'Chiều': [
        Subject(
          'Thực tập doanh nghiệp',
          'CĐTH22ĐĐE',
          'Chuyên môn',
          'F7.19',
          '7-12',
        ),
      ],
      'Tối': [],
    },
    'Thứ 7': {
      'Sáng': [
        Subject('Bổ túc kiến thức', 'CĐTH22ĐĐE', 'Cơ sở', 'F7.20', '1-3'),
        Subject(
          'Tự học có hướng dẫn',
          'CĐTH22ĐĐE',
          'Chuyên môn',
          'F7.21',
          '4-6',
        ),
      ],
      'Chiều': [],
      'Tối': [],
    },
    'Chủ nhật': {'Sáng': [], 'Chiều': [], 'Tối': []},
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Quản lý Thời Khóa Biểu',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        backgroundColor: const Color.fromARGB(255, 106, 14, 148),

        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          if (selectedDay != null)
            IconButton(
              icon: Icon(Icons.clear),
              onPressed: () {
                setState(() {
                  selectedDay = null;
                });
              },
              tooltip: 'Hiển thị tất cả',
            ),
          IconButton(
            icon: Icon(Icons.print),
            onPressed: () => _showPrintDialog(),
            tooltip: 'In thời khóa biểu',
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.purple.shade600, Colors.indigo.shade600],
          ),
        ),
        child: Column(
          children: [
            _buildWeekNavigation(),
            _buildDaySelector(),
            Expanded(
              child: Container(
                margin: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: _buildScheduleView(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWeekNavigation() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Tuần: ',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.9),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: DropdownButton<int>(
              value: selectedWeek,
              underline: SizedBox(),
              icon: Icon(Icons.keyboard_arrow_down, color: Colors.blue[600]),
              style: TextStyle(
                color: Colors.blue[600],
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
              items: List.generate(52, (index) => index + 1).map((week) {
                return DropdownMenuItem<int>(
                  value: week,
                  child: Text('Tuần $week'),
                );
              }).toList(),
              onChanged: (int? newWeek) {
                if (newWeek != null) {
                  setState(() {
                    selectedWeek = newWeek;
                  });
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDaySelector() {
    final days = [
      'Thứ 2',
      'Thứ 3',
      'Thứ 4',
      'Thứ 5',
      'Thứ 6',
      'Thứ 7',
      'Chủ nhật',
    ];

    return Container(
      height: 60,
      margin: EdgeInsets.symmetric(horizontal: 8),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: days.length,
        itemBuilder: (context, index) {
          final day = days[index];
          final isSelected = selectedDay == day;

          return GestureDetector(
            onTap: () {
              setState(() {
                selectedDay = selectedDay == day ? null : day;
              });
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 4, vertical: 8),
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected
                    ? Colors.white
                    : Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isSelected
                      ? Colors.blue[600]!
                      : Colors.white.withOpacity(0.5),
                  width: 2,
                ),
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: Colors.blue.withOpacity(0.3),
                          blurRadius: 8,
                          offset: Offset(0, 2),
                        ),
                      ]
                    : [],
              ),
              child: Center(
                child: Text(
                  day,
                  style: TextStyle(
                    color: isSelected ? Colors.blue[600] : Colors.white,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildScheduleView() {
    // Nếu có chọn ngày cụ thể, chỉ hiển thị ngày đó
    if (selectedDay != null) {
      return SingleChildScrollView(
        child: _buildDaySchedule(selectedDay!, scheduleData[selectedDay!]!),
      );
    }

    // Nếu không chọn ngày, hiển thị tất cả
    return SingleChildScrollView(
      child: Column(
        children: scheduleData.keys.map((day) {
          return _buildDaySchedule(day, scheduleData[day]!);
        }).toList(),
      ),
    );
  }

  Widget _buildDaySchedule(String day, Map<String, List<Subject>> daySchedule) {
    return Container(
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(10),
        boxShadow: selectedDay == day
            ? [
                BoxShadow(
                  color: Colors.blue.withOpacity(0.2),
                  blurRadius: 8,
                  offset: Offset(0, 4),
                ),
              ]
            : [],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: selectedDay == day ? Colors.blue[100] : Colors.blue[50],
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  day,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.blue[800],
                  ),
                ),
                if (selectedDay == null)
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedDay = day;
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.blue[600],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        'Xem chi tiết',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          ...daySchedule.entries.map((entry) {
            return _buildSessionSchedule(entry.key, entry.value);
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildSessionSchedule(String session, List<Subject> subjects) {
    if (subjects.isEmpty) return Container();

    Color sessionColor;
    switch (session) {
      case 'Sáng':
        sessionColor = Colors.orange[100]!;
        break;
      case 'Chiều':
        sessionColor = Colors.green[100]!;
        break;
      case 'Tối':
        sessionColor = Colors.purple[100]!;
        break;
      default:
        sessionColor = Colors.grey[100]!;
    }

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: sessionColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(8),
            child: Text(
              '$session (${_getSessionTime(session)})',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
                color: Colors.grey[700],
              ),
            ),
          ),
          ...subjects.map((subject) => _buildSubjectCard(subject)).toList(),
        ],
      ),
    );
  }

  Widget _buildSubjectCard(Subject subject) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 3,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  subject.name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Colors.blue[800],
                  ),
                ),
              ),
              Text(
                'Tiết ${subject.periods}',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          SizedBox(height: 4),
          Row(
            children: [
              Icon(Icons.class_, size: 14, color: Colors.grey[600]),
              SizedBox(width: 4),
              Text(
                subject.className,
                style: TextStyle(fontSize: 12, color: Colors.grey[700]),
              ),
            ],
          ),
          SizedBox(height: 2),
          Row(
            children: [
              Icon(Icons.category, size: 14, color: Colors.grey[600]),
              SizedBox(width: 4),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: _getSubjectTypeColor(subject.type).withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  subject.type,
                  style: TextStyle(
                    fontSize: 10,
                    color: _getSubjectTypeColor(subject.type),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 2),
          Row(
            children: [
              Icon(Icons.room, size: 14, color: Colors.grey[600]),
              SizedBox(width: 4),
              Text(
                subject.room,
                style: TextStyle(fontSize: 12, color: Colors.grey[700]),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _getSessionTime(String session) {
    switch (session) {
      case 'Sáng':
        return 'Tiết 1-6';
      case 'Chiều':
        return 'Tiết 7-12';
      case 'Tối':
        return 'Tiết 13-15';
      default:
        return '';
    }
  }

  Color _getSubjectTypeColor(String type) {
    switch (type) {
      case 'Đại cương':
        return Colors.orange;
      case 'Cơ sở':
        return Colors.blue;
      case 'Chuyên môn':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  void _showPrintDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              title: Row(
                children: [
                  Icon(Icons.print, color: Colors.blue[600]),
                  SizedBox(width: 8),
                  Text(
                    'In Thời Khóa Biểu',
                    style: TextStyle(
                      color: Colors.blue[600],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              content: Container(
                width: double.maxFinite,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Chọn khoảng tuần cần in:',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: Colors.grey[700],
                      ),
                    ),
                    SizedBox(height: 16),

                    // Từ tuần
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Text(
                            'Từ tuần:',
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey[300]!),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: DropdownButton<int>(
                              value: fromWeek,
                              isExpanded: true,
                              underline: SizedBox(),
                              items: List.generate(52, (index) => index + 1)
                                  .map((week) {
                                    return DropdownMenuItem<int>(
                                      value: week,
                                      child: Text('Tuần $week'),
                                    );
                                  })
                                  .toList(),
                              onChanged: (int? newWeek) {
                                if (newWeek != null) {
                                  setDialogState(() {
                                    fromWeek = newWeek;
                                    if (toWeek < fromWeek) {
                                      toWeek = fromWeek;
                                    }
                                  });
                                }
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12),

                    // Đến tuần
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Text(
                            'Đến tuần:',
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey[300]!),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: DropdownButton<int>(
                              value: toWeek,
                              isExpanded: true,
                              underline: SizedBox(),
                              items: List.generate(52, (index) => index + 1)
                                  .where((week) => week >= fromWeek)
                                  .map((week) {
                                    return DropdownMenuItem<int>(
                                      value: week,
                                      child: Text('Tuần $week'),
                                    );
                                  })
                                  .toList(),
                              onChanged: (int? newWeek) {
                                if (newWeek != null) {
                                  setDialogState(() {
                                    toWeek = newWeek;
                                  });
                                }
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),

                    // Thông tin tóm tắt
                    Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.blue[50],
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.blue[200]!),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.info_outline,
                                size: 16,
                                color: Colors.blue[600],
                              ),
                              SizedBox(width: 4),
                              Text(
                                'Thông tin in:',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.blue[600],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 4),
                          Text(
                            '• Số tuần: ${toWeek - fromWeek + 1} tuần',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[700],
                            ),
                          ),
                          Text(
                            '• Thời gian: Tuần $fromWeek - Tuần $toWeek',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[700],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('Hủy', style: TextStyle(color: Colors.grey[600])),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.of(context).pop();
                    _printSchedule();
                  },
                  icon: Icon(Icons.print, size: 18),
                  label: Text('In TKB'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[600],
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _printSchedule() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        // Delay sau frame để tránh kẹt UI
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Future.delayed(Duration(seconds: 2), () {
            Navigator.of(context).pop(); // Đóng dialog

            ScaffoldMessenger.of(this.context).showSnackBar(
              SnackBar(
                content: Row(
                  children: [
                    Icon(Icons.check_circle, color: Colors.white),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Đã gửi lệnh in TKB từ tuần $fromWeek đến tuần $toWeek thành công!',
                      ),
                    ),
                  ],
                ),
                backgroundColor: Colors.green[600],
                duration: Duration(seconds: 3),
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            );
          });
        });

        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(color: Colors.blue[600]),
              SizedBox(height: 16),
              Text('Đang chuẩn bị in...', style: TextStyle(fontSize: 16)),
              SizedBox(height: 8),
              Text(
                'Tuần $fromWeek - Tuần $toWeek',
                style: TextStyle(color: Colors.grey[600], fontSize: 14),
              ),
            ],
          ),
        );
      },
    );
  }
}

class Subject {
  final String name;
  final String className;
  final String type;
  final String room;
  final String periods;

  Subject(this.name, this.className, this.type, this.room, this.periods);
}
