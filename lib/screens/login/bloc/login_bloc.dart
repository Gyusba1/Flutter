import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterpostmatch/screens/login/bloc/login_event.dart';
import 'package:flutterpostmatch/screens/login/bloc/login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginState()) {
    on<UsuarioChanged>((event, emit) {
      final newUsuario = event.usuario;
      print("usuario change: ${newUsuario}");
      emit(
        state.copyWith(
          usuario: newUsuario,
          isValid: _validate(newUsuario, state.email, state.password),
        ),
      );
    });

    on<EmailChange>((event, emit) {
      final newEmail = event.email;
      print("email change: ${newEmail}");
      emit(
        state.copyWith(
          email: newEmail,
          isValid: _validate(state.usuario, newEmail, state.password),
        ),
      );
    });

    on<PasswordChange>((event, emit) {
      final newPassword = event.password;
      print("password change: ${newPassword}");
      emit(
        state.copyWith(
          password: newPassword,
          isValid: _validate(state.usuario, state.email, newPassword),
        ),
      );
    });
  }

  bool _validate(String usuario, String email, String password) {
    return usuario.isNotEmpty && email.isNotEmpty && password.isNotEmpty;
  }
}
