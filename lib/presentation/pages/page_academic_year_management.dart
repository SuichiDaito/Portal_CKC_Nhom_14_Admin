import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:portal_ckc/api/model/admin_nien_khoa.dart';
import 'package:portal_ckc/bloc/bloc_event_state/tuan_bloc.dart';
import 'package:portal_ckc/bloc/event/tuan_event.dart';
import 'package:portal_ckc/bloc/event/nienkhoa_hocky_event.dart';
import 'package:portal_ckc/bloc/state/nienkhoa_hocky_state.dart';
import 'package:portal_ckc/bloc/bloc_event_state/nienkhoa_hocky_bloc.dart';
import 'package:portal_ckc/bloc/state/tuan_state.dart';
import 'package:portal_ckc/presentation/sections/button/app_bar_title.dart';
import 'package:portal_ckc/presentation/sections/button/year_filter_status_buttons.dart';

class PageAcademicYearManagement extends StatefulWidget {
  const PageAcademicYearManagement({super.key});

  @override
  State<PageAcademicYearManagement> createState() =>
      _PageAcademicYearManagementState();
}

class _PageAcademicYearManagementState
    extends State<PageAcademicYearManagement> {
  List<NienKhoa> _allYears = [];

  void _initializeAcademicYear(DateTime selectedDate) {
    final dateStr = DateFormat('yyyy-MM-dd').format(selectedDate);
    context.read<TuanBloc>().add(KhoiTaoTuanEvent(dateStr));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Đã gửi yêu cầu khởi tạo tuần')),
    );
  }

  void _showCreateDialog() async {
    if (_allYears.isEmpty) return;

    final selectedYear = await showDialog<NienKhoa>(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: const Text('Chọn niên khóa'),
          children: _allYears.map((nk) {
            return SimpleDialogOption(
              onPressed: () => Navigator.pop(context, nk),
              child: Text(nk.tenNienKhoa),
            );
          }).toList(),
        );
      },
    );

    if (selectedYear != null) {
      final parts = selectedYear.tenNienKhoa.split('-');
      final start = int.tryParse(parts[0]) ?? DateTime.now().year;
      final end = int.tryParse(parts[1]) ?? (start + 3);

      final selectedNam = await showDialog<int>(
        context: context,
        builder: (context) => SimpleDialog(
          title: const Text('Chọn năm học'),
          children: List.generate(end - start + 2, (i) => start + i)
              .map(
                (year) => SimpleDialogOption(
                  onPressed: () => Navigator.pop(context, year),
                  child: Text('Năm $year'),
                ),
              )
              .toList(),
        ),
      );

      if (selectedNam != null) {
        final selectedDate = await showDatePicker(
          context: context,
          initialDate: DateTime(selectedNam),
          firstDate: DateTime(selectedNam),
          lastDate: DateTime(selectedNam, 12, 31),
        );
        if (selectedDate != null) {
          _initializeAcademicYear(selectedDate);
        }
      }
    }
  }

  void _showTuanListDialog(BuildContext context, int namBatDau) {
    showDialog(
      context: context,
      builder: (context) {
        return BlocBuilder<TuanBloc, TuanState>(
          builder: (context, state) {
            if (state is TuanLoading) {
              return const AlertDialog(
                content: SizedBox(
                  height: 100,
                  child: Center(child: CircularProgressIndicator()),
                ),
              );
            } else if (state is TuanLoaded) {
              return AlertDialog(
                title: Text('Danh sách tuần - Năm $namBatDau'),
                content: SizedBox(
                  width: double.maxFinite,
                  height: 400,
                  child: ListView.builder(
                    itemCount: state.danhSachTuan.length,
                    itemBuilder: (context, index) {
                      final tuan = state.danhSachTuan[index];
                      return ListTile(
                        title: Text('Tuần ${tuan.tuan}'),
                        subtitle: Text(
                          'Từ ${DateFormat('dd/MM/yyyy').format(tuan.ngayBatDau)} '
                          'đến ${DateFormat('dd/MM/yyyy').format(tuan.ngayKetThuc)}',
                        ),
                      );
                    },
                  ),
                ),
                actions: [
                  TextButton(
                    child: const Text('Đóng'),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              );
            } else if (state is TuanError) {
              return AlertDialog(
                title: const Text('Lỗi'),
                content: Text(state.message),
                actions: [
                  TextButton(
                    child: const Text('Đóng'),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              );
            }
            return const SizedBox.shrink();
          },
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    context.read<NienKhoaHocKyBloc>().add(FetchNienKhoaHocKy());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TuanBloc, TuanState>(
      listener: (context, state) {
        if (state is TuanSuccess) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        } else if (state is TuanError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message), backgroundColor: Colors.red),
          );
        }
      },
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 250, 248, 248),
        appBar: AppBar(
          title: const CustomAppBarTitle(title: 'Khởi tạo năm học'),
          backgroundColor: Colors.blueAccent,
          centerTitle: true,
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        body: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                "Danh Sách Niên Khóa",
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.left,
              ),
            ),
            Divider(),
            const SizedBox(height: 8),
            Expanded(
              child: BlocBuilder<NienKhoaHocKyBloc, NienKhoaHocKyState>(
                builder: (context, state) {
                  if (state is NienKhoaHocKyLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is NienKhoaHocKyLoaded) {
                    _allYears = state.nienKhoas
                        .where((nk) => nk.namBatDau.isNotEmpty)
                        .toList();

                    if (_allYears.isEmpty) {
                      return const Center(
                        child: Text(
                          'Không có niên khóa phù hợp.',
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                      );
                    }

                    return ListView.builder(
                      itemCount: _allYears.length,
                      itemBuilder: (context, index) {
                        final nk = _allYears[index];

                        return Card(
                          elevation: 3,
                          margin: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: ExpansionTile(
                              tilePadding: const EdgeInsets.symmetric(
                                horizontal: 16,
                              ),
                              title: Text(
                                nk.tenNienKhoa,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              subtitle: Text(
                                'Năm bắt đầu: ${nk.namBatDau}',
                                style: const TextStyle(color: Colors.grey),
                              ),
                              trailing: TextButton.icon(
                                icon: const Icon(
                                  Icons.calendar_month,
                                  size: 20,
                                ),
                                label: const Text('Xem tuần'),
                                style: TextButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 4,
                                  ),
                                  foregroundColor: Colors.blueAccent,
                                ),
                                onPressed: () {
                                  final namBatDau = int.tryParse(nk.namBatDau);
                                  if (namBatDau != null) {
                                    context.read<TuanBloc>().add(
                                      FetchTuanEvent(namBatDau),
                                    );
                                    _showTuanListDialog(context, namBatDau);
                                  }
                                },
                              ),
                              children: nk.hocKys.map<Widget>((hk) {
                                final hasStartDate =
                                    hk.ngayBatDau != null &&
                                    hk.ngayBatDau!.isNotEmpty;
                                return ListTile(
                                  title: Text(hk.tenHocKy),
                                  subtitle: Text(
                                    hasStartDate
                                        ? 'Ngày bắt đầu: ${hk.ngayBatDau}'
                                        : 'Chưa khởi tạo ngày bắt đầu',
                                    style: TextStyle(
                                      color: hasStartDate
                                          ? Colors.black87
                                          : Colors.redAccent,
                                      fontSize: 13,
                                    ),
                                  ),
                                  trailing: hasStartDate
                                      ? null
                                      : IconButton(
                                          icon: const Icon(Icons.add),
                                          tooltip: 'Khởi tạo ngày bắt đầu',
                                          onPressed: () async {
                                            final selectedDate =
                                                await showDatePicker(
                                                  context: context,
                                                  initialDate: DateTime.now(),
                                                  firstDate: DateTime(2000),
                                                  lastDate: DateTime(2100),
                                                );
                                            if (selectedDate != null) {
                                              _initializeAcademicYear(
                                                selectedDate,
                                              );
                                            }
                                          },
                                        ),
                                );
                              }).toList(),
                            ),
                          ),
                        );
                      },
                    );
                  } else if (state is NienKhoaHocKyError) {
                    return Center(child: Text(state.message));
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: _showCreateDialog,
          label: const Text("Khởi tạo tuần"),
          icon: const Icon(Icons.add),
        ),
      ),
    );
  }
}
