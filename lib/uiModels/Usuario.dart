class Usuario {
  final String idUsuario;
  final String nombre;
  final String email;
  final String password;
  final String fotoPerfilUrl;
  final int numFollowed;
  final int numFollowers;
  final bool followed;

  Usuario({
    required this.idUsuario,
    required this.nombre,
    required this.email,
    required this.password,
    required this.fotoPerfilUrl,
    required this.numFollowed,
    required this.numFollowers,
    required this.followed,
  });
}
