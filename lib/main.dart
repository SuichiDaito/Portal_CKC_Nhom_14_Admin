import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portal_ckc/api/controller/call_api.dart';
import 'package:portal_ckc/api/controller/call_api_admin.dart';
import 'package:portal_ckc/api/model/admin_phieu_len_lop.dart';
import 'package:portal_ckc/api/services/admin_service.dart';
import 'package:portal_ckc/bloc/bloc_event_state/admin_bloc.dart';
import 'package:portal_ckc/bloc/bloc_event_state/auth_bloc.dart';
import 'package:portal_ckc/bloc/bloc_event_state/bien_bang_shcn_bloc.dart';
import 'package:portal_ckc/bloc/bloc_event_state/cap_nhat_diem_bloc.dart';
import 'package:portal_ckc/bloc/bloc_event_state/diem_rl_bloc.dart';
import 'package:portal_ckc/bloc/bloc_event_state/giay_xac_nhan_bloc.dart';
import 'package:portal_ckc/bloc/bloc_event_state/lich_thi_bloc.dart';
import 'package:portal_ckc/bloc/bloc_event_state/lop_bloc.dart';
import 'package:portal_ckc/bloc/bloc_event_state/lop_hoc_phan_bloc.dart';
import 'package:portal_ckc/bloc/bloc_event_state/nganh_khoa_bloc.dart';
import 'package:portal_ckc/bloc/bloc_event_state/nienkhoa_hocky_bloc.dart';
import 'package:portal_ckc/bloc/bloc_event_state/phieu_len_lop_bloc.dart';
import 'package:portal_ckc/bloc/bloc_event_state/phong_bloc.dart';
import 'package:portal_ckc/bloc/bloc_event_state/role_bloc.dart';
import 'package:portal_ckc/bloc/bloc_event_state/sinh_vien_bloc.dart';
import 'package:portal_ckc/bloc/bloc_event_state/thoi_khoa_bieu_bloc.dart';
import 'package:portal_ckc/bloc/bloc_event_state/thong_bao_bloc.dart';
import 'package:portal_ckc/bloc/bloc_event_state/tuan_bloc.dart';
import 'package:portal_ckc/bloc/bloc_event_state/user_bloc.dart';
import 'package:portal_ckc/bloc/state/bloc_state.dart';
import 'package:portal_ckc/bloc/event/bloc_event.dart';
import 'package:portal_ckc/bloc/bloc_event_state/bloc_example.dart';
import 'package:portal_ckc/l10n/app_localizations.dart';
import 'package:portal_ckc/api/model/comment.dart';
import 'package:portal_ckc/presentation/sections/button/button_login.dart';
import 'package:portal_ckc/routes/app_route.dart';

void main() {
  GoRouter.optionURLReflectsImperativeAPIs = true;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => BlocImplement()..add(FetchData())),
        BlocProvider(create: (_) => AuthBloc()),
        BlocProvider(create: (_) => AdminBloc()),
        BlocProvider(create: (_) => PhongBloc()),
        BlocProvider(create: (_) => SinhVienBloc()),
        BlocProvider(create: (_) => UserBloc()),
        BlocProvider(create: (_) => NienKhoaHocKyBloc()),
        BlocProvider(create: (_) => LopBloc()),
        BlocProvider(create: (_) => NganhKhoaBloc()),
        BlocProvider(create: (_) => RoleBloc()),
        BlocProvider(create: (_) => DangKyGiayBloc()),
        BlocProvider(create: (_) => DiemRlBloc()),
        BlocProvider(create: (_) => LopHocPhanBloc()),
        BlocProvider(create: (_) => CapNhatDiemBloc()),
        BlocProvider(create: (_) => ThongBaoBloc()),
        BlocProvider(create: (_) => PhieuLenLopBloc()),
        BlocProvider(create: (_) => BienBangShcnBloc()),
        BlocProvider(create: (_) => TuanBloc()),
        BlocProvider(create: (_) => ThoiKhoaBieuBloc()),
        BlocProvider(create: (_) => LichThiBloc()),
      ],
      child: MaterialApp.router(
        routerConfig: RouteName.route,
        debugShowCheckedModeBanner: false,
        title: 'Portal_CKC',
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        theme: ThemeData(
          textTheme: GoogleFonts.robotoTextTheme(),
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
      ),
    );
  }
}
