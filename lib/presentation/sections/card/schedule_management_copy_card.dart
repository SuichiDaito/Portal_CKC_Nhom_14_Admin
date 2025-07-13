import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portal_ckc/bloc/bloc_event_state/tuan_bloc.dart';
import 'package:portal_ckc/bloc/state/tuan_state.dart';
import 'package:portal_ckc/presentation/sections/button/button_custom_button.dart';
import 'package:portal_ckc/presentation/sections/card/schedule_management_dropdown_item.dart';
import 'package:portal_ckc/presentation/sections/card/schedule_management_dropdown_selector.dart';

class ScheduleCopyCard extends StatelessWidget {
  final int currentWeek;
  final VoidCallback onCopySchedule;

  const ScheduleCopyCard({
    super.key,
    required this.currentWeek,
    required this.onCopySchedule,
  });

  @override
  Widget build(BuildContext context) {
    DropdownItem? selectedSourceWeek;
    DropdownItem? selectedTargetWeek;
    List<DropdownItem> weekItems = [];

    return BlocBuilder<TuanBloc, TuanState>(
      builder: (context, tuanState) {
        if (tuanState is TuanLoaded) {
          weekItems = tuanState.danhSachTuan.map((tuan) {
            return DropdownItem(
              value: tuan.id.toString(),
              label: 'Tuần ${tuan.tuan}',
              icon: Icons.calendar_today,
            );
          }).toList();

          selectedSourceWeek ??= weekItems.firstWhere(
            (item) => int.parse(item.value) == currentWeek,
            orElse: () => weekItems.first,
          );
          selectedTargetWeek ??= weekItems.first;

          return Card(
            color: Colors.blue,
            child: Padding(
              padding: EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Sao chép lịch',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                  Divider(),
                  const SizedBox(height: 12),
                  Row(children: [
                      
                    ],
                  ),
                  DropdownSelector(
                    label: 'Tuần nguồn',
                    selectedItem: selectedSourceWeek,
                    items: weekItems,
                    onChanged: (item) {
                      selectedSourceWeek = item;
                    },
                  ),
                  const SizedBox(height: 12),
                  DropdownSelector(
                    label: 'Tuần đích',
                    selectedItem: selectedTargetWeek,
                    items: weekItems,
                    onChanged: (item) {
                      selectedTargetWeek = item;
                    },
                  ),
                  const SizedBox(height: 12),
                  CustomButton(
                    text: 'Sao chép lịch',
                    icon: Icons.copy,
                    onPressed: () {
                      if (selectedSourceWeek == null ||
                          selectedTargetWeek == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Vui lòng chọn đầy đủ tuần nguồn và tuần đích!',
                            ),
                          ),
                        );
                        return;
                      }

                      onCopySchedule();

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Đã sao chép từ tuần ${selectedSourceWeek?.label} sang ${selectedTargetWeek?.label}',
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
