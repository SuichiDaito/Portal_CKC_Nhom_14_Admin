import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:portal_ckc/api/model/admin_nien_khoa.dart';
import 'package:portal_ckc/bloc/bloc_event_state/tuan_bloc.dart';
import 'package:portal_ckc/bloc/state/tuan_state.dart';

Future<NienKhoa?> showNienKhoaDialog(
  BuildContext context,
  List<NienKhoa> allYears,
) {
  return showDialog<NienKhoa>(
    context: context,
    builder: (ctx) => SimpleDialog(
      title: const Text('Chọn niên khóa'),
      children: allYears.map((nk) {
        return SimpleDialogOption(
          onPressed: () => Navigator.pop(ctx, nk),
          child: Text(nk.tenNienKhoa),
        );
      }).toList(),
    ),
  );
}

Future<int?> showNamHocDialog(BuildContext context, int start, int end) {
  return showDialog<int>(
    context: context,
    builder: (ctx) => SimpleDialog(
      title: const Text('Chọn năm học'),
      children: List.generate(end - start + 1, (i) => start + i).map((year) {
        return SimpleDialogOption(
          onPressed: () => Navigator.pop(ctx, year),
          child: Text('Năm $year'),
        );
      }).toList(),
    ),
  );
}

Future<DateTime?> showDateTrongNamPicker(BuildContext context, int year) {
  final initial = DateTime(year);
  return showDatePicker(
    context: context,
    initialDate: initial,
    firstDate: initial,
    lastDate: DateTime(year, 12, 31),
  );
}

void showTuanListDialog(BuildContext context, int namBatDau) {
  showDialog(
    context: context,
    builder: (ctx) => BlocBuilder<TuanBloc, TuanState>(
      builder: (ctx, state) {
        if (state is TuanLoading) {
          return const AlertDialog(
            content: SizedBox(
              height: 100,
              child: Center(child: CircularProgressIndicator()),
            ),
          );
        } else if (state is TuanLoaded) {
          return AlertDialog(
            title: Text('Danh sách tuần • Năm $namBatDau'),
            content: SizedBox(
              width: double.maxFinite,
              height: 400,
              child: ListView.builder(
                itemCount: state.danhSachTuan.length,
                itemBuilder: (_, i) {
                  final t = state.danhSachTuan[i];
                  return ListTile(
                    title: Text('Tuần ${t.tuan}'),
                    subtitle: Text(
                      '${DateFormat.yMd().format(t.ngayBatDau)} → '
                      '${DateFormat.yMd().format(t.ngayKetThuc)}',
                    ),
                  );
                },
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx),
                child: const Text('Đóng'),
              ),
            ],
          );
        } else if (state is TuanError) {
          return AlertDialog(
            title: const Text('Lỗi'),
            content: Text(state.message),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx),
                child: const Text('Đóng'),
              ),
            ],
          );
        }
        return const SizedBox.shrink();
      },
    ),
  );
}
