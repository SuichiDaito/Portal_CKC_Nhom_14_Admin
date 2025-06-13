import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portal_ckc/api/controller/call_api.dart';
import 'package:portal_ckc/api/controller/call_api_admin.dart';
import 'package:portal_ckc/api/services/admin_service.dart';
import 'package:portal_ckc/bloc/bloc_event_state/admin_bloc.dart';
import 'package:portal_ckc/bloc/bloc_event_state/admin_room_bloc.dart';
import 'package:portal_ckc/bloc/event/admin_room_event.dart';
import 'package:portal_ckc/bloc/state/bloc_state.dart';
import 'package:portal_ckc/bloc/event/bloc_event.dart';
import 'package:portal_ckc/bloc/bloc_event_state/bloc_example.dart';
import 'package:portal_ckc/l10n/app_localizations.dart';
import 'package:portal_ckc/api/model/comment.dart';
import 'package:portal_ckc/presentation/sections/button_login.dart';
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
        BlocProvider(create: (_) => AdminBloc()),
        BlocProvider(
          create: (_) => RoomBloc(CallApiAdmin.adminService)..add(FetchRooms()),
        ),
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
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp.router(
//       routerConfig: RouteName.route,
//       debugShowCheckedModeBanner: false,
//       title: 'Portal_CKC',
//       localizationsDelegates: AppLocalizations.localizationsDelegates,
//       supportedLocales: AppLocalizations.supportedLocales,
//       theme: ThemeData(
//         textTheme: GoogleFonts.robotoTextTheme(),
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//       ),
//     );
//   }
// }

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFF8E44AD), // tím ánh hồng
            Color.fromARGB(255, 16, 7, 190), // xanh đen
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: screenHeight),
            child: IntrinsicHeight(
              child: Column(
                children: [
                  // Header
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 48,
                    ),
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/logo.png',
                          width: 120,
                          height: 120,
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          'Cao đẳng Kỹ thuật Cao Thắng',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          'Hệ thống quản lý đào tạo\nCổng thông tin nội bộ',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            color: Color(0xFFDBEAFE),
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 36),

                  // Login card
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          const Text(
                            'Đăng nhập hệ thống',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1E293B),
                            ),
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton.icon(
                            onPressed: () {
                              GoRouter.of(context).go('/login');
                            },
                            icon: const Icon(Icons.login),
                            label: const Text('Giảng viên đăng nhập'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(
                                0xFF6D28D9,
                              ), // tím đậm
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 24,
                                vertical: 16,
                              ),
                              textStyle: const TextStyle(fontSize: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const Spacer(),

                  const Padding(
                    padding: EdgeInsets.only(bottom: 24, top: 40),
                    child: Text(
                      'Nhom_14_NgocCan_NgocTrang\nCopyright © 2025',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 15, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// class _MyHomePageState extends State<MyHomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider<BlocImplement>(
//       create: (_) => BlocImplement()..add(FetchData()),
//       child: Scaffold(
//         appBar: AppBar(
//           backgroundColor: Theme.of(context!).colorScheme.inversePrimary,
//           title: Text(widget.title),
//         ),
//         body: BlocBuilder<BlocImplement, Data>(
//           builder: (context, state) {
//             if (state is LoadingData) {
//               return Center(child: CircularProgressIndicator());
//             } else if (state is LoadedData) {
//               final data = state.comments.body;
//               return RefreshIndicator(
//                 child: ListView.builder(
//                   itemCount: data!.length,
//                   itemBuilder: (context, index) {
//                     return Column(
//                       children: [
//                         ListTile(title: Text('Id: ${data[index].id}')),
//                         ButtonLogin(
//                           nameButton: 'Login',
//                           onPressed: () => {context.go('/page/demo')},
//                         ),
//                       ],
//                     );
//                   },
//                 ),
//                 onRefresh: () async {
//                   context.read<BlocImplement>().add(RefreshData());
//                 },
//               );
//             } else if (state is ErroData) {
//               return Center(child: Text("Error: ${state.message}"));
//             }
//             return Text('NOT FOUND | 404');
//           },
//         ),
//       ),
//     );
//   }
// }
