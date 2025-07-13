import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portal_ckc/api/model/admin_thong_tin.dart' hide TeacherPosition;
import 'package:portal_ckc/api/model/admin_vai_tro.dart';
import 'package:portal_ckc/bloc/bloc_event_state/user_bloc.dart';
import 'package:portal_ckc/bloc/event/user_event.dart';
import 'package:portal_ckc/bloc/state/user_state.dart';
import 'package:portal_ckc/presentation/sections/button/button_custom_button.dart';
import 'package:portal_ckc/presentation/sections/card/build_infor_cart.dart';
import 'package:portal_ckc/presentation/sections/card/info_row.dart';
import 'package:portal_ckc/presentation/sections/card/schedule_management_dropdown_item.dart';
import 'package:portal_ckc/presentation/sections/card/schedule_management_dropdown_selector.dart';
import 'package:portal_ckc/presentation/sections/textfield/teacher_position_utils.dart';

class TeacherDetailBottomSheet extends StatefulWidget {
  final User teacher;
  final ValueChanged<User> onUpdatePosition;
  final List<User> allTeachers;

  const TeacherDetailBottomSheet({
    Key? key,
    required this.teacher,
    required this.onUpdatePosition,
    required this.allTeachers,
  }) : super(key: key);

  @override
  State<TeacherDetailBottomSheet> createState() =>
      _TeacherDetailBottomSheetState();
}

class _TeacherDetailBottomSheetState extends State<TeacherDetailBottomSheet> {
  late TeacherPosition _selectedPosition;
  bool _isEditingPosition = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _selectedPosition = getTeacherPositionFromUser(widget.teacher);
  }

  bool _isRoleAlreadyAssigned(TeacherPosition position) {
    final roleId = getRoleIdFromTeacherPosition(position);
    if (roleId == 1 || roleId == 2 || roleId == 3) {
      return widget.allTeachers.any(
        (teacher) =>
            teacher.id != widget.teacher.id &&
            teacher.roles.any((role) => role.id == roleId),
      );
    }
    return false;
  }

  Future<void> _showConfirmDialog(Function onConfirm) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Xác nhận'),
        content: const Text('Bạn có chắc chắn muốn đổi chức vụ này không?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Hủy'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Đồng ý'),
          ),
        ],
      ),
    );
    if (confirm == true) onConfirm();
  }

  Future<void> _savePosition() async {
    if (_isRoleAlreadyAssigned(_selectedPosition)) {
      await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Cảnh báo'),
          content: Text(
            'Đã có người giữ chức vụ ${getPositionText(_selectedPosition)}, vui lòng chọn lại!',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Đóng'),
            ),
          ],
        ),
      );
      return;
    }

    await _showConfirmDialog(() {
      final newRoleId = getRoleIdFromTeacherPosition(_selectedPosition);
      final userId = widget.teacher.id;

      setState(() {
        _isLoading = true;
      });

      context.read<UserBloc>().add(
        UpdateUserRoleEvent(userId: userId, roleId: newRoleId),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = widget.teacher;

    return BlocListener<UserBloc, UserState>(
      listener: (context, state) {
        if (state is UserRoleUpdated) {
          setState(() {
            _isLoading = false;
          });

          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));

          Future.delayed(const Duration(milliseconds: 300), () {
            final updatedUser = widget.teacher.copyWith(
              roles: [
                Role(
                  id: getRoleIdFromTeacherPosition(_selectedPosition),
                  name: getPositionText(_selectedPosition),
                  permissions: [],
                ),
              ],
            );

            widget.onUpdatePosition(updatedUser);
            Navigator.of(context, rootNavigator: true).pop(updatedUser);
          });
        }

        if (state is UserRoleUpdateError) {
          setState(() {
            _isLoading = false;
          });

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
              InfoRow(
                icon: Icons.account_tree,
                label: 'Bộ môn:',
                value: user.boMon!.tenBoMon,
              ),
              InfoRow(
                icon: Icons.badge,
                label: 'Mã GV:',
                value: "GV00${user.id}",
              ),
              InfoRow(
                icon: Icons.person,
                label: 'Tên GV:',
                value: user.hoSo!.hoTen,
              ),
              InfoRow(
                icon: Icons.email,
                label: 'Email:',
                value: user.hoSo!.email.isEmpty
                    ? 'Chưa cập nhật'
                    : user.hoSo!.email,
              ),
              InfoRow(
                icon: Icons.phone,
                label: 'SĐT:',
                value: user.hoSo!.soDienThoai.isEmpty
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
                        selectedItem: getPositionOptions().firstWhere(
                          (item) => item.value == _selectedPosition.name,
                          orElse: () => getPositionOptions().first,
                        ),
                        items: getPositionOptions(),
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
                  text: _isLoading
                      ? 'Đang lưu...'
                      : (_isEditingPosition ? 'Lưu chức vụ' : 'Sửa chức vụ'),
                  onPressed: () async {
                    if (_isLoading) return;
                    if (_isEditingPosition) {
                      await _savePosition();
                    } else {
                      setState(() {
                        _isEditingPosition = true;
                      });
                    }
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
}
