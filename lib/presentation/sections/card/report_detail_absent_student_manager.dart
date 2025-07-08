import 'package:flutter/material.dart';
import 'package:portal_ckc/api/model/admin_danh_sach_lop.dart';

class AbsentStudentManager extends StatefulWidget {
  final List<StudentWithRole> studentList;
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
  State<AbsentStudentManager> createState() => _AbsentStudentManagerState();
}

class _AbsentStudentManagerState extends State<AbsentStudentManager> {
  @override
  Widget build(BuildContext context) {
    final availableStudents = widget.studentList
        .where((s) => !widget.absentStudentIds.contains(s.idSinhVien))
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

          /// Autocomplete...
          Autocomplete<StudentWithRole>(
            optionsBuilder: (TextEditingValue textEditingValue) {
              if (textEditingValue.text.isEmpty) return const Iterable.empty();
              return availableStudents.where((student) {
                final mssv = student.sinhVien.maSv.toLowerCase();
                final name = student.sinhVien.hoSo.hoTen.toLowerCase();
                final query = textEditingValue.text.toLowerCase();
                return mssv.contains(query) || name.contains(query);
              });
            },
            displayStringForOption: (student) =>
                '${student.sinhVien.maSv} - ${student.sinhVien.hoSo.hoTen}',
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
              widget.onAddAbsentStudent(student.idSinhVien);
              Future.delayed(const Duration(milliseconds: 100), () {
                FocusManager.instance.primaryFocus?.unfocus();
              });
              setState(() {}); // ✅ Refresh UI sau khi chọn
            },
          ),
          const SizedBox(height: 12),

          if (widget.absentStudentIds.isNotEmpty)
            Column(
              children: widget.absentStudentIds.map((id) {
                final student = widget.studentList.firstWhere(
                  (s) => s.idSinhVien == id,
                  orElse: () => StudentWithRole.empty(),
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
                              '${student.sinhVien.maSv} - ${student.sinhVien.hoSo.hoTen}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.close),
                            onPressed: () {
                              widget.onRemoveAbsentStudent(id);
                              setState(() {});
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        initialValue: widget.absenceReasons[id] ?? '',
                        decoration: const InputDecoration(
                          labelText: 'Lý do vắng',
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (value) {
                          widget.onReasonChanged(id, value);
                        },
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Checkbox(
                            value: widget.isExcusedMap[id] ?? false,
                            onChanged: (value) {
                              if (value != null) {
                                widget.onExcusedChanged(id, value);
                                setState(() {});
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
