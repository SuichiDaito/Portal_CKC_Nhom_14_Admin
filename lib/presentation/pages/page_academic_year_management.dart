import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:portal_ckc/api/model/admin_nien_khoa.dart';
import 'package:portal_ckc/api/model/admin_phieu_len_lop.dart';
import 'package:portal_ckc/api/model/admin_tuan.dart';
import 'package:portal_ckc/bloc/bloc_event_state/tuan_bloc.dart';
import 'package:portal_ckc/bloc/event/tuan_event.dart';
import 'package:portal_ckc/bloc/event/nienkhoa_hocky_event.dart';
import 'package:portal_ckc/bloc/state/nienkhoa_hocky_state.dart';
import 'package:portal_ckc/bloc/bloc_event_state/nienkhoa_hocky_bloc.dart';
import 'package:portal_ckc/bloc/state/tuan_state.dart';
import 'package:portal_ckc/presentation/sections/button/app_bar_title.dart';
import 'package:portal_ckc/presentation/sections/dialogs/show_dialog_academic.dart';

class PageAcademicYearManagement extends StatefulWidget {
  const PageAcademicYearManagement({super.key});

  @override
  State<PageAcademicYearManagement> createState() =>
      _PageAcademicYearManagementState();
}

class _PageAcademicYearManagementState extends State<PageAcademicYearManagement>
    with TickerProviderStateMixin {
  List<NienKhoa> allYears = [];
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    context.read<NienKhoaHocKyBloc>().add(FetchNienKhoaHocKy());
  }

  void _initializeAcademicYear(DateTime selectedDate) {
    final dateStr = DateFormat('yyyy-MM-dd').format(selectedDate);
    context.read<TuanBloc>().add(KhoiTaoTuanEvent(dateStr));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Đã gửi yêu cầu khởi tạo tuần')),
    );
  }

  void _showCreateDialog() async {
    final currentYear = DateTime.now().year;

    final selectedYear = await showDialog<int>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Chọn năm học'),
        content: DropdownButton<int>(
          value: currentYear,
          items: List.generate(10, (index) => currentYear + index)
              .map(
                (year) => DropdownMenuItem<int>(
                  value: year,
                  child: Text(year.toString()),
                ),
              )
              .toList(),
          onChanged: (value) {
            Navigator.of(context).pop(value);
          },
        ),
      ),
    );

    if (selectedYear == null) return;

    DateTime? selectedDate;
    do {
      selectedDate = await showDatePicker(
        context: context,
        initialDate: DateTime(selectedYear),
        firstDate: DateTime(selectedYear),
        lastDate: DateTime(selectedYear, 12, 31),
      );

      if (selectedDate == null) return;

      if (selectedDate.weekday != DateTime.monday) {
        await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Lỗi'),
            content: const Text('Bạn chỉ được chọn ngày bắt đầu là Thứ 2!'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          ),
        );
        selectedDate = null;
      }
    } while (selectedDate == null);

    _initializeAcademicYear(selectedDate);
  }

  Widget _buildNienKhoaTab() {
    return BlocBuilder<NienKhoaHocKyBloc, NienKhoaHocKyState>(
      builder: (context, state) {
        if (state is NienKhoaHocKyLoaded) {
          allYears = state.nienKhoas;
          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: allYears.length,
            itemBuilder: (context, index) {
              final nk = allYears[index];
              return Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                color: Colors.white,
                child: Theme(
                  data: Theme.of(
                    context,
                  ).copyWith(dividerColor: Colors.transparent),
                  child: ExpansionTile(
                    title: Text(
                      nk.tenNienKhoa,
                      style: const TextStyle(
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    trailing: const Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: Colors.blueAccent,
                      size: 28,
                    ),
                    children: nk.hocKys.map((hk) {
                      return ListTile(
                        leading: const Icon(Icons.book, color: Colors.blue),
                        title: Text(
                          hk.tenHocKy,
                          style: const TextStyle(
                            color: Colors.black87,
                            fontSize: 15,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              );
            },
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget _buildNamHocTab() {
    int currentYear = DateTime.now().year;
    int selectedYear = currentYear;
    List<TuanModel> weekList = [];

    return StatefulBuilder(
      builder: (context, setState) {
        Future<void> fetchWeeks(int year) async {
          context.read<TuanBloc>().add(FetchTuanEvent(year));
        }

        return BlocListener<TuanBloc, TuanState>(
          listener: (context, state) {
            if (state is TuanLoaded) {
              setState(() {
                weekList = state.danhSachTuan.map((t) => t).toList();
              });
            }
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Chọn năm học:', style: TextStyle(fontSize: 16)),
                    DropdownButton<int>(
                      value: selectedYear,
                      items:
                          List.generate(10, (index) => currentYear - 5 + index)
                              .map(
                                (year) => DropdownMenuItem<int>(
                                  value: year,
                                  child: Text(year.toString()),
                                ),
                              )
                              .toList(),
                      onChanged: (value) {
                        if (value != null) {
                          setState(() {
                            selectedYear = value;
                            weekList = [];
                          });
                          fetchWeeks(value);
                        }
                      },
                    ),
                  ],
                ),
              ),
              ElevatedButton.icon(
                icon: const Icon(Icons.add),
                label: const Text('Khởi tạo tuần'),
                onPressed: () async {
                  final selectedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime(selectedYear),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                  );
                  if (selectedDate != null) {
                    context.read<TuanBloc>().add(
                      KhoiTaoTuanEvent(
                        DateFormat('yyyy-MM-dd').format(selectedDate),
                      ),
                    );
                  }
                },
              ),
              const SizedBox(height: 16),
              if (weekList.isNotEmpty)
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemCount: weekList.length,
                    separatorBuilder: (_, __) => const Divider(),
                    itemBuilder: (context, index) {
                      final tuan = weekList[index];

                      // Định dạng ngày trước khi truyền vào ListTile
                      final inputFormat = DateFormat('yyyy-MM-dd');
                      final outputFormat = DateFormat('dd/MM/yyyy');
                      final startDate = outputFormat.format(tuan.ngayBatDau);
                      final endDate = outputFormat.format(tuan.ngayKetThuc);

                      return ListTile(
                        leading: const Icon(
                          Icons.calendar_today,
                          color: Colors.blue,
                        ),
                        title: Text('Tuần ${tuan.tuan}'),
                        subtitle: Text(
                          'Từ $startDate đến $endDate',
                          style: const TextStyle(color: Colors.grey),
                        ),
                      );
                    },
                  ),
                )
              else
                const Padding(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    'Không có dữ liệu tuần, vui lòng chọn năm.',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
            ],
          ),
        );
      },
    );
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
          final message = state.message.toLowerCase().contains('permission')
              ? 'Bạn không có quyền thực hiện thao tác này.'
              : state.message;

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message), backgroundColor: Colors.red),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const CustomAppBarTitle(title: 'Khởi tạo năm học'),
          backgroundColor: Colors.blueAccent,
          iconTheme: const IconThemeData(color: Colors.white),
          centerTitle: true,
          bottom: TabBar(
            controller: _tabController,
            indicatorColor: Colors.white,
            indicatorWeight: 3,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white30,
            tabs: const [
              Tab(
                icon: Icon(Icons.school, color: Colors.white),
                text: 'Niên khóa',
              ),
              Tab(
                icon: Icon(Icons.calendar_month, color: Colors.white),
                text: 'Năm học',
              ),
            ],
          ),
        ),

        body: TabBarView(
          controller: _tabController,
          children: [_buildNienKhoaTab(), _buildNamHocTab()],
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
