import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portal_ckc/api/model/admin_lop.dart';
import 'package:portal_ckc/api/model/admin_thong_tin.dart';
import 'package:portal_ckc/bloc/bloc_event_state/admin_bloc.dart';
import 'package:portal_ckc/bloc/event/admin_event.dart';
import 'package:portal_ckc/bloc/state/admin_state.dart';
import 'package:portal_ckc/presentation/sections/button/buttons_class_action_class_management.dart';
import 'package:portal_ckc/presentation/sections/dialogs/class_management_dialogs.dart';
import 'package:portal_ckc/presentation/sections/card/class_management_teacher_info_card.dart';
import 'package:portal_ckc/presentation/sections/dialogs/class_meeting_minutes_dialog.dart'
    hide showClassDetailsDialog;
import 'package:portal_ckc/presentation/sections/class_management_class_list_section.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PageClassManagementAdmin extends StatefulWidget {
  const PageClassManagementAdmin({super.key});

  @override
  _PageClassManagementAdminState createState() =>
      _PageClassManagementAdminState();
}

class _PageClassManagementAdminState extends State<PageClassManagementAdmin> {
  late AdminBloc _adminBloc;
  User? _user;
  List<Lop> _classList = [];

  @override
  void initState() {
    super.initState();
    _adminBloc = context.read<AdminBloc>();
    _loadInitialData();
  }

  void _loadInitialData() async {
    final userId = await _getUserId();
    if (userId != null) {
      _adminBloc.add(FetchAdminDetail(userId));
      _adminBloc.add(FetchClassList(userId));
    }
  }

  Future<int?> _getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('user_id');
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdminBloc, AdminState>(
      listener: (context, state) {
        if (state is AdminSuccess) {
          setState(() => _user = state.user);
        } else if (state is ClassListLoaded) {
          setState(() => _classList = state.lops);
          print("Tổng số lớp: ${_classList.length}");
          for (var lop in _classList) {
            print(
              "Tên lớp: ${lop.tenLop}, Năm học: ${lop.nienKhoa.tenNienKhoa}",
            );
          }
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: const Color(0xFFF8F9FA),
          appBar: AppBar(
            title: const Text(
              'Quản Lý Lớp Chủ Nhiệm',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            backgroundColor: const Color(0xFF1976D2),
            elevation: 4,
            centerTitle: true,
            iconTheme: const IconThemeData(color: Colors.white),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (_user != null)
                  TeacherInfoCard(
                    teacherName: _user!.hoSo?.hoTen ?? '',
                    teacherId: _user!.id.toString(),
                    department: _user!.boMon?.tenBoMon ?? '',
                  ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: ButtonsClassActionClassManagementReport(
                        onOpenClassList: () {
                          showClassMeetingListDialog(
                            context,
                            _classList,
                            (selectedClass) {},
                          );
                        },
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ClassActionButtons(
                        onOpenClassList: () {
                          showClassListDialog(
                            context,
                            _classList,
                            (selectedClass) {},
                          );
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                buildClassListSection(
                  classList: _classList,
                  onTapClass: (info) => showClassDetailsDialog(context, info),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
