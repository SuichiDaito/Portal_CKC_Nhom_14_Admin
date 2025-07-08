// import 'package:flutter/material.dart';
// import 'package:portal_ckc/api/model/admin_lich_thi.dart';
// import 'package:portal_ckc/presentation/sections/card/exam_schedule_card.dart';
// import 'package:portal_ckc/presentation/sections/card/schedule_management_dropdown_item.dart';

// class ExamSchedulesListCard extends StatelessWidget {
//   final List<ExamSchedule> schedules;
//   final ValueChanged<ExamSchedule> onSave;
//   final List<DropdownItem> lecturers;
//   final List<DropdownItem> rooms;
//   final int? trangThaiNopDiem;
//   final bool isNew;

//   const ExamSchedulesListCard({
//     Key? key,
//     required this.schedules,
//     required this.onSave,
//     required this.lecturers,
//     required this.rooms,
//     required this.trangThaiNopDiem,
//     required this.isNew,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: schedules.map((schedule) {
//         return ExamScheduleCard(
//           schedule: schedule,
//           onSave: onSave,
//           lecturers: lecturers,
//           rooms: rooms,
//           trangThaiNopDiem: trangThaiNopDiem,
//           isNew: isNew,
//         );
//       }).toList(),
//     );
//   }
// }
