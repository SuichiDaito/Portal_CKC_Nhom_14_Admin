import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portal_ckc/api/controller/call_api.dart';
import 'package:portal_ckc/api/controller/call_api_admin.dart';
import 'package:portal_ckc/api/services/admin_service.dart';
import 'package:portal_ckc/bloc/bloc_event_state/admin_bloc.dart';
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

    return Scaffold(
      backgroundColor: Colors.blue,
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: screenHeight),
          child: IntrinsicHeight(
            child: Column(
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    width: double.infinity,
                    color: const Color(0xFF2196F3),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 40),
                        Image.asset(
                          'assets/images/logo.png',
                          width: 100,
                          height: 100,
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          'TRƯỜNG CAO ĐẲNG KỸ THUẬT CAO THẮNG',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'Cổng thông tin nội bộ\nHệ thống quản lý đào tạo Trường Cao Thắng',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 14, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 16,
                    ),
                    padding: const EdgeInsets.all(0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              GoRouter.of(context).go('/login');
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue, // Nền xanh
                              foregroundColor: Colors.white, // Chữ trắng
                              padding: const EdgeInsets.symmetric(
                                horizontal: 24,
                                vertical: 16,
                              ),
                              textStyle: const TextStyle(fontSize: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  8,
                                ), // Bo góc vừa phải
                              ),
                            ),
                            child: const Text('Giảng viên đăng nhập'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                const Padding(
                  padding: EdgeInsets.only(bottom: 16),
                  child: Text(
                    'Nhom_14_NgocCan_NgocTrang Copyright © 2025',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 12, color: Colors.white),
                  ),
                ),
              ],
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
