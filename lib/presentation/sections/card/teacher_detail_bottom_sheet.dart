import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portal_ckc/api/model/admin_thong_tin.dart';
import 'package:portal_ckc/api/model/admin_vai_tro.dart';
import 'package:portal_ckc/bloc/bloc_event_state/user_bloc.dart';
import 'package:portal_ckc/bloc/event/user_event.dart';
import 'package:portal_ckc/bloc/state/user_state.dart';
import 'package:portal_ckc/presentation/sections/button/button_custom_button.dart';
import 'package:portal_ckc/presentation/sections/card/schedule_management_dropdown_item.dart';
import 'package:portal_ckc/presentation/sections/card/schedule_management_dropdown_selector.dart';

class TeacherDetailBottomSheet extends StatefulWidget {
  final User teacher;
  final ValueChanged<User> onUpdatePosition;

  const TeacherDetailBottomSheet({
    Key? key,
    required this.teacher,
    required this.onUpdatePosition,
  }) : super(key: key);

  @override
  State<TeacherDetailBottomSheet> createState() =>
      _TeacherDetailBottomSheetState();
}

class _TeacherDetailBottomSheetState extends State<TeacherDetailBottomSheet> {
  late TeacherPosition _selectedPosition;
  bool _isEditingPosition = false;

  @override
  void initState() {
    super.initState();
    _selectedPosition = _getTeacherPositionFromUser(widget.teacher);
  }

  TeacherPosition _getTeacherPositionFromUser(User user) {
    final roleIds = user.roles.map((r) => r.id).toSet();

    if (roleIds.contains(1)) return TeacherPosition.admin;
    if (roleIds.contains(2)) return TeacherPosition.truongPhongDaoTao;
    if (roleIds.contains(3)) return TeacherPosition.truongPhongCongTacCT;
    if (roleIds.contains(4)) return TeacherPosition.giangVienBoMon;
    if (roleIds.contains(5)) return TeacherPosition.giangVienChuNhiem;
    if (roleIds.contains(6)) return TeacherPosition.truongKhoa;

    return TeacherPosition.giangVienBoMon;
  }

  int _getRoleIdFromTeacherPosition(TeacherPosition position) {
    switch (position) {
      case TeacherPosition.admin:
        return 1;
      case TeacherPosition.truongPhongDaoTao:
        return 2;
      case TeacherPosition.truongPhongCongTacCT:
        return 3;
      case TeacherPosition.giangVienBoMon:
        return 4;
      case TeacherPosition.giangVienChuNhiem:
        return 5;
      case TeacherPosition.truongKhoa:
        return 6;
    }
  }

  String _getPositionText(TeacherPosition position) {
    switch (position) {
      case TeacherPosition.admin:
        return 'Admin';
      case TeacherPosition.truongPhongDaoTao:
        return 'Trưởng phòng đào tạo';
      case TeacherPosition.truongPhongCongTacCT:
        return 'Trưởng phòng công tác chính trị';
      case TeacherPosition.giangVienBoMon:
        return 'Giảng viên bộ môn';
      case TeacherPosition.giangVienChuNhiem:
        return 'Giảng viên chủ nhiệm';
      case TeacherPosition.truongKhoa:
        return 'Trưởng khoa';
    }
  }

  List<DropdownItem> _getPositionOptions() {
    return TeacherPosition.values.map((position) {
      return DropdownItem(
        value: position.name,
        label: _getPositionText(position),
        icon: Icons.badge,
      );
    }).toList();
  }

  void _savePosition() {
    final newRoleId = _getRoleIdFromTeacherPosition(_selectedPosition);
    final userId = widget.teacher.id;

    context.read<UserBloc>().add(
      UpdateUserRoleEvent(userId: userId, roleId: newRoleId),
    );

    setState(() {
      _isEditingPosition = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = widget.teacher;

    return BlocListener<UserBloc, UserState>(
      listener: (context, state) {
        if (state is UserRoleUpdated) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));

          // Cập nhật lại widget.teacher (nếu backend trả về bản mới)
          final updatedUser = widget.teacher.copyWith(
            roles: [
              Role(
                id: _getRoleIdFromTeacherPosition(_selectedPosition),
                name: _getPositionText(_selectedPosition),
                permissions: [],
              ),
            ],
          );

          widget.onUpdatePosition(updatedUser);

          Navigator.of(context, rootNavigator: true).pop(updatedUser);
        }
        if (state is UserRoleUpdateError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.error)));
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Thông tin chi tiết giáo viên',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.grey),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              const Divider(),
              // _buildInfoRow(
              //   Icons.school,
              //   'Khoa:',
              //   user.boMon!.nganhHoc!.khoa!.tenKhoa,
              // ),
              _buildInfoRow(
                Icons.account_tree,
                'Bộ môn:',
                user.boMon!.tenBoMon,
              ),
              _buildInfoRow(Icons.badge, 'Mã GV:', "GV00${user.id}"),
              _buildInfoRow(Icons.person, 'Tên GV:', user.hoSo!.hoTen),
              _buildInfoRow(
                Icons.email,
                'Email:',
                user.hoSo!.email.isEmpty ? 'Chưa cập nhật' : user.hoSo!.email,
              ),
              _buildInfoRow(
                Icons.phone,
                'SĐT:',
                user.hoSo!.soDienThoai.isEmpty
                    ? 'Chưa cập nhật'
                    : user.hoSo!.soDienThoai,
              ),
              const SizedBox(height: 12),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Chức vụ:',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(width: 10),
                  if (!_isEditingPosition)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: Colors.blue),
                      ),
                      child: Text(
                        widget.teacher.roles.isNotEmpty
                            ? widget.teacher.roles[0].name
                            : 'Không rõ',
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  if (_isEditingPosition)
                    Expanded(
                      child: DropdownSelector(
                        label: '',
                        selectedItem: _getPositionOptions().firstWhere(
                          (item) => item.value == _selectedPosition.name,
                          orElse: () => _getPositionOptions().first,
                        ),
                        items: _getPositionOptions(),
                        onChanged: (item) {
                          if (item != null) {
                            setState(() {
                              _selectedPosition = TeacherPosition.values
                                  .firstWhere((e) => e.name == item.value);
                            });
                          }
                        },
                      ),
                    ),
                ],
              ),

              const SizedBox(height: 20),
              Align(
                alignment: Alignment.centerRight,
                child: CustomButton(
                  text: _isEditingPosition ? 'Lưu chức vụ' : 'Sửa chức vụ',
                  onPressed: () {
                    setState(() {
                      if (_isEditingPosition) {
                        _savePosition();
                      } else {
                        _isEditingPosition = true;
                      }
                    });
                  },
                  backgroundColor: _isEditingPosition
                      ? Colors.green
                      : Colors.blueAccent,
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: Colors.blueAccent),
          const SizedBox(width: 8),
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 16, color: Colors.black54),
            ),
          ),
        ],
      ),
    );
  }
}
