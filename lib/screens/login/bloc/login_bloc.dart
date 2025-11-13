import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterpostmatch/screens/login/bloc/login_event.dart';
import 'package:flutterpostmatch/screens/login/bloc/login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginState()) {
    on<UsuarioChanged>((event, emit) {
      final newUsuario = event.usuario;
      emit(state.copyWith(email: newUsuario));
    });

    on<EmailChange>((event, emit) {
      final newEmail = event.email;
      emit(state.copyWith(email: newEmail));
    });

    on<PasswordChange>((event, emit) {
      final newPassword = event.password;
      emit(state.copyWith(password: newPassword));
    });
  }
}
