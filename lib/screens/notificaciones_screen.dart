import 'package:flutter/material.dart';

// Modelo de datos para Usuario
class UsuarioInfo {
  final String idUsuario;
  final String nombre;
  final String fotoPerfil;

  UsuarioInfo({
    required this.idUsuario,
    required this.nombre,
    required this.fotoPerfil,
  });
}

// Estado UI del ViewModel
class NotificacionesUiState {
  final bool isLoading;
  final String? errorMessage;
  final List<UsuarioInfo> usuariosNotificacion;

  NotificacionesUiState({
    this.isLoading = false,
    this.errorMessage,
    this.usuariosNotificacion = const [],
  });
}

// ViewModel (simulado con ChangeNotifier)
class NotificacionesViewModel extends ChangeNotifier {
  NotificacionesUiState _uiState = NotificacionesUiState(isLoading: true);
  
  NotificacionesUiState get uiState => _uiState;

  NotificacionesViewModel() {
    _cargarNotificaciones();
  }

  Future<void> _cargarNotificaciones() async {
    // Simular carga de datos
    await Future.delayed(const Duration(seconds: 1));
    
    _uiState = NotificacionesUiState(
      isLoading: false,
      usuariosNotificacion: [
        UsuarioInfo(
          idUsuario: '1',
          nombre: 'Juan Pérez',
          fotoPerfil: 'https://i.pravatar.cc/150?img=1',
        ),
        UsuarioInfo(
          idUsuario: '2',
          nombre: 'María García',
          fotoPerfil: 'https://i.pravatar.cc/150?img=2',
        ),
        UsuarioInfo(
          idUsuario: '3',
          nombre: 'Carlos López',
          fotoPerfil: 'https://i.pravatar.cc/150?img=3',
        ),
      ],
    );
    notifyListeners();
  }
}

// Pantalla Principal
class NotificacionesScreen extends StatelessWidget {
  final NotificacionesViewModel viewModel;
  final Function(String) onNotificacionClick;
  
  // Colores definidos
  final Color verdeOscuro = const Color(0xFF121712);
  final Color verdeOscuro2 = const Color(0xFF404F40);
  final Color verde = const Color(0xFF2B362B);
  final Color verdeClaro = const Color(0xFF38AB3D);
  final Color blancoGrisaseo = const Color(0xA9FFFFFF);

  NotificacionesScreen({
    Key? key,
    required this.viewModel,
    required this.onNotificacionClick,
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
            child: const Center(
              child: CircularProgressIndicator(
                color: Color(0xFF38AB3D),
              ),
            ),
          );
        }

        if (state.errorMessage != null) {
          return Container(
            color: verdeOscuro,
            child: Center(
              child: Text(
                state.errorMessage ?? 'Error desconocido',
                style: const TextStyle(color: Colors.red),
                textAlign: TextAlign.center,
              ),
            ),
          );
        }

        return Container(
          color: verdeOscuro,
          child: Column(
            children: [
              _NotificacionesHeader(
                blancoGrisaseo: blancoGrisaseo,
              ),
              Expanded(
                child: _SeccionNotificaciones(
                  listaNotificaciones: state.usuariosNotificacion,
                  onNotificacionClick: onNotificacionClick,
                  verdeOscuro: verdeOscuro,
                  verdeOscuro2: verdeOscuro2,
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

// Header de Notificaciones
class _NotificacionesHeader extends StatelessWidget {
  final Color blancoGrisaseo;

  const _NotificacionesHeader({
    required this.blancoGrisaseo,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 56,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Center(
        child: Text(
          'Notificaciones',
          style: TextStyle(
            color: blancoGrisaseo,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
      ),
    );
  }
}

// Sección de lista de notificaciones
class _SeccionNotificaciones extends StatelessWidget {
  final List<UsuarioInfo> listaNotificaciones;
  final Function(String) onNotificacionClick;
  final Color verdeOscuro;
  final Color verdeOscuro2;
  final Color blancoGrisaseo;

  const _SeccionNotificaciones({
    required this.listaNotificaciones,
    required this.onNotificacionClick,
    required this.verdeOscuro,
    required this.verdeOscuro2,
    required this.blancoGrisaseo,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: listaNotificaciones.length,
      itemBuilder: (context, index) {
        return _ItemNotificacion(
          notificacionData: listaNotificaciones[index],
          onNotificacionClick: onNotificacionClick,
          verdeOscuro2: verdeOscuro2,
          blancoGrisaseo: blancoGrisaseo,
        );
      },
    );
  }
}

// Item individual de notificación
class _ItemNotificacion extends StatelessWidget {
  final UsuarioInfo notificacionData;
  final Function(String) onNotificacionClick;
  final Color verdeOscuro2;
  final Color blancoGrisaseo;

  const _ItemNotificacion({
    required this.notificacionData,
    required this.onNotificacionClick,
    required this.verdeOscuro2,
    required this.blancoGrisaseo,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        debugPrint('Notificación seleccionada: ${notificacionData.idUsuario}');
        onNotificacionClick(notificacionData.idUsuario);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            // Avatar circular
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: verdeOscuro2,
                shape: BoxShape.circle,
              ),
              child: ClipOval(
                child: Image.network(
                  notificacionData.fotoPerfil,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(
                      Icons.person,
                      color: blancoGrisaseo,
                      size: 30,
                    );
                  },
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                            : null,
                        color: const Color(0xFF38AB3D),
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(width: 16),
            // Contenido de la notificación
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'A ${notificacionData.nombre} le gustó tu reseña',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: blancoGrisaseo,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'hace 2 semanas',
                    style: TextStyle(
                      fontSize: 14,
                      color: blancoGrisaseo.withOpacity(0.7),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
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
      title: 'Notificaciones',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
        scaffoldBackgroundColor: const Color(0xFF121712),
      ),
      home: Scaffold(
        body: SafeArea(
          child: NotificacionesScreen(
            viewModel: NotificacionesViewModel(),
            onNotificacionClick: (id) {
              debugPrint('Click en notificación: $id');
            },
          ),
        ),
      ),
    );
  }
}