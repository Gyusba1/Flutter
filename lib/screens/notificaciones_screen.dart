import 'package:flutter/material.dart';

class NotificacionesScreen extends StatefulWidget {
  const NotificacionesScreen({super.key});

  @override
  State<NotificacionesScreen> createState() => _NotificacionesScreenState();
}

class _NotificacionesScreenState extends State<NotificacionesScreen> {
  final Color verdeOscuro = const Color(0xFF121712);
  final Color verdeOscuro2 = const Color(0xFF404F40);
  final Color verde = const Color(0xFF2B362B);
  final Color verdeClaro = const Color(0xFF38AB3D);
  final Color blancoGrisaseo = const Color(0xA9FFFFFF);

  // Lista de notificaciones de ejemplo
  final List<Map<String, String>> notificaciones = [
    {
      'id': '1',
      'nombre': 'Juan Pérez',
      'foto': 'https://i.pravatar.cc/150?img=1',
    },
    {
      'id': '2',
      'nombre': 'María García',
      'foto': 'https://i.pravatar.cc/150?img=2',
    },
    {
      'id': '3',
      'nombre': 'Carlos López',
      'foto': 'https://i.pravatar.cc/150?img=3',
    },
    {
      'id': '4',
      'nombre': 'Ana Martínez',
      'foto': 'https://i.pravatar.cc/150?img=4',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: verdeOscuro,
      body: SafeArea(
        child: Column(
          children: [
            _notificacionesHeader(),
            Expanded(child: _seccionNotificaciones()),
          ],
        ),
      ),
    );
  }

  Widget _notificacionesHeader() {
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

  Widget _seccionNotificaciones() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: notificaciones.length,
      itemBuilder: (context, index) {
        return _itemNotificacion(
          idUsuario: notificaciones[index]['id']!,
          nombre: notificaciones[index]['nombre']!,
          fotoPerfil: notificaciones[index]['foto']!,
        );
      },
    );
  }

  Widget _itemNotificacion({
    required String idUsuario,
    required String nombre,
    required String fotoPerfil,
  }) {
    return InkWell(
      onTap: () {},
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
                  fotoPerfil,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(Icons.person, color: blancoGrisaseo, size: 30);
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
                    'A $nombre le gustó tu reseña',
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
