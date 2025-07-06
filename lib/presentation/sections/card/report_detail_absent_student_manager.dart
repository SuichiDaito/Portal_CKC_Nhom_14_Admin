import 'package:flutter/material.dart';
import 'package:portal_ckc/api/model/admin_ho_so.dart';
import 'package:portal_ckc/api/model/admin_sinh_vien.dart';

class AbsentStudentManager extends StatelessWidget {
  final List<SinhVien> studentList;
  final List<int> absentStudentIds;
  final void Function(int) onAddAbsentStudent;
  final void Function(int) onRemoveAbsentStudent;
  final Map<int, String> absenceReasons;
  final Map<int, bool> isExcusedMap;
  final void Function(int id, String reason) onReasonChanged;
  final void Function(int id, bool isExcused) onExcusedChanged;

  const AbsentStudentManager({
    super.key,
    required this.studentList,
    required this.absentStudentIds,
    required this.onAddAbsentStudent,
    required this.onRemoveAbsentStudent,
    required this.absenceReasons,
    required this.isExcusedMap,
    required this.onReasonChanged,
    required this.onExcusedChanged,
  });

  @override
  Widget build(BuildContext context) {
    final availableStudents = studentList
        .where((s) => !absentStudentIds.contains(s.id))
        .toList();

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Tìm và chọn sinh viên vắng:',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),

          Autocomplete<SinhVien>(
            optionsBuilder: (TextEditingValue textEditingValue) {
              if (textEditingValue.text.isEmpty) return const Iterable.empty();

              return availableStudents.where((student) {
                final mssv = student.maSv.toLowerCase();
                final name = student.hoSo.hoTen.toLowerCase();
                final query = textEditingValue.text.toLowerCase();
                return mssv.contains(query) || name.contains(query);
              });
            },
            displayStringForOption: (student) =>
                '${student.maSv} - ${student.hoSo.hoTen}',
            fieldViewBuilder:
                (context, controller, focusNode, onFieldSubmitted) {
                  return StatefulBuilder(
                    builder: (context, setState) {
                      controller.addListener(() => setState(() {}));
                      return TextFormField(
                        controller: controller,
                        focusNode: focusNode,
                        decoration: InputDecoration(
                          hintText: 'Nhập tên hoặc MSSV',
                          border: const OutlineInputBorder(),
                          prefixIcon: const Icon(Icons.search),
                          suffixIcon: controller.text.isNotEmpty
                              ? IconButton(
                                  icon: const Icon(Icons.clear),
                                  onPressed: () {
                                    controller.clear();
                                    setState(() {});
                                  },
                                )
                              : null,
                        ),
                      );
                    },
                  );
                },
            onSelected: (student) {
              onAddAbsentStudent(student.id);
              Future.delayed(const Duration(milliseconds: 100), () {
                FocusManager.instance.primaryFocus?.unfocus();
              });
            },
          ),

          const SizedBox(height: 12),

          if (absentStudentIds.isNotEmpty)
            Column(
              children: absentStudentIds.map((id) {
                final student = studentList.firstWhere(
                  (s) => s.id == id,
                  orElse: () => SinhVien(
                    id: id,
                    maSv: '',
                    chucVu: 0,
                    trangThai: 0,
                    hoSo: HoSo(
                      id: -1,
                      hoTen: '',
                      email: '',
                      password: '',
                      soDienThoai: '',
                      ngaySinh: '',
                      gioiTinh: '',
                      cccd: '',
                      diaChi: '',
                      anh: '',
                    ),
                    lop: studentList.first.lop,
                    diemRenLuyens: [],
                  ),
                );

                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 6,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              '${student.maSv} - ${student.hoSo.hoTen}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.close),
                            onPressed: () => onRemoveAbsentStudent(id),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        initialValue: absenceReasons[id] ?? '',
                        decoration: const InputDecoration(
                          labelText: 'Lý do vắng',
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (value) => onReasonChanged(id, value),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Checkbox(
                            value: isExcusedMap[id] ?? false,
                            onChanged: (value) {
                              if (value != null) {
                                onExcusedChanged(id, value);
                              }
                            },
                          ),
                          const Text('Có phép'),
                        ],
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
        ],
      ),
    );
  }
}
