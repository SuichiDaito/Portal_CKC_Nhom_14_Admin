import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portal_ckc/api/controller/call_api.dart';
import 'package:portal_ckc/api/controller/call_api_admin.dart';
import 'package:portal_ckc/api/services/admin_service.dart';
import 'package:portal_ckc/bloc/admin/admin_bloc.dart';
import 'package:portal_ckc/bloc/data/bloc_data.dart';
import 'package:portal_ckc/bloc/data/bloc_event.dart';
import 'package:portal_ckc/bloc/data/bloc_implement.dart';
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Image.asset('assets/images/logo.png', width: 150, height: 150),
            const SizedBox(height: 30),
            ButtonLogin(
              nameButton: 'Đăng nhập',
              onPressed: () {
                print("👉 Nút đăng nhập đã được nhấn");
                GoRouter.of(context).go('/login');
              },
            ),
          ],
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
