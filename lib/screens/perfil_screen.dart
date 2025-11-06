import 'package:flutter/material.dart';

class PerfilScreen extends StatefulWidget {
  const PerfilScreen({super.key});

  @override
  State<PerfilScreen> createState() => _PerfilScreenState();
}

class _PerfilScreenState extends State<PerfilScreen> {
  bool seguido = false;
  bool historiaActiva = true;
  bool isCurrentUser = true;

  // 🎨 Colores desde colors.xml
  final Color verdeOscuro = const Color(0xFF121712);
  final Color verdeOscuro2 = const Color(0xFF404F40);
  final Color verde = const Color(0xFF2B362B);
  final Color verdeClaro = const Color(0xFF38AB3D);
  final Color blancoGrisaseo = const Color(0xA9FFFFFF);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: verdeOscuro,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _perfilHeader(),
              const SizedBox(height: 16),
              _imagenPerfil(),
              const SizedBox(height: 16),
              if (!isCurrentUser) _seguirButton(),
              const SizedBox(height: 16),
              _informacionCuenta(),
              const SizedBox(height: 24),
              _textoIzquierda("Reseñas"),
              const SizedBox(height: 8),
              _listaResenias(),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _perfilHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: Icon(Icons.arrow_back_ios_new, color: blancoGrisaseo),
            onPressed: () {
              // acción de volver
            },
          ),
          Text(
            'Perfil',
            style: TextStyle(
              color: blancoGrisaseo,
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
          IconButton(
            icon: Icon(Icons.settings, color: blancoGrisaseo),
            onPressed: () {
              // acción de configuración
            },
          ),
        ],
      ),
    );
  }

  Widget _imagenPerfil() {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            if (historiaActiva)
              Container(
                width: 210,
                height: 210,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [verdeClaro, verdeOscuro2],
                  ),
                ),
              ),
            Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: !historiaActiva
                    ? Border.all(color: verdeOscuro2, width: 2)
                    : null,
                image: const DecorationImage(
                  image: AssetImage('assets/user_icon.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            if (historiaActiva)
              Positioned(
                top: 12,
                right: 12,
                child: GestureDetector(
                  onTap: () {
                    // ver historia
                  },
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.black54,
                      shape: BoxShape.circle,
                    ),
                    padding: const EdgeInsets.all(6),
                    child: Icon(Icons.visibility, color: blancoGrisaseo),
                  ),
                ),
              ),
            if (isCurrentUser)
              Positioned(
                bottom: 12,
                right: 12,
                child: GestureDetector(
                  onTap: () {
                    // subir historia
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: verdeClaro,
                      shape: BoxShape.circle,
                    ),
                    padding: const EdgeInsets.all(6),
                    child: const Icon(Icons.add, color: Colors.white),
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: 12),
        if (isCurrentUser)
          ElevatedButton(
            onPressed: () {
              // cambiar foto
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: verdeClaro,
              foregroundColor: Colors.white,
            ),
            child: const Text('Seleccionar Imagen'),
          ),
        const SizedBox(height: 8),
        Text(
          'Nombre del Usuario',
          style: TextStyle(
              color: blancoGrisaseo, fontWeight: FontWeight.bold, fontSize: 20),
        ),
        Text(
          '@usuario',
          style: TextStyle(color: blancoGrisaseo.withOpacity(0.7), fontSize: 14),
        ),
        Text(
          'Futbolista',
          style: TextStyle(color: blancoGrisaseo.withOpacity(0.7), fontSize: 14),
        ),
      ],
    );
  }

  Widget _seguirButton() {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          seguido = !seguido;
        });
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: seguido ? verdeOscuro2 : verdeClaro,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      ),
      child: Text(
        seguido ? 'Siguiendo' : 'Seguir',
        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _informacionCuenta() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _cajaInfoNumFollow(120, "Seguidores", onTap: () {}),
        const SizedBox(width: 24),
        _cajaInfoNumFollow(89, "Seguidos", onTap: () {}),
      ],
    );
  }

  Widget _cajaInfoNumFollow(int num, String label, {required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 100,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(color: verdeOscuro2),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Text(
              num.toString(),
              style: TextStyle(
                  color: blancoGrisaseo,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(color: blancoGrisaseo.withOpacity(0.7), fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }

  Widget _textoIzquierda(String texto) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, top: 8, bottom: 8),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          texto,
          style: TextStyle(
            color: blancoGrisaseo,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _listaResenias() {
    return Column(
      children: List.generate(3, (index) {
        return _itemReseniaPerfil(
          titulo: 'Título de reseña $index',
          descripcion: 'Descripción de la reseña del usuario.',
          calificacion: 4,
          isCurrentUser: isCurrentUser,
        );
      }),
    );
  }

  Widget _itemReseniaPerfil({
    required String titulo,
    required String descripcion,
    required int calificacion,
    required bool isCurrentUser,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: verde,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 7,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: List.generate(
                    calificacion,
                    (index) =>
                        const Icon(Icons.star, color: Colors.yellow, size: 16),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  titulo,
                  style: TextStyle(
                    color: blancoGrisaseo,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  descripcion,
                  style:
                      TextStyle(color: blancoGrisaseo.withOpacity(0.8), fontSize: 14),
                ),
                const SizedBox(height: 8),
                if (isCurrentUser)
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit, color: verdeClaro, size: 22),
                        onPressed: () {
                          // modificar reseña
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red, size: 22),
                        onPressed: () {
                          // eliminar reseña
                        },
                      ),
                    ],
                  ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            flex: 3,
            child: Container(
              height: 90,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: const DecorationImage(
                  image: AssetImage('assets/ricardo_icon.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
