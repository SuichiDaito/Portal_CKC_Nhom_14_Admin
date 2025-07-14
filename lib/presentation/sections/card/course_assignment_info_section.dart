import 'package:flutter/material.dart';
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
  final Function(String) onSubjectChanged;
  final VoidCallback onSave;

  const CourseInfoSection({
    Key? key,
    required this.selectedNienKhoaId,
    required this.selectedHocKy,
    required this.subjects,
    required this.nienKhoas,
    required this.hocKyList,
    required this.onNienKhoaChanged,
    required this.onHocKyChanged,
    required this.selectedSubject,
    required this.onSubjectChanged,
    required this.onSave,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          width: constraints.maxWidth,
          constraints: const BoxConstraints(maxWidth: 600),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 37, 121, 189),
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
              _buildInputField(
                label: 'Niên khóa',
                labelColor: Colors.white,
                child: DropdownButtonFormField<String>(
                  dropdownColor: Colors.white,
                  value: selectedNienKhoaId,
                  decoration: _dropdownDecoration(Icons.calendar_today),
                  style: const TextStyle(color: Colors.blue),
                  iconEnabledColor: Colors.blue,
                  hint: const Text('Chọn niên khóa'),
                  items: nienKhoas.map((nk) {
                    return DropdownMenuItem<String>(
                      value: nk.id.toString(),
                      child: Text(nk.tenNienKhoa),
                    );
                  }).toList(),
                  onChanged: (value) {
                    if (value != null) onNienKhoaChanged(value);
                  },
                ),
              ),
              const SizedBox(height: 16),

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
      fillColor: Colors.white,
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
