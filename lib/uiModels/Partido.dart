class Partido {
  final String idPartido;
  final String nombre;
  final String categoria;
  final String visitante;
  final String local;
  final int golesVisitante;
  final int golesLocal;
  final int posesionLocal;
  final int posesionVisitante;
  final int tirosLocal;
  final int tirosVisitante;
  final DateTime fecha;
  final String partidoFotoUrl;

  Partido({
    required this.idPartido,
    required this.nombre,
    required this.categoria,
    required this.visitante,
    required this.local,
    required this.golesVisitante,
    required this.golesLocal,
    required this.posesionLocal,
    required this.posesionVisitante,
    required this.tirosLocal,
    required this.tirosVisitante,
    required this.fecha,
    required this.partidoFotoUrl,
  });
}
