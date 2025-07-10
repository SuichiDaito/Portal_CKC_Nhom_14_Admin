import 'package:flutter/material.dart';
import 'package:portal_ckc/api/model/admin_lop_hoc_phan.dart';
import 'package:portal_ckc/api/model/admin_thong_tin.dart';

class ClassListSection extends StatefulWidget {
  final List<dynamic> classes;

  final Function(String, String, String) onClassInfoChanged;
  final List<User> instructors;
  const ClassListSection({
    Key? key,
    required this.classes,
    required this.onClassInfoChanged,
    required this.instructors,
  }) : super(key: key);

  @override
  State<ClassListSection> createState() => _ClassListSectionState();
}

class _ClassListSectionState extends State<ClassListSection> {
  final Map<String, bool> _editingStates = {};

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
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
          _buildHeader(),
          const SizedBox(height: 20),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: widget.classes.length,
            separatorBuilder: (context, index) => const SizedBox(height: 16),
            itemBuilder: (context, index) {
              final classInfo = widget.classes[index];
              return _buildClassCard(context, classInfo);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: const Color(0xFF1976D2).withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(Icons.class_, color: Color(0xFF1976D2)),
        ),
        const SizedBox(width: 12),
        const Text(
          'Danh sách lớp học phần',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1976D2),
          ),
        ),
      ],
    );
  }

  Widget _buildClassCard(BuildContext context, LopHocPhan classInfo) {
    final key = classInfo.id.toString();
    final isEditing = _editingStates[key] ?? false;
    final instructorItems = widget.instructors;
    final bool isLocked = classInfo.trangThaiNopBangDiem != 0;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            classInfo.lop.tenLop,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 12),

          Row(
            children: [
              Expanded(
                child: _buildInfoRow(
                  Icons.menu_book_outlined,
                  classInfo.tenHocPhan,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildInfoRow(
                  Icons.category_outlined,
                  classInfo.loaiMon.toString(),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),

          Row(
            children: [
              Expanded(
                child: _buildInfoRow(
                  Icons.calendar_today_outlined,
                  'Niên khóa: ${classInfo.lop.nienKhoa.tenNienKhoa ?? "Khong co"}',
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),

          const SizedBox(height: 6),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.person_outline, size: 16, color: Colors.blue),
              const SizedBox(width: 6),
              Expanded(
                child: AbsorbPointer(
                  absorbing: !isEditing || isLocked,
                  child: DropdownButtonFormField<String>(
                    isExpanded: true,
                    value: classInfo.gv?.id != null
                        ? classInfo.gv!.id.toString()
                        : null,
                    items: instructorItems.map((instructor) {
                      return DropdownMenuItem<String>(
                        value: instructor.id.toString(),
                        child: Text(
                          instructor.hoSo?.hoTen ?? 'Không tên',
                          overflow: TextOverflow.ellipsis,
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      if (value != null && !isLocked) {
                        widget.onClassInfoChanged(
                          classInfo.id.toString(),
                          'id_giang_vien',
                          value,
                        );
                      }
                    },
                    decoration: InputDecoration(
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 10,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      filled: !isEditing || isLocked,
                      fillColor: (!isEditing || isLocked)
                          ? Colors.grey.shade100
                          : null,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              IconButton(
                icon: Icon(
                  isEditing ? Icons.check : Icons.edit,
                  color: isEditing
                      ? Colors.green
                      : (isLocked ? Colors.grey.shade400 : Colors.grey),
                ),
                tooltip: isLocked
                    ? 'Không thể chỉnh sửa (Đã nộp bảng điểm)'
                    : (isEditing ? 'Xác nhận' : 'Chỉnh sửa'),
                onPressed: isLocked
                    ? () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: const Text(
                              'Lớp này đã nộp bảng điểm, không thể chỉnh sửa giảng viên!',
                            ),
                            backgroundColor: Colors.redAccent,
                            duration: const Duration(seconds: 2),
                          ),
                        );
                      }
                    : () {
                        setState(() {
                          _editingStates[key] = !isEditing;
                        });
                      },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 16, color: Colors.grey[600]),
        const SizedBox(width: 6),
        Expanded(
          child: Text(
            text,
            style: TextStyle(fontSize: 14, color: Colors.grey[800]),
          ),
        ),
      ],
    );
  }
}
