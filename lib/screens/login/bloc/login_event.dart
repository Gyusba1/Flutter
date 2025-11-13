abstract class LoginEvent {}

class UsuarioChanged extends LoginEvent {
  final String usuario;
  UsuarioChanged(this.usuario);
}

class EmailChange extends LoginEvent {
  final String email;
  EmailChange(this.email);
}

class PasswordChange extends LoginEvent {
  final String password;
  PasswordChange(this.password);
}
