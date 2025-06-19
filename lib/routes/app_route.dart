import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:portal_ckc/api/model/admin_lop.dart';
import 'package:portal_ckc/main.dart';
import 'package:portal_ckc/presentation/pages/appbar_bottombar/page_app_bar.dart';
import 'package:portal_ckc/presentation/pages/page_academic_year_management.dart';
import 'package:portal_ckc/presentation/pages/page_class_book_admin.dart';
import 'package:portal_ckc/presentation/pages/page_class_detail_admin.dart';
import 'package:portal_ckc/presentation/pages/page_class_management_admin.dart';
import 'package:portal_ckc/presentation/pages/page_class_roster_admin.dart';
import 'package:portal_ckc/presentation/pages/page_conduct_evaluation_admin.dart';
import 'package:portal_ckc/presentation/pages/page_course_assignment_admin.dart';
import 'package:portal_ckc/presentation/pages/page_course_section_student_list.dart';
import 'package:portal_ckc/presentation/pages/page_document_request_management_admin.dart';
import 'package:portal_ckc/presentation/pages/page_exam_schedule_grouped_admin.dart';
import 'package:portal_ckc/presentation/pages/page_login.dart';
import 'package:portal_ckc/presentation/pages/page_meeting_minutes_admin.dart';
import 'package:portal_ckc/presentation/pages/page_notification_detail_admin.dart';
import 'package:portal_ckc/presentation/pages/page_report_detail_admin.dart';
import 'package:portal_ckc/presentation/pages/page_exam_schedule_admin.dart';
import 'package:portal_ckc/presentation/pages/page_room_management.dart';
import 'package:portal_ckc/presentation/pages/page_schedule_management_admin.dart';
import 'package:portal_ckc/presentation/pages/page_student_management_admin.dart';
import 'package:portal_ckc/presentation/pages/page_teacher_management_admin.dart';
import 'package:portal_ckc/presentation/pages/page_teaching_schedule_admin.dart';
import 'package:portal_ckc/presentation/pages/page_user_detail_information.dart';
import 'package:portal_ckc/presentation/pages/page_main_layout_home_admin.dart';
import 'package:portal_ckc/presentation/references/dashboard_admin.dart';
import 'package:portal_ckc/presentation/references/page_change_password_admin.dart';
import 'package:portal_ckc/presentation/pages/appbar_bottombar/page_home_admin.dart';
import 'package:portal_ckc/presentation/pages/page_applications_admin.dart';
import 'package:portal_ckc/presentation/references/page_login_admin.dart';
import 'package:portal_ckc/presentation/references/page_management_group_admin.dart';
import 'package:portal_ckc/presentation/references/page_class_book_admin.dart';
import 'package:portal_ckc/presentation/references/page_infomation_detail_admin.dart';
import 'package:portal_ckc/presentation/pages/page_notification_admin.dart';
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

      /// 🔁 ShellRoute dùng `shellNavigatorKey` static
      /// use for home_admin, applications, notifications and user.
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
              // DashboardScreen
              GoRoute(
                path: '/admin/information/user',
                builder: (context, state) => const UserDetailInformationPage(),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: '/admin/info',
        builder: (context, state) => const PageThongtinAdmin(),
      ),
      GoRoute(
        path: '/admin/class_book_admin',
        builder: (context, state) => const PageClassBookAdmin(),
      ),
      GoRoute(
        path: '/admin/management_group_admin',
        builder: (context, state) => const PageQuanlyphongAdmin(),
      ),
      GoRoute(
        path: '/doimatkhau',
        builder: (context, state) => const PageDoimatkhauAdmin(),
      ),
      GoRoute(
        path: '/admin/class_management_admin',
        builder: (context, state) => PageClassManagementAdmin(),
      ),
      // GoRoute(
      //   path: '/admin/class_detail_admin',
      //   builder: (context, state) => PageClassDetailAdmin(),
      // ),
      GoRoute(
        path: '/admin/class_detail_admin',
        builder: (context, state) {
          final lop = state.extra as Lop; // ✅ lấy dữ liệu Lop truyền sang
          return PageClassDetailAdmin(lop: lop);
        },
      ),

      GoRoute(
        path: '/admin/conduct_evaluation_admin',
        builder: (context, state) => PageConductEvaluationAdmin(),
      ),

      GoRoute(
        path: '/admin/schedule_management_admin',
        builder: (context, state) => PageScheduleManagementAdmin(),
      ),
      GoRoute(
        path: '/admin/room_management_admin',
        builder: (context, state) => PageRoomManagement(),
      ),
      GoRoute(
        path: '/admin/student_management_admin',
        builder: (context, state) => PageStudentManagementAdmin(),
      ),
      GoRoute(
        path: '/admin/exam_schedule_groupe_admin',
        builder: (context, state) => PageExamScheduleGroupedAdmin(),
      ),
      GoRoute(
        path: '/admin/teacher_management_admin',
        builder: (context, state) => PageTeacherManagementAdmin(),
      ),
      GoRoute(
        path: '/admin/decument_request_management_admin',
        builder: (context, state) => PageDocumentRequestManagementAdmin(),
      ),
      GoRoute(
        path: '/admin/academic_year_management',
        builder: (context, state) => PageAcademicYearManagement(),
      ),
      GoRoute(
        path: '/admin/class_roster_admin',
        builder: (context, state) => PageClassRosterAdmin(),
      ),
      GoRoute(
        path: '/admin/meeting_minutes_admin',
        builder: (context, state) => PageMeetingMinutesAdmin(),
      ),
      GoRoute(
        path: '/admin/teaching_schedule_admin',
        builder: (context, state) => PageTeachingScheduleAdmin(),
      ),

      GoRoute(
        path: '/admin/course_student_list',
        builder: (context, state) => PageCourseSectionStudentList(),
      ),
      GoRoute(
        path: '/admin/exam_schedule_admin',
        builder: (context, state) => PageExamScheduleAdmin(),
      ),
      GoRoute(
        path: '/admin/course_assignment_admin',
        builder: (context, state) => PageCourseAssignmentAdmin(),
      ),
      GoRoute(
        path: '/admin/report_detail_admin',
        builder: (context, state) {
          final args = state.extra as Map<String, dynamic>;
          return PageReportDetailAdmin(isApproved: args['isApproved'] as bool);
        },
      ),

      GoRoute(
        path: '/notifications/detail',
        builder: (context, state) {
          final data = state.extra as Map<String, dynamic>;
          return NotificationDetailPage(
            title: data['title'],
            content: data['content'],
            date: data['date'],
          );
        },
      ),
      //NotificationDetailPage
    ],
  );
}
