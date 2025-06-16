import 'package:flutter/material.dart';

class StudentWithScore {
  final String id;
  final String name;
  String conductScore;
  bool isSelected;

  StudentWithScore({
    required this.id,
    required this.name,
    this.conductScore = '-',
    this.isSelected = false,
  });
}

class PageConductEvaluationAdmin extends StatefulWidget {
  const PageConductEvaluationAdmin({super.key});

  @override
  State<PageConductEvaluationAdmin> createState() =>
      _PageConductEvaluationAdminState();
}

class _PageConductEvaluationAdminState
    extends State<PageConductEvaluationAdmin> {
  List<StudentWithScore> students = [
    StudentWithScore(id: '2012345', name: 'Nguyễn Văn A', conductScore: 'B'),
    StudentWithScore(id: '2012346', name: 'Trần Thị B', conductScore: 'A'),
    StudentWithScore(id: '2012347', name: 'Lê Văn C', conductScore: 'C'),
    StudentWithScore(id: '2012347', name: 'Lê Văn C', conductScore: 'C'),
    StudentWithScore(id: '2012347', name: 'Lê Văn C', conductScore: 'C'),
    StudentWithScore(id: '2012347', name: 'Lê Văn C', conductScore: 'C'),
    StudentWithScore(id: '2012347', name: 'Lê Văn C', conductScore: 'C'),
  ];

  bool selectAll = false;
  String selectedMonth = '1';
  String selectedYear = '2025';
  bool isEditing = false;
  String selectedScore = 'A';

  final List<String> months = List.generate(12, (index) => '${index + 1}');
  final List<String> years = ['2023', '2024', '2025'];

  void _toggleSelectAll(bool? value) {
    setState(() {
      selectAll = value ?? false;
      for (var student in students) {
        student.isSelected = selectAll;
      }
    });
  }

  String _getScoreLabel(String score) {
    switch (score) {
      case 'A':
        return 'Tốt';
      case 'B':
        return 'Khá';
      case 'C':
        return 'Trung bình';
      case 'D':
        return 'Yếu';
      case 'E':
        return 'Kém';
      case 'F':
        return 'Rất kém';
      default:
        return 'Chưa có';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        title: const Text(
          'Nhập điểm rèn luyện',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: const Color(0xFF1976D2),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: const LinearGradient(
                colors: [Color(0xFF1976D2), Color(0xFF42A5F5)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.calendar_today, color: Colors.white70),
                    const SizedBox(width: 8),
                    const Text(
                      'Chọn tháng và năm:',
                      style: TextStyle(color: Colors.white70, fontSize: 16),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    const Text(
                      'Tháng:',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 8),
                    DropdownButton<String>(
                      dropdownColor: Colors.blue,
                      value: selectedMonth,
                      onChanged: (value) =>
                          setState(() => selectedMonth = value ?? '1'),
                      items: months
                          .map(
                            (m) => DropdownMenuItem(value: m, child: Text(m)),
                          )
                          .toList(),
                      style: const TextStyle(color: Colors.white),
                      iconEnabledColor: Colors.white,
                    ),
                    const SizedBox(width: 24),
                    const Text(
                      'Năm:',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 8),
                    DropdownButton<String>(
                      dropdownColor: Colors.blue,
                      value: selectedYear,
                      onChanged: (value) =>
                          setState(() => selectedYear = value ?? '2025'),
                      items: years
                          .map(
                            (y) => DropdownMenuItem(value: y, child: Text(y)),
                          )
                          .toList(),
                      style: const TextStyle(color: Colors.white),
                      iconEnabledColor: Colors.white,
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {
                        setState(() {
                          isEditing = !isEditing;
                          if (!isEditing) {
                            // Nếu vừa tắt chế độ sửa thì bỏ chọn tất cả
                            for (var s in students) {
                              s.isSelected = false;
                            }
                            selectAll = false;
                          }
                        });
                      },
                      icon: Icon(isEditing ? Icons.close : Icons.edit),
                      label: Text(isEditing ? 'Huỷ sửa' : 'Sửa điểm'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: const Color(0xFF1976D2),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 12,
                        ),
                      ),
                    ),

                    const SizedBox(width: 12),
                    ElevatedButton.icon(
                      onPressed: () async {
                        // final selectedMonthInt = int.parse(selectedMonth);
                        // final selectedYearInt = int.parse(selectedYear);
                        // final updatedStudents = students
                        //     .where((s) => s.conductScore != '-')
                        //     .toList();

                        // Gửi dữ liệu hoặc lưu DB
                        // await ConductService.saveScores(updatedStudents, selectedMonthInt, selectedYearInt);

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Đã lưu điểm rèn luyện'),
                          ),
                        );
                      },
                      icon: const Icon(Icons.save),
                      label: const Text('Lưu'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Row(
              children: [
                if (isEditing)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        Checkbox(value: selectAll, onChanged: _toggleSelectAll),
                        const Text('Chọn tất cả'),
                        const SizedBox(width: 12),
                        if (isEditing)
                          DropdownButton<String>(
                            value: selectedScore,
                            onChanged: (value) {
                              if (value == null) return;
                              setState(() {
                                selectedScore = value;
                                for (var student in students) {
                                  if (student.isSelected) {
                                    student.conductScore = selectedScore;
                                  }
                                }
                              });
                            },
                            items: ['A', 'B', 'C', 'D', 'E', 'F']
                                .map(
                                  (e) => DropdownMenuItem(
                                    value: e,
                                    child: Text(e),
                                  ),
                                )
                                .toList(),
                          ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: students.length,
                    itemBuilder: (context, index) {
                      final student = students[index];
                      return Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                          border: Border.all(color: Colors.blue.shade100),
                        ),
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          leading: isEditing
                              ? Checkbox(
                                  value: student.isSelected,
                                  onChanged: (value) => setState(
                                    () => student.isSelected = value ?? false,
                                  ),
                                )
                              : null,
                          title: Text(
                            student.name,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                          subtitle: Text('MSSV: ${student.id}'),
                          trailing: isEditing
                              ? DropdownButton<String>(
                                  value: student.conductScore == '-'
                                      ? null
                                      : student.conductScore,
                                  hint: const Text('Chọn điểm'),
                                  onChanged: (value) {
                                    setState(() {
                                      student.conductScore = value ?? '-';
                                    });
                                  },
                                  items: ['A', 'B', 'C', 'D', 'E', 'F']
                                      .map(
                                        (e) => DropdownMenuItem(
                                          value: e,
                                          child: Text(e),
                                        ),
                                      )
                                      .toList(),
                                )
                              : Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      'Điểm: ${student.conductScore}',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    Text(
                                      _getScoreLabel(student.conductScore),
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: student.conductScore == 'A'
                                            ? Colors.green
                                            : Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 16, bottom: 12),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      'Tháng $selectedMonth - Năm $selectedYear',
                      style: const TextStyle(
                        fontStyle: FontStyle.italic,
                        color: Colors.blueGrey,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
