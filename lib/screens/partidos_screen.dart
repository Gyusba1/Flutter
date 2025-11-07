import 'package:flutter/material.dart';

class PartidoScreen extends StatefulWidget {
  const PartidoScreen({super.key});

  @override
  State<PartidoScreen> createState() => _PartidoScreenState();
}

class _PartidoScreenState extends State<PartidoScreen> {
  // 🎨 Colores
  final Color verdeOscuro = const Color(0xFF121712);
  final Color verdeOscuro2 = const Color(0xFF404F40);
  final Color verde = const Color(0xFF2B362B);
  final Color verdeClaro = const Color(0xFF38AB3D);
  final Color blancoGrisaseo = const Color(0xA9FFFFFF);

  // Lista de partidos de ejemplo
  final List<Map<String, dynamic>> partidos = [
    {
      'id': '1',
      'local': 'Real Madrid',
      'visitante': 'Barcelona',
      'golesLocal': 3,
      'golesVisitante': 2,
      'categoria': 'La Liga',
      'foto':
          'https://images.unsplash.com/photo-1522778119026-d647f0596c20?w=400',
    },
    {
      'id': '2',
      'local': 'Manchester United',
      'visitante': 'Liverpool',
      'golesLocal': 1,
      'golesVisitante': 1,
      'categoria': 'Premier League',
      'foto':
          'https://images.unsplash.com/photo-1431324155629-1a6deb1dec8d?w=400',
    },
    {
      'id': '3',
      'local': 'PSG',
      'visitante': 'Bayern Munich',
      'golesLocal': 0,
      'golesVisitante': 2,
      'categoria': 'Champions League',
      'foto':
          'https://images.unsplash.com/photo-1508098682722-e99c43a406b2?w=400',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: verdeOscuro,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Partidos Destacados',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: blancoGrisaseo,
                ),
              ),
            ),
            // Lista de partidos
            Expanded(child: _sectionPartidos()),
          ],
        ),
      ),
    );
  }

  Widget _sectionPartidos() {
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: partidos.length,
      itemBuilder: (context, index) {
        final partido = partidos[index];
        return _partidoCard(
          idPartido: partido['id'],
          local: partido['local'],
          visitante: partido['visitante'],
          golesLocal: partido['golesLocal'],
          golesVisitante: partido['golesVisitante'],
          categoria: partido['categoria'],
          fotoUrl: partido['foto'],
        );
      },
    );
  }

  Widget _partidoCard({
    required String idPartido,
    required String local,
    required String visitante,
    required int golesLocal,
    required int golesVisitante,
    required String categoria,
    required String fotoUrl,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      color: verde,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 6,
      child: InkWell(
        onTap: () {
          // Acción al hacer clic en el partido
        },
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              // Imagen del estadio
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  fotoUrl,
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: 80,
                      height: 80,
                      color: verdeOscuro2,
                      child: Icon(
                        Icons.stadium,
                        color: blancoGrisaseo,
                        size: 40,
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 8),
              // Resultado del partido
              _resultadoPartidoCard(
                local: local,
                visitante: visitante,
                golesLocal: golesLocal,
                golesVisitante: golesVisitante,
              ),
              const SizedBox(height: 8),
              // Categoría
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '$categoria ⚽',
                    style: TextStyle(
                      color: blancoGrisaseo.withOpacity(0.8),
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              // Botón para generar review
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Acción de generar review
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: verdeClaro,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: const Text(
                    'Generar Review',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _resultadoPartidoCard({
    required String local,
    required String visitante,
    required int golesLocal,
    required int golesVisitante,
  }) {
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
        // Equipo Local
        Expanded(
          flex: 3,
          child: Text(
            local,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: blancoGrisaseo,
              fontWeight: FontWeight.w600,
              fontSize: 15,
            ),
          ),
        ),
        // Goles Local
        Text(
          '$golesLocal',
          style: TextStyle(
            color: colorLocal,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        // Separador
        Text(
          ' - ',
          style: TextStyle(
            color: blancoGrisaseo,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        // Goles Visitante
        Text(
          '$golesVisitante',
          style: TextStyle(
            color: colorVisitante,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        // Equipo Visitante
        Expanded(
          flex: 3,
          child: Text(
            visitante,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: blancoGrisaseo,
              fontWeight: FontWeight.w600,
              fontSize: 15,
            ),
          ),
        ),
      ],
    );
  }
}
