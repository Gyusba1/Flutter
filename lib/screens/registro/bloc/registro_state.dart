class RegistroState {
  final String usuario;
  final String email;
  final String password;
  final String fotoPerfilUrl;
  final bool isValid;

  RegistroState({
    this.email = "",
    this.password = "",
    this.fotoPerfilUrl = "",
    this.usuario = "",
    this.isValid = false,
  });

  RegistroState copyWith({
    String? usuario,
    String? email,
    String? password,
    String? fotoPerfilUrl,
    bool? isValid,
  }) => RegistroState(
    usuario: usuario ?? this.usuario,
    email: email ?? this.email,
    password: password ?? this.password,
    fotoPerfilUrl: fotoPerfilUrl ?? this.fotoPerfilUrl,
    isValid: isValid ?? this.isValid,
  );
}
