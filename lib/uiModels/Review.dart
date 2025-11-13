class Review {
  final String idReview;
  final String titulo;
  final String descripcion;
  final DateTime fecha;
  final int calificacion;
  final int numLikes;
  final int numComentarios;
  final bool likedByUser;
  // datos usuario
  final String usuarioId;
  final String usuarioNombre;
  final String usuarioEmail;
  final String usuarioPassword;
  final String usuarioFotoPerfilUrl;
  // datos partido
  final String partidoId;
  final String partidoNombre;
  final String partidoVisitante;
  final String partidoLocal;
  final String partidoFotoUrl;
  final int partidoGolesVisitante;
  final int partidoGolesLocal;
  final DateTime partidoFecha;

  Review({
    required this.idReview,
    required this.titulo,
    required this.descripcion,
    required this.fecha,
    required this.calificacion,
    required this.numLikes,
    required this.numComentarios,
    required this.likedByUser,
    required this.usuarioId,
    required this.usuarioNombre,
    required this.usuarioEmail,
    required this.usuarioPassword,
    required this.usuarioFotoPerfilUrl,
    required this.partidoId,
    required this.partidoNombre,
    required this.partidoVisitante,
    required this.partidoLocal,
    required this.partidoFotoUrl,
    required this.partidoGolesVisitante,
    required this.partidoGolesLocal,
    required this.partidoFecha,
  });
}
