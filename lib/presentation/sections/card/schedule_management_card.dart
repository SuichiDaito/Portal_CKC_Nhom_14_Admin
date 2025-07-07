import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portal_ckc/api/model/admin_lop_hoc_phan.dart';
import 'package:portal_ckc/api/model/admin_thoi_khoa_bieu.dart';
import 'package:portal_ckc/bloc/bloc_event_state/phong_bloc.dart';
import 'package:portal_ckc/bloc/bloc_event_state/tuan_bloc.dart';
import 'package:portal_ckc/bloc/bloc_event_state/thoi_khoa_bieu_bloc.dart';
import 'package:portal_ckc/bloc/event/thoi_khoa_bieu_event.dart';
import 'package:portal_ckc/bloc/state/phong_state.dart';
import 'package:portal_ckc/bloc/state/thoi_gian_bieu_state.dart';
import 'package:portal_ckc/bloc/state/tuan_state.dart';
import 'package:portal_ckc/presentation/sections/card/schedule_management_detail_editor.dart';
import 'package:portal_ckc/presentation/sections/card/schedule_management_dropdown_item.dart';
import 'package:portal_ckc/presentation/sections/dialogs/copy_week_dialog.dart';

class LopHocPhanCard extends StatelessWidget {
  final LopHocPhan lophp;
  final DropdownItem? selectedWeek;
  final List<DropdownItem> weeks;
  final int? trangThaiNhapDiem;
  const LopHocPhanCard({
    super.key,
    required this.lophp,
    required this.trangThaiNhapDiem,
    required this.selectedWeek,
    required this.weeks,
  });
  String getThuFromDate(DateTime date) {
    final weekdays = [
      'Chủ nhật',
      'Thứ 2',
      'Thứ 3',
      'Thứ 4',
      'Thứ 5',
      'Thứ 6',
      'Thứ 7',
    ];
    return weekdays[date.weekday % 7];
  }

  @override
  Widget build(BuildContext context) {
    final bool canEdit;
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            BlocBuilder<TuanBloc, TuanState>(
              builder: (context, tuanState) {
                if (tuanState is TuanLoaded) {
                  final selectedWeekId = int.tryParse(
                    selectedWeek?.value ?? '0',
                  );
                  final danhSachTuan = tuanState.danhSachTuan;

                  final tuan = danhSachTuan.firstWhere(
                    (t) => t.id == selectedWeekId,
                    orElse: () => danhSachTuan.first,
                  );
                  final ngayBatDau = tuan.ngayBatDau;

                  final tkbTrongTuan = lophp.thoiKhoaBieu
                      .where((tkb) => tkb.idTuan == selectedWeekId)
                      .toList();

                  Map<String, List<ThoiKhoaBieu>> tkbTheoThu = {
                    'Thứ 2': [],
                    'Thứ 3': [],
                    'Thứ 4': [],
                    'Thứ 5': [],
                    'Thứ 6': [],
                    'Thứ 7': [],
                    'Chủ nhật': [],
                  };

                  for (var tkb in tkbTrongTuan) {
                    final ngayHoc = DateTime.parse(tkb.ngay);
                    final thu = getThuFromDate(ngayHoc);
                    if (tkbTheoThu.containsKey(thu)) {
                      tkbTheoThu[thu]!.add(tkb);
                    }
                  }

                  final now = DateTime.now();
                  final canEdit =
                      now.isBefore(ngayBatDau) ||
                      now.isAtSameMomentAs(ngayBatDau);
                  final canEditND = trangThaiNhapDiem != 1;

                  return BlocBuilder<PhongBloc, PhongState>(
                    builder: (context, phongState) {
                      if (phongState is PhongLoaded) {
                        final rooms = phongState.rooms;

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (trangThaiNhapDiem == 1)
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Colors.red.shade100,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Text(
                                  'Lớp này đã hoàn thành, không thể chỉnh sửa lịch học!',
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            if (!canEdit)
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Colors.red.shade100,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Text(
                                  'Tuần này đã bắt đầu, không thể chỉnh sửa lịch học!',
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            const SizedBox(height: 8),

                            ScheduleDetailEditor(
                              lhpId: lophp.id,
                              classSchedule: lophp,
                              rooms: rooms,
                              selectedWeekId: selectedWeekId!,
                              ngayBatDauTuan: ngayBatDau,
                              onSave: (newDetail) {},
                              tkbTheoThu: tkbTheoThu,
                              canEdit: canEditND,
                            ),
                          ],
                        );
                      }
                      return const CircularProgressIndicator();
                    },
                  );
                }
                return const SizedBox();
              },
            ),
            const SizedBox(height: 12),
            BlocListener<ThoiKhoaBieuBloc, ThoiKhoaBieuState>(
              listener: (context, state) {
                if (state is CopyNhieuThoiKhoaBieuSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Sao chép thời khóa biểu thành công!'),
                    ),
                  );
                } else if (state is ThoiKhoaBieuError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.message ?? 'Sao chép thất bại!'),
                    ),
                  );
                }
              },
              child: ElevatedButton.icon(
                icon: const Icon(Icons.copy, color: Colors.white),
                label: const Text(
                  'Sao chép lịch',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: 24,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  showScheduleCopyDialog(
                    context: context,
                    weeks: weeks,
                    onCopy: (sourceWeekId, targetWeekId) {
                      final tkbIdsToCopy = lophp.thoiKhoaBieu
                          .where((tkb) => tkb.idTuan == sourceWeekId)
                          .map((tkb) => tkb.id)
                          .toList();

                      if (tkbIdsToCopy.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Không có thời khóa biểu để sao chép!',
                            ),
                          ),
                        );
                        return;
                      }

                      context.read<ThoiKhoaBieuBloc>().add(
                        CopyNhieuThoiKhoaBieuWeekEvent(
                          tkbIds: tkbIdsToCopy,
                          startWeekId: sourceWeekId,
                          endWeekId: targetWeekId,
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
