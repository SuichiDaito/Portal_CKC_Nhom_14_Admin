import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:portal_ckc/api/model/admin_hoc_ky.dart';

class CourseInfoSection extends StatelessWidget {
  final String? selectedNienKhoaId;
  final HocKy? selectedHocKy;
  final List<String> subjects;
  final List<dynamic> nienKhoas;
  final List<HocKy> hocKyList;
  final Function(String) onNienKhoaChanged;
  final Function(HocKy) onHocKyChanged;
  final String selectedSubject;
=======

class CourseInfoSection extends StatelessWidget {
  final String selectedAcademicYear;
  final String selectedSemester;
  final String selectedSubject;
  final Function(String) onAcademicYearChanged;
  final Function(String) onSemesterChanged;
>>>>>>> main
  final Function(String) onSubjectChanged;
  final VoidCallback onSave;

  const CourseInfoSection({
    Key? key,
<<<<<<< HEAD
    required this.selectedNienKhoaId,
    required this.selectedHocKy,
    required this.subjects,
    required this.nienKhoas,
    required this.hocKyList,
    required this.onNienKhoaChanged,
    required this.onHocKyChanged,
    required this.selectedSubject,
=======
    required this.selectedAcademicYear,
    required this.selectedSemester,
    required this.selectedSubject,
    required this.onAcademicYearChanged,
    required this.onSemesterChanged,
>>>>>>> main
    required this.onSubjectChanged,
    required this.onSave,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
=======
    final academicYears = ['2022-2023', '2023-2024', '2024-2025'];

>>>>>>> main
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          width: constraints.maxWidth,
          constraints: const BoxConstraints(maxWidth: 600),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
<<<<<<< HEAD
            color: const Color.fromARGB(255, 37, 121, 189),
=======
            color: const Color.fromARGB(255, 37, 121, 189), // Nền xanh
>>>>>>> main
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.blue.shade100.withOpacity(0.3),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
<<<<<<< HEAD
=======
              // Header
>>>>>>> main
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.school,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    'Thông tin khóa học',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

<<<<<<< HEAD
=======
              // Academic Year Dropdown
>>>>>>> main
              _buildInputField(
                label: 'Niên khóa',
                labelColor: Colors.white,
                child: DropdownButtonFormField<String>(
                  dropdownColor: Colors.white,
<<<<<<< HEAD
                  value: selectedNienKhoaId,
=======
                  value: selectedAcademicYear.isNotEmpty
                      ? selectedAcademicYear
                      : null,
>>>>>>> main
                  decoration: _dropdownDecoration(Icons.calendar_today),
                  style: const TextStyle(color: Colors.blue),
                  iconEnabledColor: Colors.blue,
                  hint: const Text('Chọn niên khóa'),
<<<<<<< HEAD
                  items: nienKhoas.map((nk) {
                    return DropdownMenuItem<String>(
                      value: nk.id.toString(),
                      child: Text(nk.tenNienKhoa),
                    );
                  }).toList(),
                  onChanged: (value) {
                    if (value != null) onNienKhoaChanged(value);
=======
                  items: academicYears.map((year) {
                    return DropdownMenuItem<String>(
                      value: year,
                      child: Text(year),
                    );
                  }).toList(),
                  onChanged: (value) {
                    if (value != null) onAcademicYearChanged(value);
>>>>>>> main
                  },
                ),
              ),
              const SizedBox(height: 16),

<<<<<<< HEAD
              _buildInputField(
                label: 'Học kì',
                labelColor: Colors.white,
                child: DropdownButtonFormField<HocKy>(
                  dropdownColor: Colors.white,
                  value: selectedHocKy,
                  decoration: _dropdownDecoration(Icons.schedule),
                  style: const TextStyle(color: Colors.blue),
                  iconEnabledColor: Colors.blue,
                  hint: const Text('Chọn học kỳ'),
                  items: hocKyList.map((hk) {
                    return DropdownMenuItem<HocKy>(
                      value: hk,
                      child: Text(hk.tenHocKy),
                    );
                  }).toList(),
                  onChanged: (value) {
                    if (value != null) onHocKyChanged(value);
                  },
                ),
              ),
              const SizedBox(height: 16),

              _buildInputField(
                label: 'Môn học',
                labelColor: Colors.white,

                child: DropdownButtonFormField<String>(
                  dropdownColor: Colors.white,
                  value:
                      (selectedSubject.isNotEmpty &&
                          subjects.contains(selectedSubject))
                      ? selectedSubject
                      : null,

                  isExpanded: true,
                  decoration: _dropdownDecoration(Icons.book),
                  style: const TextStyle(color: Colors.blue),
                  iconEnabledColor: Colors.blue,
                  hint: const Text('Chọn môn học'),
                  items: subjects.toSet().map((value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value, overflow: TextOverflow.ellipsis),
                    );
                  }).toList(),
                  onChanged: (value) {
                    if (value != null) onSubjectChanged(value);
                  },
                ),
              ),
              // const SizedBox(height: 20),

              // Align(
              //   alignment: Alignment.centerRight,
              //   child: ElevatedButton.icon(
              //     onPressed: onSave,
              //     icon: const Icon(Icons.save),
              //     label: const Text('Lưu'),
              //     style: ElevatedButton.styleFrom(
              //       backgroundColor: Colors.white,
              //       foregroundColor: const Color(0xFF1976D2),
              //     ),
              //   ),
              // ),
=======
              // Semester and Subject Row
              Row(
                children: [
                  Expanded(
                    child: _buildInputField(
                      label: 'Học kì',
                      labelColor: Colors.white,
                      child: DropdownButtonFormField<String>(
                        dropdownColor: Colors.white,
                        value: selectedSemester,
                        decoration: _dropdownDecoration(Icons.schedule),
                        style: const TextStyle(color: Colors.blue),
                        iconEnabledColor: Colors.blue,
                        items: ['1', '2', '3'].map((value) {
                          return DropdownMenuItem(
                            value: value,
                            child: Text('Học kì $value'),
                          );
                        }).toList(),
                        onChanged: (value) {
                          if (value != null) onSemesterChanged(value);
                        },
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildInputField(
                      label: 'Môn học',
                      labelColor: Colors.white,
                      child: DropdownButtonFormField<String>(
                        dropdownColor: Colors.white,
                        value: selectedSubject,
                        isExpanded: true,
                        decoration: _dropdownDecoration(Icons.book),
                        style: const TextStyle(color: Colors.blue),
                        iconEnabledColor: Colors.blue,
                        items:
                            [
                              'Toán cao cấp',
                              'Lập trình Java',
                              'Cơ sở dữ liệu',
                              'Mạng máy tính',
                              'Kỹ thuật phần mềm',
                            ].map((value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              );
                            }).toList(),
                        onChanged: (value) {
                          if (value != null) onSubjectChanged(value);
                        },
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Save Button (optional - thêm nếu cần)
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton.icon(
                  onPressed: onSave,
                  icon: const Icon(Icons.save),
                  label: const Text('Lưu'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: const Color(0xFF1976D2),
                  ),
                ),
              ),
>>>>>>> main
            ],
          ),
        );
      },
    );
  }

  InputDecoration _dropdownDecoration(IconData icon) {
    return InputDecoration(
      prefixIcon: Icon(icon, color: Colors.blue),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.white.withOpacity(0.6)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.white.withOpacity(0.6)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.white, width: 2),
      ),
      filled: true,
<<<<<<< HEAD
      fillColor: Colors.white,
=======
      fillColor: Colors.white, // Dropdown bên trong vẫn nền trắng
>>>>>>> main
    );
  }

  Widget _buildInputField({
    required String label,
    required Widget child,
    Color labelColor = Colors.black,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: labelColor,
          ),
        ),
        const SizedBox(height: 8),
        child,
      ],
    );
  }
}
