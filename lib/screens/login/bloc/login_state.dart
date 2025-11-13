class LoginState {
  final String usuario;
  final String email;
  final String password;

  LoginState({this.usuario = "", this.email = "", this.password = ""});

  LoginState copyWith({String? usuario, String? email, String? password}) =>
      LoginState(
        usuario: usuario ?? this.usuario,
        email: email ?? this.email,
        password: password ?? this.password,
      );
}
