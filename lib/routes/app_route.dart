import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:portal_ckc/api/model/admin_bien_bang_shcn.dart';
import 'package:portal_ckc/api/model/admin_lop.dart';
import 'package:portal_ckc/bloc/bloc_event_state/diem_rl_bloc.dart';
import 'package:portal_ckc/bloc/bloc_event_state/nienkhoa_hocky_bloc.dart';
import 'package:portal_ckc/main.dart';
import 'package:portal_ckc/presentation/pages/appbar_bottombar/page_app_bar.dart';
import 'package:portal_ckc/presentation/pages/appbar_bottombar/page_home_admin.dart';
import 'package:portal_ckc/presentation/pages/page_academic_year_management.dart';
import 'package:portal_ckc/presentation/pages/page_applications_admin.dart';
import 'package:portal_ckc/presentation/pages/page_class_book_admin.dart';
import 'package:portal_ckc/presentation/pages/page_class_detail_admin.dart';
import 'package:portal_ckc/presentation/pages/page_class_management_admin.dart';
import 'package:portal_ckc/presentation/pages/page_class_roster_admin.dart';
import 'package:portal_ckc/presentation/pages/page_class_roster_detail_admin.dart';
import 'package:portal_ckc/presentation/pages/page_conduct_evaluation_admin.dart';
import 'package:portal_ckc/presentation/pages/page_course_assignment_admin.dart';
import 'package:portal_ckc/presentation/pages/page_course_section_student_list.dart';
import 'package:portal_ckc/presentation/pages/page_create_notification_admin.dart';
import 'package:portal_ckc/presentation/pages/page_create_meeting_minutes_admin.dart';
import 'package:portal_ckc/presentation/pages/page_document_request_management_admin.dart';
import 'package:portal_ckc/presentation/pages/page_exam_schedule_admin.dart';
import 'package:portal_ckc/presentation/pages/page_exam_schedule_grouped_admin.dart';
import 'package:portal_ckc/presentation/pages/page_list_class_book_admin.dart';
import 'package:portal_ckc/presentation/pages/page_login.dart';
import 'package:portal_ckc/presentation/pages/page_meeting_minutes_admin.dart';
import 'package:portal_ckc/presentation/pages/page_notification_admin.dart';
import 'package:portal_ckc/presentation/pages/page_notification_detail_admin.dart';
import 'package:portal_ckc/presentation/pages/page_notification_user_admin.dart';
import 'package:portal_ckc/presentation/pages/page_report_detail_admin.dart';
import 'package:portal_ckc/presentation/pages/page_room_management.dart';
import 'package:portal_ckc/presentation/pages/page_schedule_management_admin.dart';
import 'package:portal_ckc/presentation/pages/page_student_management_admin.dart';
import 'package:portal_ckc/presentation/pages/page_teacher_management_admin.dart';
import 'package:portal_ckc/presentation/pages/page_teaching_schedule_admin.dart';
import 'package:portal_ckc/presentation/pages/page_user_detail_information.dart';
import 'package:portal_ckc/presentation/pages/page_main_layout_home_admin.dart';
import 'package:portal_ckc/presentation/references/dashboard_admin.dart';
import 'package:portal_ckc/presentation/references/page_change_password_admin.dart';
import 'package:portal_ckc/presentation/references/page_login_admin.dart';
import 'package:portal_ckc/presentation/references/page_management_group_admin.dart';
import 'package:portal_ckc/presentation/references/page_class_book_admin.dart';
import 'package:portal_ckc/presentation/references/page_infomation_detail_admin.dart';
import 'package:portal_ckc/presentation/sections/notifications_home_admin.dart';

class RouteName {
  static final GlobalKey<NavigatorState> rootNavigatorKey =
      GlobalKey<NavigatorState>();
  static final GlobalKey<NavigatorState> shellNavigatorKey =
      GlobalKey<NavigatorState>();
  static final GlobalKey<NavigatorState> shellAppBarNavigatorKey =
      GlobalKey<NavigatorState>();

  static final GoRouter route = GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: '/login',
    debugLogDiagnostics: true,
    routes: [
      GoRoute(path: '/login', builder: (context, state) => LoginScreen()),
      ShellRoute(
        navigatorKey: shellNavigatorKey,
        builder: (context, state, child) => AdminHomePage(child: child),
        routes: [
          GoRoute(
            path: '/home/admin',
            builder: (context, state) => MainLayoutHomeAdminPage(),
          ),
          ShellRoute(
            navigatorKey: shellAppBarNavigatorKey,
            builder: (context, state, child) =>
                AppBarNavigationHomePage(child: child),
            routes: [
              GoRoute(
                path: '/notifications',
                builder: (context, state) => const NotificationPage(),
              ),
              GoRoute(
                path: '/apps',
                builder: (context, state) => const ApplicationsAdminPage(),
              ),
              GoRoute(
                path: '/admin/information/user',
                builder: (context, state) => const UserDetailInformationPage(),
              ),
            ],
          ),
        ],
      ),
      //============GIẢNG VIÊN============
      //role_id = 5(Giảng Viên)
      //Thông tin giảng viên
      GoRoute(
        path: '/admin/info',
        builder: (context, state) => const PageThongtinAdmin(),
      ),
      //Sổ lên lớp
      GoRoute(
        path: '/admin/class_book_admin',
        builder: (context, state) => const PageClassBookAdmin(),
      ),
      //Đổi mật khẩu
      GoRoute(
        path: '/admin/doimatkhau',
        builder: (context, state) => const PageDoimatkhauAdmin(),
      ),
      //Quản lý lớp chủ nhiệm
      GoRoute(
        path: '/admin/class_management_admin',
        builder: (context, state) => PageClassManagementAdmin(),
      ),
      //Danh sách lớp học phần
      GoRoute(
        path: '/admin/class_roster_admin',
        builder: (context, state) => PageClassRosterAdmin(),
      ),
      //Chi tiết danh sách sinh viên lớp học phần
      GoRoute(
        path: '/admin/course_student_list/:id',
        builder: (context, state) {
          final id = int.tryParse(state.pathParameters['id'] ?? '');
          return PageCourseSectionStudentList(idLopHocPhan: id ?? 0);
        },
      ),
      //chưa sử dụng
      GoRoute(
        path: '/admin/class_roster_detail_admin/:id',
        builder: (context, state) {
          final id = int.tryParse(state.pathParameters['id'] ?? '');
          return PageClassRosterDetailAdmin(idLopHocPhan: id ?? 0);
        },
      ),
      //Chi tiết danh sách lớp chủ nhiệm
      GoRoute(
        path: '/admin/class_detail_admin',
        builder: (context, state) {
          final lop = state.extra as Lop;
          return PageClassDetailAdmin(lop: lop);
        },
      ),
      //Nhập điểm rèn luyện lớp chủ nhiệm
      GoRoute(
        path: '/admin/conduct_evaluation_admin/:lopId/:idNienKhoa',
        builder: (context, state) {
          final lopId = int.parse(state.pathParameters['lopId']!);
          final idNienKhoa = int.parse(state.pathParameters['idNienKhoa']!);
          return MultiBlocProvider(
            providers: [
              BlocProvider(create: (_) => DiemRlBloc()),
              BlocProvider(create: (_) => NienKhoaHocKyBloc()),
            ],
            child: PageConductEvaluationAdmin(
              lopId: lopId,
              idNienKhoa: idNienKhoa,
            ),
          );
        },
      ),
      //Biên bảng sinh hoạt chủ nhiệm
      GoRoute(
        path: '/admin/meeting_minutes_admin',
        builder: (context, state) {
          final lop = state.extra as Lop;
          return PageMeetingMinutesAdmin(lop: lop);
        },
      ),
      GoRoute(
        path: '/admin/report_detail_admin',
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>;
          final bienBan = extra['bienBan'] as BienBanSHCN;

          return PageReportDetailAdmin(bienBan: bienBan);
        },
      ),
      GoRoute(
        path: '/admin/create_meeting_minutes_admin',
        builder: (context, state) {
          final lop = state.extra as Lop;
          return PageCreateMeetingMinutesAdmin(lop: lop);
        },
      ),

      //Thời khóa biểu giảng viên
      GoRoute(
        path: '/admin/teaching_schedule_admin',
        builder: (context, state) => PageTeachingScheduleAdmin(),
      ),
      //Lịch gác thi giảng viên
      GoRoute(
        path: '/admin/exam_schedule_admin',
        builder: (context, state) => PageExamScheduleAdmin(),
      ),
      //Tạo thông báo
      GoRoute(
        path: '/notifications/create',
        builder: (context, state) => PageCreateNotificationAdmin(),
      ),
      //Kho lưu trữ thông báo
      GoRoute(
        path: '/notifications/user',
        builder: (context, state) => PageNotificationUserAdmin(),
      ),
      //Chi tiết thông báo
      GoRoute(
        path: '/notifications/detail/:id',
        builder: (context, state) {
          final id = int.tryParse(state.pathParameters['id'] ?? '') ?? 0;
          return NotificationDetailPage(id: id);
        },
      ),
      //===========ADMIN===========
      //role_id = 1(Trưởng Phòng Đào tạo)//ALL CHỨC NĂNG
      //role_id = 2(Nhân viên phòng CTCT)//ALL CHỨC NĂNG
      //role_id = 3(Nhiên viên phòng đào tạo)

      //1/3
      //Quản lý sổ lên lớp
      GoRoute(
        path: '/admin/class_list_book_admin',
        builder: (context, state) => const PageListClassBookAdmin(),
      ),
      //1/3
      //Quản lý phòng học
      GoRoute(
        path: '/admin/management_group_admin',
        builder: (context, state) => const PageQuanlyphongAdmin(),
      ),
      GoRoute(
        path: '/admin/room_management_admin',
        builder: (context, state) => PageRoomManagement(),
      ),
      //1/3
      //Quản lý lịch tuần/ tạo tkb
      GoRoute(
        path: '/admin/schedule_management_admin',
        builder: (context, state) => PageScheduleManagementAdmin(),
      ),
      //1/3
      //Quản lý sinh viên/ xem danh sách sinh viên của lớp
      GoRoute(
        path: '/admin/student_management_admin',
        builder: (context, state) => PageStudentManagementAdmin(),
      ),
      //1/3
      //Quản lý giảng viên/ xem danh sách giảng viên
      GoRoute(
        path: '/admin/teacher_management_admin',
        builder: (context, state) => PageTeacherManagementAdmin(),
      ),
      //1/2
      //Quản lý/ phân công lịch gác thi
      GoRoute(
        path: '/admin/exam_schedule_groupe_admin',
        builder: (context, state) => PageExamScheduleGroupedAdmin(),
      ),
      //1/2
      //Phân công lớp học phần/ phân công gv vào lớp học phần
      GoRoute(
        path: '/admin/course_assignment_admin',
        builder: (context, state) => PageCourseAssignmentAdmin(),
      ),
      //1/3
      //Quản lý cấp giấy tờ
      GoRoute(
        path: '/admin/decument_request_management_admin',
        builder: (context, state) => PageDocumentRequestManagementAdmin(),
      ),
      //1
      //Khởi tạo năm học
      GoRoute(
        path: '/admin/academic_year_management',
        builder: (context, state) => PageAcademicYearManagement(),
      ),
    ],
  );
}
