abstract class RegistroEvent {}

class UsuarioChanged extends RegistroEvent {
  final String usuario;
  UsuarioChanged(this.usuario);
}

class EmailChange extends RegistroEvent {
  final String email;
  EmailChange(this.email);
}

class PasswordChange extends RegistroEvent {
  final String password;
  PasswordChange(this.password);
}

class FotoPerfilUrlChange extends RegistroEvent {
  final String fotoPerfilUrl;
  FotoPerfilUrlChange(this.fotoPerfilUrl);
}
