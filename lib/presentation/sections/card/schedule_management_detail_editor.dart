import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portal_ckc/api/model/admin_lop_hoc_phan.dart';
import 'package:portal_ckc/api/model/admin_phieu_len_lop.dart';
import 'package:portal_ckc/api/model/admin_phong.dart';
import 'package:portal_ckc/api/model/admin_thoi_khoa_bieu.dart';
import 'package:portal_ckc/bloc/bloc_event_state/thoi_khoa_bieu_bloc.dart';
import 'package:portal_ckc/bloc/event/thoi_khoa_bieu_event.dart';
import 'package:portal_ckc/presentation/sections/button/button_custom_button.dart';
import 'package:portal_ckc/presentation/sections/card/schedule_management_class_info_display.dart';
import 'package:portal_ckc/presentation/sections/card/schedule_management_day_time_picker.dart';
import 'package:portal_ckc/presentation/sections/card/schedule_management_detail_model.dart'
    hide ScheduleDetail;

class ScheduleDetailEditor extends StatefulWidget {
  final LopHocPhan classSchedule;
  final ValueChanged<ScheduleDetail> onSave;
  final List<Room> rooms;
  final int selectedWeekId;
  final DateTime ngayBatDauTuan;
  final int lhpId;
  final Map<String, List<ThoiKhoaBieu>> tkbTheoThu;

  const ScheduleDetailEditor({
    Key? key,
    required this.classSchedule,
    required this.onSave,
    required this.rooms,
    required this.selectedWeekId,
    required this.ngayBatDauTuan,
    required this.lhpId,
    required this.tkbTheoThu,
  }) : super(key: key);

  @override
  State<ScheduleDetailEditor> createState() => _ScheduleDetailEditorState();
}

class _ScheduleDetailEditorState extends State<ScheduleDetailEditor> {
  late TextEditingController _roomController;
  late List<ScheduleTime> _editedSchedules;
  int? selectedRoomId;

  bool _isEditing = false;
  DateTime? getDateFromWeekAndDay(String thu, DateTime ngayBatDau) {
    final thuMap = {
      'Thứ 2': 0,
      'Thứ 3': 1,
      'Thứ 4': 2,
      'Thứ 5': 3,
      'Thứ 6': 4,
      'Thứ 7': 5,
      'Chủ nhật': 6,
    };
    final index = thuMap[thu];
    if (index == null) return null;
    return ngayBatDau.add(Duration(days: index));
  }

  @override
  void initState() {
    super.initState();
    final List<ScheduleTime> schedulesFromTkb = [];

    widget.tkbTheoThu.forEach((thu, tkbList) {
      for (var tkb in tkbList) {
        schedulesFromTkb.add(
          ScheduleTime(
            id: tkb.id,
            ngay: '',
            thu: thu,
            tietBatDau: tkb.tietBatDau,
            tietKetThuc: tkb.tietKetThuc,
            phong: tkb.phong?.ten ?? '',
          ),
        );
      }
    });

    _roomController = TextEditingController(
      text: schedulesFromTkb.isNotEmpty ? schedulesFromTkb.first.phong : '',
    );
    _editedSchedules = schedulesFromTkb;

    selectedRoomId = widget.rooms
        .firstWhere(
          (room) => room.ten == _roomController.text,
          orElse: () => widget.rooms.isNotEmpty
              ? widget.rooms.first
              : Room(id: 0, ten: 'Không xác định', soLuong: 0, loaiPhong: 0),
        )
        .id;
  }

  @override
  void dispose() {
    _roomController.dispose();
    super.dispose();
  }

  void _toggleEditMode() {
    setState(() {
      _isEditing = !_isEditing;

      if (!_isEditing) {
        final List<ScheduleTime> schedulesFromTkb = [];

        widget.tkbTheoThu.forEach((thu, tkbList) {
          for (var tkb in tkbList) {
            schedulesFromTkb.add(
              ScheduleTime(
                id: tkb.id,
                ngay: tkb.ngay,
                thu: thu,
                tietBatDau: tkb.tietBatDau,
                tietKetThuc: tkb.tietKetThuc,
                phong: tkb.phong?.ten ?? '',
              ),
            );
          }
        });

        _roomController = TextEditingController(
          text: schedulesFromTkb.isNotEmpty ? schedulesFromTkb.first.phong : '',
        );
        _editedSchedules = schedulesFromTkb;
      }
    });
  }

  void _saveChanges() {
    final selectedRoom = widget.rooms.firstWhere(
      (room) => room.id == selectedRoomId,
      orElse: () =>
          Room(id: 0, ten: 'Không xác định', soLuong: 0, loaiPhong: 0),
    );

    final newDetail = ScheduleDetail(
      room: selectedRoom.ten,
      schedules: _editedSchedules.where((e) => e.thu.isNotEmpty).toList(),
    );

    widget.onSave(newDetail);

    for (final s in _editedSchedules) {
      if (s.thu.isEmpty) {
        debugPrint(
          '❌ Bỏ qua lịch học thiếu thứ: Tiết ${s.tietBatDau} - ${s.tietKetThuc}',
        );
        continue;
      }

      final ngayDay = getDateFromWeekAndDay(s.thu, widget.ngayBatDauTuan);

      if (ngayDay == null) {
        debugPrint('❌ Không xác định được ngày cho tiết học ${s.thu}');
        continue;
      }

      final newTKB = ThoiKhoaBieu(
        id: 0,
        idLopHocPhan: widget.classSchedule.id,
        idPhong: selectedRoom.id,
        tietBatDau: s.tietBatDau,
        tietKetThuc: s.tietKetThuc,
        ngay: ngayDay.toIso8601String().substring(0, 10),
        idTuan: widget.selectedWeekId,
        phong: Room.empty(),
        lopHocPhan: LopHocPhan.empty(),
        tuan: Tuan.empty(),
      );

      debugPrint(
        '✅ Gửi lịch: ${s.thu} | Tiết ${s.tietBatDau} - ${s.tietKetThuc} | Ngày $ngayDay',
      );

      context.read<ThoiKhoaBieuBloc>().add(CreateThoiKhoaBieuEvent(newTKB));
    }

    setState(() {
      _isEditing = false;
    });

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Đã lưu thay đổi lịch học!')));
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 2.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClassInfoDisplay(classSchedule: widget.classSchedule),
            const SizedBox(height: 16),
            const Text(
              'Thông tin chi tiết lịch học:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<int>(
              value: selectedRoomId,
              decoration: const InputDecoration(
                labelText: 'Phòng học',
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 10,
                ),
              ),
              isExpanded: true,
              items: widget.rooms.map((room) {
                return DropdownMenuItem<int>(
                  value: room.id,
                  child: Text(room.ten),
                );
              }).toList(),
              onChanged: _isEditing
                  ? (value) {
                      setState(() {
                        selectedRoomId = value;
                      });
                    }
                  : null,
            ),

            const SizedBox(height: 12),
            DayTimePicker(
              enabled: _isEditing,
              schedules: _editedSchedules,
              onScheduleChanged: (schedules) {
                if (_isEditing) {
                  setState(() {
                    _editedSchedules = schedules;
                  });

                  debugPrint('📅 Lịch học đã chọn (${schedules.length} mục):');
                  for (var s in schedules) {
                    debugPrint(
                      'Thứ: ${s.thu}, Tiết: ${s.tietBatDau} - ${s.tietKetThuc}',
                    );
                  }
                }
              },
            ),

            const SizedBox(height: 16),
            Align(
              alignment: Alignment.centerRight,
              child: CustomButton(
                text: _isEditing ? 'Lưu' : 'Thay đổi',
                onPressed: () {
                  if (_isEditing) {
                    _saveChanges();
                  } else {
                    _toggleEditMode();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
