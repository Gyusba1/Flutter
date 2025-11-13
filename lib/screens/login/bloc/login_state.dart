class LoginState {
  final String usuario;
  final String email;
  final String password;
  final bool isValid;

  LoginState({
    this.isValid = false,
    this.usuario = "",
    this.email = "",
    this.password = "",
  });

  LoginState copyWith({
    String? usuario,
    String? email,
    String? password,
    bool? isValid,
  }) => LoginState(
    usuario: usuario ?? this.usuario,
    email: email ?? this.email,
    password: password ?? this.password,
    isValid: isValid ?? this.isValid,
  );
}
