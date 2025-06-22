import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portal_ckc/api/model/admin_thong_tin.dart';
import 'package:portal_ckc/bloc/bloc_event_state/role_bloc.dart';
import 'package:portal_ckc/bloc/event/role_event.dart';
import 'package:portal_ckc/bloc/state/role_state.dart';
import 'package:portal_ckc/presentation/sections/button/button_custom_button.dart';

class FilterButtonsRowTeacher extends StatelessWidget {
  final TeacherPosition? currentFilter;
  final ValueChanged<TeacherPosition?> onFilterChanged;

  const FilterButtonsRowTeacher({
    Key? key,
    required this.currentFilter,
    required this.onFilterChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RoleBloc, RoleState>(
      builder: (context, state) {
        if (state is RoleLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is RoleLoaded) {
          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  _buildFilterButton('Tất cả', null),
                  const SizedBox(width: 8),
                  ...state.roles
                      .where((role) => _mapRoleIdToPosition(role.id) != null)
                      .map((role) {
                        final position = _mapRoleIdToPosition(role.id);
                        return Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: _buildFilterButton(role.name, position),
                        );
                      })
                      .toList(),
                ],
              ),
            ),
          );
        } else if (state is RoleError) {
          return Center(child: Text('Lỗi: \${state.message}'));
        } else {
          context.read<RoleBloc>().add(FetchRolesEvent());
          return const SizedBox.shrink();
        }
      },
    );
  }

  TeacherPosition? _mapRoleIdToPosition(int id) {
    switch (id) {
      case 1:
        return TeacherPosition.director; // trưởng phòng đào tạo
      case 2:
        return TeacherPosition.dean; // trưởng khoa
      case 3:
        return TeacherPosition.viceDean; // trưởng bộ môn
      case 4:
        return TeacherPosition.staff; // trưởng phòng CTSV
      case 5:
        return TeacherPosition.lecturer; // giảng viên
      default:
        return null;
    }
  }

  Widget _buildFilterButton(String text, TeacherPosition? position) {
    final bool isSelected = currentFilter == position;
    return CustomButton(
      text: text,
      onPressed: () => onFilterChanged(position),
      backgroundColor: isSelected ? Colors.blueAccent : Colors.grey.shade300,
      textColor: isSelected ? Colors.white : Colors.black87,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      borderRadius: BorderRadius.circular(20),
    );
  }
}
