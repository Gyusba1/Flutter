import 'package:flutter/material.dart';
import 'package:flutterpostmatch/uiModels/Partido.dart';
import 'package:flutterpostmatch/data/local/partidos_list.dart';

class PartidoDetailScreen extends StatefulWidget {
  final String idPartido;

  const PartidoDetailScreen({super.key, required this.idPartido});

  @override
  State<PartidoDetailScreen> createState() => _PartidoDetailScreenState();
}

class _PartidoDetailScreenState extends State<PartidoDetailScreen> {
  Partido? partido;

  @override
  void initState() {
    super.initState();
    cargarPartido();
  }

  void cargarPartido() {
    partido = partidosGlobales.firstWhere(
      (p) => p.idPartido == widget.idPartido,
      orElse: () => Partido(
        idPartido: "null",
        nombre: "Partido no encontrado",
        categoria: "",
        visitante: "",
        local: "",
        golesVisitante: 0,
        golesLocal: 0,
        posesionLocal: 0,
        posesionVisitante: 0,
        tirosLocal: 0,
        tirosVisitante: 0,
        fecha: DateTime.now(),
        partidoFotoUrl: "",
      ),
    );

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final Color verdeOscuro3 = const Color(0xFF1C1F1E);
    final Color verdePigmentado = const Color(0xFF1F241F);

    if (partido == null) {
      return Scaffold(
        backgroundColor: verdeOscuro3,
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      backgroundColor: verdeOscuro3,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildHeader(),
              const SizedBox(height: 16),
              buildPartidoCard(partido!, verdePigmentado),
              const SizedBox(height: 20),
              buildStatsCard(partido!, verdePigmentado),
            ],
          ),
        ),
      ),
    );
  }
}

Widget buildHeader() {
  return const Text(
    "Detalle del Partido",
    style: TextStyle(
      color: Colors.white,
      fontSize: 22,
      fontWeight: FontWeight.bold,
    ),
  );
}

Widget buildPartidoCard(Partido partido, Color background) {
  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: background,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                partido.nombre,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                partido.categoria,
                style: const TextStyle(color: Colors.white70, fontSize: 14),
              ),
              const SizedBox(height: 8),
              Text(
                "${partido.local} ${partido.golesLocal} - ${partido.golesVisitante} ${partido.visitante}",
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
              const SizedBox(height: 6),
              Text(
                "${partido.fecha.toLocal()}".split(' ')[0],
                style: const TextStyle(color: Colors.white70),
              ),
            ],
          ),
        ),
        const SizedBox(width: 12),
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.network(
            partido.partidoFotoUrl,
            width: 120,
            height: 80,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => Image.asset(
              'assets/images/fondo_estadio.png',
              width: 120,
              height: 80,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget buildStatsCard(Partido partido, Color background) {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: background,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      children: [
        buildStatRow(
          "Posesión",
          "${partido.posesionLocal}%",
          "${partido.posesionVisitante}%",
        ),
        const Divider(color: Colors.white24),
        buildStatRow(
          "Tiros",
          "${partido.tirosLocal}",
          "${partido.tirosVisitante}",
        ),
        const Divider(color: Colors.white24),
        buildStatRow(
          "Goles",
          "${partido.golesLocal}",
          "${partido.golesVisitante}",
        ),
      ],
    ),
  );
}

Widget buildStatRow(String title, String local, String visitante) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(local, style: const TextStyle(color: Colors.white, fontSize: 16)),
      Text(title, style: const TextStyle(color: Colors.white70, fontSize: 14)),
      Text(
        visitante,
        style: const TextStyle(color: Colors.white, fontSize: 16),
      ),
    ],
  );
}
