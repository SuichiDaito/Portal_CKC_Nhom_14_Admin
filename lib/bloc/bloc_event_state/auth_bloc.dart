import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portal_ckc/api/model/admin_thong_tin.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AuthEvent {}

class AppStarted extends AuthEvent {}

abstract class AuthState {}

class AuthInitial extends AuthState {}

class Authenticated extends AuthState {}

class Unauthenticated extends AuthState {}

class AuthLoading extends AuthState {}

class LoggedIn extends AuthEvent {
  final User user;
  LoggedIn(this.user);
}

Future<void> _onLoggedOut(LoggedOut event, Emitter<AuthState> emit) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.clear(); // 🧹 Xóa token, userId
  emit(Unauthenticated());
}

class LoggedOut extends AuthEvent {}

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthLoading()) {
    // Gọi kiểm tra khi bắt đầu app
    _checkInitialLogin();

    // Gắn handler cho các sự kiện
    on<AppStarted>(_onAppStarted);
    on<LoggedIn>((event, emit) => emit(Authenticated()));
    on<LoggedOut>((event, emit) async {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('token');
      emit(Unauthenticated());
    });
  }

  Future<void> _checkInitialLogin() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token != null && token.isNotEmpty) {
      emit(Authenticated());
    } else {
      emit(Unauthenticated());
    }
  }

  Future<void> _onAppStarted(AppStarted event, Emitter<AuthState> emit) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token != null && token.isNotEmpty) {
      emit(Authenticated());
    } else {
      emit(Unauthenticated());
    }
  }
}
