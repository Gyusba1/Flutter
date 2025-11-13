import 'package:flutter/material.dart';
import 'package:flutterpostmatch/data/local/partidos_list.dart';
import 'package:flutterpostmatch/uiModels/Partido.dart';
import 'package:go_router/go_router.dart';

class PartidosScreen extends StatefulWidget {
  const PartidosScreen({super.key});

  @override
  State<PartidosScreen> createState() => _PartidoScreenState();
}

class _PartidoScreenState extends State<PartidosScreen> {
  final Color verdeOscuro = const Color(0xFF121712);
  final Color verdeOscuro2 = const Color(0xFF404F40);
  final Color verde = const Color(0xFF2B362B);
  final Color verdeClaro = const Color(0xFF38AB3D);
  final Color blancoGrisaseo = const Color(0xA9FFFFFF);

  List<Partido> partidos = [];
  bool isLoading = true;
  String? errorMsg;

  @override
  void initState() {
    super.initState();
    _loadPartidos();
  }

  void _loadPartidos() {
    setState(() {
      partidos = partidosGlobales;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: verdeOscuro,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _header(),
              const SizedBox(height: 10),
              Expanded(child: _bodyContent()),
            ],
          ),
        ),
      ),
    );
  }

  /// HEADER
  Widget _header() {
    return Text(
      'Partidos Destacados',
      style: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: blancoGrisaseo,
      ),
    );
  }

  /// BODY CONTENT HANDLER (loading, error, data)
  Widget _bodyContent() {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (errorMsg != null) {
      return Center(
        child: Text(
          errorMsg!,
          style: const TextStyle(color: Colors.redAccent, fontSize: 16),
        ),
      );
    }

    if (partidos.isEmpty) {
      return Center(
        child: Text(
          'No hay partidos disponibles.',
          style: TextStyle(color: blancoGrisaseo.withOpacity(0.7)),
        ),
      );
    }

    return PartidosSection(
      partidos: partidos,
      colorBase: verde,
      colorOscuro: verdeOscuro2,
      colorTexto: blancoGrisaseo,
      colorAccion: verdeClaro,
    );
  }
}

/// =========================
/// SECCIONES Y WIDGETS
/// =========================

/// SECCIÓN COMPLETA DE PARTIDOS
class PartidosSection extends StatelessWidget {
  final List<Partido> partidos;
  final Color colorBase;
  final Color colorOscuro;
  final Color colorTexto;
  final Color colorAccion;

  const PartidosSection({
    super.key,
    required this.partidos,
    required this.colorBase,
    required this.colorOscuro,
    required this.colorTexto,
    required this.colorAccion,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: partidos.length,
      itemBuilder: (context, index) {
        final partido = partidos[index];
        return PartidoCard(
          partido: partido,
          colorBase: colorBase,
          colorOscuro: colorOscuro,
          colorTexto: colorTexto,
          colorAccion: colorAccion,
        );
      },
    );
  }
}

/// CARD INDIVIDUAL DEL PARTIDO
class PartidoCard extends StatelessWidget {
  final Partido partido;
  final Color colorBase;
  final Color colorOscuro;
  final Color colorTexto;
  final Color colorAccion;

  const PartidoCard({
    super.key,
    required this.partido,
    required this.colorBase,
    required this.colorOscuro,
    required this.colorTexto,
    required this.colorAccion,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: colorBase,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 6,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          context.push("/partido/${partido.idPartido}");
        },
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              _imagenPartido(),
              const SizedBox(height: 10),
              PartidoResultado(
                local: partido.local,
                visitante: partido.visitante,
                golesLocal: partido.golesLocal,
                golesVisitante: partido.golesVisitante,
                colorTexto: colorTexto,
              ),
              const SizedBox(height: 8),
              _categoria(),
              const SizedBox(height: 8),
              _botonGenerarReview(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _imagenPartido() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Image.network(
        partido.partidoFotoUrl,
        width: double.infinity,
        height: 140,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => Container(
          width: double.infinity,
          height: 140,
          color: colorOscuro,
          child: Icon(Icons.stadium, color: colorTexto, size: 50),
        ),
      ),
    );
  }

  Widget _categoria() {
    return Text(
      '${partido.categoria} ⚽',
      style: TextStyle(color: colorTexto.withOpacity(0.8), fontSize: 14),
    );
  }

  Widget _botonGenerarReview(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          // Acción para generar review
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: colorAccion,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          padding: const EdgeInsets.symmetric(vertical: 12),
        ),
        child: const Text(
          'Generar Review',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
        ),
      ),
    );
  }
}

/// WIDGET REUTILIZABLE PARA RESULTADO DEL PARTIDO
class PartidoResultado extends StatelessWidget {
  final String local;
  final String visitante;
  final int golesLocal;
  final int golesVisitante;
  final Color colorTexto;

  const PartidoResultado({
    super.key,
    required this.local,
    required this.visitante,
    required this.golesLocal,
    required this.golesVisitante,
    required this.colorTexto,
  });

  @override
  Widget build(BuildContext context) {
    Color colorLocal = Colors.white;
    Color colorVisitante = Colors.white;

    if (golesLocal > golesVisitante) {
      colorLocal = Colors.green;
      colorVisitante = Colors.red;
    } else if (golesLocal < golesVisitante) {
      colorLocal = Colors.red;
      colorVisitante = Colors.green;
    } else {
      colorLocal = Colors.yellow;
      colorVisitante = Colors.yellow;
    }

    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Text(
            local,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: colorTexto,
              fontWeight: FontWeight.w600,
              fontSize: 15,
            ),
          ),
        ),
        Text(
          '$golesLocal',
          style: TextStyle(
            color: colorLocal,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        Text(
          ' - ',
          style: TextStyle(
            color: colorTexto,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        Text(
          '$golesVisitante',
          style: TextStyle(
            color: colorVisitante,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            visitante,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: colorTexto,
              fontWeight: FontWeight.w600,
              fontSize: 15,
            ),
          ),
        ),
      ],
    );
  }
}
