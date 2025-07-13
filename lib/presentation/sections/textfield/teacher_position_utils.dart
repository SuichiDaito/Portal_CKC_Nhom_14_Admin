import 'package:portal_ckc/api/model/admin_thong_tin.dart';
import 'package:portal_ckc/presentation/sections/card/schedule_management_dropdown_item.dart';
import 'package:flutter/material.dart';

enum TeacherPosition {
  admin,
  truongPhongDaoTao,
  truongPhongCongTacCT,
  giangVienBoMon,
  giangVienChuNhiem,
  truongKhoa,
}

TeacherPosition getTeacherPositionFromUser(User user) {
  final roleIds = user.roles.map((r) => r.id).toSet();

  if (roleIds.contains(1)) return TeacherPosition.admin;
  if (roleIds.contains(2)) return TeacherPosition.truongPhongDaoTao;
  if (roleIds.contains(3)) return TeacherPosition.truongPhongCongTacCT;
  if (roleIds.contains(4)) return TeacherPosition.giangVienBoMon;
  if (roleIds.contains(5)) return TeacherPosition.giangVienChuNhiem;
  if (roleIds.contains(6)) return TeacherPosition.truongKhoa;

  return TeacherPosition.giangVienBoMon;
}

int getRoleIdFromTeacherPosition(TeacherPosition position) {
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

String getPositionText(TeacherPosition position) {
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

List<DropdownItem> getPositionOptions() {
  return TeacherPosition.values.map((position) {
    return DropdownItem(
      value: position.name,
      label: getPositionText(position),
      icon: Icons.badge,
    );
  }).toList();
}
