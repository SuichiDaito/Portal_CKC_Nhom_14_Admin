import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:portal_ckc/bloc/bloc_event_state/phong_bloc.dart';
import 'package:portal_ckc/bloc/bloc_event_state/user_bloc.dart';
import 'package:portal_ckc/bloc/state/phong_state.dart';
import 'package:portal_ckc/bloc/state/user_state.dart';

void showCreateExamScheduleDialog(BuildContext context) {
  final TextEditingController durationController = TextEditingController();
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  String? selectedRoom;
  String? selectedProctor1;
  String? selectedProctor2;

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (context) {
      return Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: StatefulBuilder(
            builder: (context, setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Tạo lịch thi lần 2 (thi chung)',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  const SizedBox(height: 12),

                  Row(
                    children: [
                      const Text('Ngày thi:'),
                      const SizedBox(width: 16),
                      Expanded(
                        child: GestureDetector(
                          onTap: () async {
                            final pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime.now().subtract(
                                const Duration(days: 365),
                              ),
                              lastDate: DateTime.now().add(
                                const Duration(days: 365 * 5),
                              ),
                            );
                            if (pickedDate != null) {
                              setState(() => selectedDate = pickedDate);
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              selectedDate != null
                                  ? DateFormat(
                                      'dd/MM/yyyy',
                                    ).format(selectedDate!)
                                  : 'Chọn ngày',
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  Row(
                    children: [
                      const Text('Giờ bắt đầu:'),
                      const SizedBox(width: 16),
                      Expanded(
                        child: GestureDetector(
                          onTap: () async {
                            final pickedTime = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                            );
                            if (pickedTime != null) {
                              setState(() => selectedTime = pickedTime);
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              selectedTime != null
                                  ? selectedTime!.format(context)
                                  : 'Chọn giờ',
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  TextFormField(
                    controller: durationController,
                    decoration: const InputDecoration(
                      labelText: 'Thời gian thi (phút)',
                    ),
                    keyboardType: TextInputType.number,
                  ),

                  const SizedBox(height: 12),
                  DropdownButtonFormField<String>(
                    value: selectedProctor1,
                    decoration: const InputDecoration(labelText: 'Giám thị 1'),
                    items: context.read<UserBloc>().state is UserLoaded
                        ? (context.read<UserBloc>().state as UserLoaded).users
                              .map(
                                (gv) => DropdownMenuItem(
                                  value: gv.id.toString(),
                                  child: Text(gv.hoSo?.hoTen ?? 'Không tên'),
                                ),
                              )
                              .toList()
                        : [],
                    onChanged: (val) => setState(() => selectedProctor1 = val),
                  ),

                  DropdownButtonFormField<String>(
                    value: selectedProctor2,
                    decoration: const InputDecoration(labelText: 'Giám thị 2'),
                    items: context.read<UserBloc>().state is UserLoaded
                        ? (context.read<UserBloc>().state as UserLoaded).users
                              .map(
                                (gv) => DropdownMenuItem(
                                  value: gv.id.toString(),
                                  child: Text(gv.hoSo?.hoTen ?? 'Không tên'),
                                ),
                              )
                              .toList()
                        : [],
                    onChanged: (val) => setState(() => selectedProctor2 = val),
                  ),
                  DropdownButtonFormField<String>(
                    value: selectedRoom,
                    decoration: const InputDecoration(labelText: 'Phòng thi'),
                    items: context.read<PhongBloc>().state is PhongLoaded
                        ? (context.read<PhongBloc>().state as PhongLoaded).rooms
                              .map(
                                (r) => DropdownMenuItem(
                                  value: r.id.toString(),
                                  child: Text(r.ten),
                                ),
                              )
                              .toList()
                        : [],
                    onChanged: (val) => setState(() => selectedRoom = val),
                  ),

                  const SizedBox(height: 16),

                  ElevatedButton(
                    onPressed: () {
                      if (selectedDate == null ||
                          selectedTime == null ||
                          durationController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Vui lòng nhập đầy đủ thông tin'),
                          ),
                        );
                        return;
                      }

                      final String ngayThi = DateFormat(
                        'yyyy-MM-dd',
                      ).format(selectedDate!);
                      final String gioBatDau = selectedTime!.format(context);

                      final int thoiGianThi =
                          int.tryParse(durationController.text) ?? 0;

                      Navigator.of(context).pop();

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Đã tạo lịch thi chung!')),
                      );
                    },
                    child: const Text('Tạo lịch thi chung'),
                  ),
                ],
              );
            },
          ),
        ),
      );
    },
  );
}
