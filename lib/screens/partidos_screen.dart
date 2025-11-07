import 'package:flutter/material.dart';

// Modelo de datos para Partido
class PartidoInfo {
  final String idPartido;
  final String local;
  final String visitante;
  final int golesLocal;
  final int golesVisitante;
  final String categoria;
  final String partidoFotoUrl;

  PartidoInfo({
    required this.idPartido,
    required this.local,
    required this.visitante,
    required this.golesLocal,
    required this.golesVisitante,
    required this.categoria,
    required this.partidoFotoUrl,
  });
}

// Estado UI del ViewModel
class PartidosUiState {
  final List<PartidoInfo> partidos;
  final bool isLoading;

  PartidosUiState({
    this.partidos = const [],
    this.isLoading = false,
  });
}

// ViewModel
class PartidosViewModel extends ChangeNotifier {
  PartidosUiState _uiState = PartidosUiState(isLoading: true);
  
  PartidosUiState get uiState => _uiState;

  PartidosViewModel() {
    _cargarPartidos();
  }

  Future<void> _cargarPartidos() async {
    await Future.delayed(const Duration(seconds: 1));
    
    _uiState = PartidosUiState(
      isLoading: false,
      partidos: [
        PartidoInfo(
          idPartido: '1',
          local: 'Real Madrid',
          visitante: 'Barcelona',
          golesLocal: 3,
          golesVisitante: 2,
          categoria: 'La Liga',
          partidoFotoUrl: 'https://images.unsplash.com/photo-1522778119026-d647f0596c20?w=400',
        ),
        PartidoInfo(
          idPartido: '2',
          local: 'Manchester United',
          visitante: 'Liverpool',
          golesLocal: 1,
          golesVisitante: 1,
          categoria: 'Premier League',
          partidoFotoUrl: 'https://images.unsplash.com/photo-1431324155629-1a6deb1dec8d?w=400',
        ),
        PartidoInfo(
          idPartido: '3',
          local: 'PSG',
          visitante: 'Bayern Munich',
          golesLocal: 0,
          golesVisitante: 2,
          categoria: 'Champions League',
          partidoFotoUrl: 'https://images.unsplash.com/photo-1508098682722-e99c43a406b2?w=400',
        ),
      ],
    );
    notifyListeners();
  }
}

// Pantalla Principal
class PartidoScreen extends StatelessWidget {
  final PartidosViewModel viewModel;
  final Function(String) onReviewPartidoClick;
  final Function(String) onPartidoClick;
  
  // Colores definidos
  final Color verdeOscuro = const Color(0xFF121712);
  final Color verdeOscuro2 = const Color(0xFF404F40);
  final Color verde = const Color(0xFF2B362B);
  final Color verdeClaro = const Color(0xFF38AB3D);
  final Color blancoGrisaseo = const Color(0xA9FFFFFF);

  PartidoScreen({
    Key? key,
    required this.viewModel,
    required this.onReviewPartidoClick,
    required this.onPartidoClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: viewModel,
      builder: (context, child) {
        final state = viewModel.uiState;

        if (state.isLoading) {
          return Container(
            color: verdeOscuro,
            child: Center(
              child: CircularProgressIndicator(
                color: verdeClaro,
              ),
            ),
          );
        }

        return Container(
          color: verdeOscuro,
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
              Expanded(
                child: _SectionPartidos(
                  partidos: state.partidos,
                  onPartidoClick: onPartidoClick,
                  onReviewPartidoClick: onReviewPartidoClick,
                  verdeOscuro: verdeOscuro,
                  verdeOscuro2: verdeOscuro2,
                  verde: verde,
                  verdeClaro: verdeClaro,
                  blancoGrisaseo: blancoGrisaseo,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

// Sección de lista de partidos
class _SectionPartidos extends StatelessWidget {
  final List<PartidoInfo> partidos;
  final Function(String) onPartidoClick;
  final Function(String) onReviewPartidoClick;
  final Color verdeOscuro;
  final Color verdeOscuro2;
  final Color verde;
  final Color verdeClaro;
  final Color blancoGrisaseo;

  const _SectionPartidos({
    required this.partidos,
    required this.onPartidoClick,
    required this.onReviewPartidoClick,
    required this.verdeOscuro,
    required this.verdeOscuro2,
    required this.verde,
    required this.verdeClaro,
    required this.blancoGrisaseo,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: partidos.length,
      itemBuilder: (context, index) {
        return _PartidoCard(
          partido: partidos[index],
          onPartidoClick: onPartidoClick,
          onPartidoReviewClick: onReviewPartidoClick,
          verdeOscuro2: verdeOscuro2,
          verde: verde,
          verdeClaro: verdeClaro,
          blancoGrisaseo: blancoGrisaseo,
        );
      },
    );
  }
}

// Card de partido individual
class _PartidoCard extends StatelessWidget {
  final PartidoInfo partido;
  final Function(String) onPartidoClick;
  final Function(String) onPartidoReviewClick;
  final Color verdeOscuro2;
  final Color verde;
  final Color verdeClaro;
  final Color blancoGrisaseo;

  const _PartidoCard({
    required this.partido,
    required this.onPartidoClick,
    required this.onPartidoReviewClick,
    required this.verdeOscuro2,
    required this.verde,
    required this.verdeClaro,
    required this.blancoGrisaseo,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      color: verde,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 6,
      child: InkWell(
        onTap: () => onPartidoClick(partido.idPartido),
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              // Imagen del estadio
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  partido.partidoFotoUrl,
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
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Container(
                      width: 80,
                      height: 80,
                      color: verdeOscuro2,
                      child: Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes!
                              : null,
                          color: verdeClaro,
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 8),
              // Resultado del partido
              _ResultadoPartidoCard(
                partido: partido,
                blancoGrisaseo: blancoGrisaseo,
              ),
              const SizedBox(height: 8),
              // Categoría
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${partido.categoria} ⚽',
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
                  onPressed: () => onPartidoReviewClick(partido.idPartido),
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
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Widget del resultado del partido
class _ResultadoPartidoCard extends StatelessWidget {
  final PartidoInfo partido;
  final Color blancoGrisaseo;

  const _ResultadoPartidoCard({
    required this.partido,
    required this.blancoGrisaseo,
  });

  @override
  Widget build(BuildContext context) {
    Color colorLocal = Colors.white;
    Color colorVisitante = Colors.white;

    if (partido.golesLocal > partido.golesVisitante) {
      colorLocal = Colors.green;
      colorVisitante = Colors.red;
    } else if (partido.golesLocal < partido.golesVisitante) {
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
            partido.local,
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
          '${partido.golesLocal}',
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
          '${partido.golesVisitante}',
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
            partido.visitante,
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

// Ejemplo de uso
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Partidos',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
        scaffoldBackgroundColor: const Color(0xFF121712),
      ),
      home: Scaffold(
        body: SafeArea(
          child: PartidoScreen(
            viewModel: PartidosViewModel(),
            onPartidoClick: (id) {
              debugPrint('Click en partido: $id');
            },
            onReviewPartidoClick: (id) {
              debugPrint('Click en review de partido: $id');
            },
          ),
        ),
      ),
    );
  }
}