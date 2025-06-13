import 'package:flutter/material.dart';

class Student {
  final String mssv;
  final String hoTen;
  String diemRenLuyen; // changed from double
  String trangThai;
  bool isSelected;

  Student({
    required this.mssv,
    required this.hoTen,
    required this.diemRenLuyen,
    required this.trangThai,
    this.isSelected = false,
  });
}

class PageStudentConductScore extends StatefulWidget {
  @override
  _PageStudentConductScoreState createState() =>
      _PageStudentConductScoreState();
}

class _PageStudentConductScoreState extends State<PageStudentConductScore> {
  String getTrangThaiFromDiem(String diem) {
    switch (diem.toUpperCase()) {
      case "A":
        return "Xuất sắc";
      case "B":
        return "Tốt";
      case "C":
        return "Khá";
      case "D":
        return "Trung bình";
      case "F":
        return "Yếu";
      default:
        return "Không hợp lệ";
    }
  }

  List<Student> students = [
    Student(
      mssv: "SV001",
      hoTen: "Nguyễn Văn An",
      diemRenLuyen: "B",
      trangThai: "Tốt",
    ),
    Student(
      mssv: "SV002",
      hoTen: "Trần Thị Bình",
      diemRenLuyen: "A",
      trangThai: "Xuất sắc",
    ),
    Student(
      mssv: "SV003",
      hoTen: "Lê Văn Cường",
      diemRenLuyen: "C",
      trangThai: "Khá",
    ),
    Student(
      mssv: "SV004",
      hoTen: "Phạm Thị Dung",
      diemRenLuyen: "A",
      trangThai: "Xuất sắc",
    ),
    Student(
      mssv: "SV005",
      hoTen: "Hoàng Văn Em",
      diemRenLuyen: "D",
      trangThai: "Trung bình",
    ),
  ];

  int selectedYear = DateTime.now().year;
  int selectedMonth = DateTime.now().month;
  bool isEditMode = false;
  TextEditingController diemController = TextEditingController();
  String? selectedDiem; // A, B, C, D, F

  Color getTrangThaiColor(String trangThai) {
    switch (trangThai) {
      case "Xuất sắc":
        return Colors.green[700]!;
      case "Tốt":
        return Colors.green;
      case "Khá":
        return Colors.blue;
      case "Trung bình":
        return Colors.orange;
      case "Yếu":
        return Colors.red[300]!;
      case "Kém":
        return Colors.red[700]!;
      default:
        return Colors.grey;
    }
  }

  void toggleEditMode() {
    setState(() {
      isEditMode = !isEditMode;
      if (!isEditMode) {
        // Reset selection khi thoát edit mode
        for (var student in students) {
          student.isSelected = false;
        }
      }
    });
  }

  void updateSelectedStudents() {
    if (selectedDiem == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Vui lòng chọn điểm rèn luyện")));
      return;
    }

    int updatedCount = 0;
    setState(() {
      for (var student in students) {
        if (student.isSelected) {
          student.diemRenLuyen = selectedDiem!;
          student.trangThai = getTrangThaiFromDiem(selectedDiem!);
          student.isSelected = false;
          updatedCount++;
        }
      }
      isEditMode = false;
      selectedDiem = null;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Đã cập nhật điểm cho $updatedCount sinh viên")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(
      //     "Quản lý điểm rèn luyện",
      //     style: TextStyle(fontWeight: FontWeight.bold),
      //   ),
      //   backgroundColor: Colors.blue[700],
      //   foregroundColor: Colors.white,
      //   elevation: 2,
      // ),
      body: Column(
        children: [
          Container(
            height: 60,
            padding: EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.indigo.shade600, Colors.purple.shade600],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.indigo.withOpacity(0.3),
                  blurRadius: 20,
                  offset: Offset(0, 10),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () {
                    Navigator.pop(context); // Quay lại trang trước
                  },
                ),
                SizedBox(width: 8),
                Text(
                  "Nhập điểm rèn luyện",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          // Header với chọn năm, tháng và nút sửa điểm
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              border: Border(bottom: BorderSide(color: Colors.grey[300]!)),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Text(
                            "Năm: ",
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                          DropdownButton<int>(
                            value: selectedYear,
                            items:
                                List.generate(
                                      5,
                                      (index) => DateTime.now().year - index,
                                    )
                                    .map(
                                      (year) => DropdownMenuItem(
                                        value: year,
                                        child: Text(year.toString()),
                                      ),
                                    )
                                    .toList(),
                            onChanged: (value) {
                              setState(() {
                                selectedYear = value!;
                              });
                            },
                          ),
                          SizedBox(width: 20),
                          Text(
                            "Tháng: ",
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                          DropdownButton<int>(
                            value: selectedMonth,
                            items: List.generate(12, (index) => index + 1)
                                .map(
                                  (month) => DropdownMenuItem(
                                    value: month,
                                    child: Text("Tháng $month"),
                                  ),
                                )
                                .toList(),
                            onChanged: (value) {
                              setState(() {
                                selectedMonth = value!;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed: toggleEditMode,
                      icon: Icon(isEditMode ? Icons.close : Icons.edit),
                      label: Text(isEditMode ? "Hủy" : "Sửa điểm"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isEditMode
                            ? Colors.grey[600]
                            : Colors.indigo,
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ],
                ),
                if (isEditMode) ...[
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          value: selectedDiem,
                          onChanged: (value) {
                            setState(() {
                              selectedDiem = value!;
                            });
                          },
                          items: ["A", "B", "C", "D", "F"]
                              .map(
                                (diem) => DropdownMenuItem(
                                  value: diem,
                                  child: Text("Điểm $diem"),
                                ),
                              )
                              .toList(),
                          decoration: InputDecoration(
                            labelText: "Chọn điểm rèn luyện",
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                          ),
                        ),
                      ),

                      SizedBox(width: 12),
                      ElevatedButton.icon(
                        onPressed: updateSelectedStudents,
                        icon: Icon(Icons.save),
                        label: Text("Lưu"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green[600],
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),

          // Danh sách sinh viên
          Expanded(
            child: ListView.builder(
              itemCount: students.length,
              itemBuilder: (context, index) {
                final student = students[index];
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  elevation: 2,
                  child: ListTile(
                    leading: isEditMode
                        ? Checkbox(
                            value: student.isSelected,
                            onChanged: (value) {
                              setState(() {
                                student.isSelected = value ?? false;
                              });
                            },
                          )
                        : CircleAvatar(
                            backgroundColor: Colors.blue[100],
                            child: Text(
                              student.mssv.substring(2),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.blue[700],
                              ),
                            ),
                          ),
                    title: Text(
                      student.hoTen,
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("MSSV: ${student.mssv}"),
                        Row(
                          children: [
                            Text("Điểm: ${student.diemRenLuyen}"),
                            SizedBox(width: 12),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: getTrangThaiColor(
                                  student.trangThai,
                                ).withOpacity(0.1),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: getTrangThaiColor(student.trangThai),
                                  width: 1,
                                ),
                              ),
                              child: Text(
                                student.trangThai,
                                style: TextStyle(
                                  color: getTrangThaiColor(student.trangThai),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    trailing: !isEditMode
                        ? IconButton(
                            icon: Icon(
                              Icons.edit_outlined,
                              color: Colors.blue[600],
                            ),
                            onPressed: () {
                              _showEditDialog(context, student);
                            },
                          )
                        : null,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showEditDialog(BuildContext context, Student student) {
    String selectedDiemDialog = student.diemRenLuyen; // điểm hiện tại

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Sửa điểm rèn luyện"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Sinh viên: ${student.hoTen}"),
            Text("MSSV: ${student.mssv}"),
            SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: selectedDiemDialog,
              onChanged: (value) {
                setState(() {
                  selectedDiemDialog = value!;
                });
              },
              items: ["A", "B", "C", "D", "F"]
                  .map(
                    (diem) => DropdownMenuItem(
                      value: diem,
                      child: Text("Điểm $diem"),
                    ),
                  )
                  .toList(),
              decoration: InputDecoration(
                labelText: "Chọn điểm rèn luyện",
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Hủy"),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                student.diemRenLuyen = selectedDiemDialog;
                student.trangThai = getTrangThaiFromDiem(selectedDiemDialog);
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Đã cập nhật điểm cho ${student.hoTen}"),
                ),
              );
            },
            child: Text("Lưu"),
          ),
        ],
      ),
    );
  }
}
