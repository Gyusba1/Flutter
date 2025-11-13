import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterpostmatch/screens/registro/bloc/registro_event.dart';
import 'package:flutterpostmatch/screens/registro/bloc/registro_state.dart';

class RegistroBloc extends Bloc<RegistroEvent, RegistroState> {
  RegistroBloc() : super(RegistroState()) {
    on<UsuarioChanged>((event, emit) {
      final newUsuario = event.usuario;
      print("usuario change: ${newUsuario}");
      emit(
        state.copyWith(
          usuario: newUsuario,
          isValid: _validate(
            newUsuario,
            state.email,
            state.password,
            state.fotoPerfilUrl,
          ),
        ),
      );
    });

    on<EmailChange>((event, emit) {
      final newEmail = event.email;
      print("email change: ${newEmail}");
      emit(
        state.copyWith(
          email: newEmail,
          isValid: _validate(
            state.usuario,
            newEmail,
            state.password,
            state.fotoPerfilUrl,
          ),
        ),
      );
    });

    on<PasswordChange>((event, emit) {
      final newPassword = event.password;
      print("password change: ${newPassword}");
      emit(
        state.copyWith(
          password: newPassword,
          isValid: _validate(
            state.usuario,
            state.email,
            newPassword,
            state.fotoPerfilUrl,
          ),
        ),
      );
    });

    on<FotoPerfilUrlChange>((event, emit) {
      final newFotoPerfilUrlChange = event.fotoPerfilUrl;
      print("fotoPerfilUrl change: ${newFotoPerfilUrlChange}");
      emit(
        state.copyWith(
          password: newFotoPerfilUrlChange,
          isValid: _validate(
            state.usuario,
            state.email,
            state.password,
            newFotoPerfilUrlChange,
          ),
        ),
      );
    });
  }

  bool _validate(
    String usuario,
    String email,
    String password,
    String fotoPerfilUrl,
  ) {
    return usuario.isNotEmpty && email.isNotEmpty && password.isNotEmpty;
  }
}
