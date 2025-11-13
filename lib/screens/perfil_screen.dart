import 'package:flutter/material.dart';
import 'package:flutterpostmatch/uiModels/Usuario.dart';
import 'package:flutterpostmatch/data/local/usuarios_list.dart';

class PerfilScreen extends StatefulWidget {
  final String? id; // Puede venir null

  const PerfilScreen({super.key, this.id});

  @override
  State<PerfilScreen> createState() => _PerfilScreenState();
}

class _PerfilScreenState extends State<PerfilScreen> {
  late Usuario usuario;
  bool seguido = false;
  bool historiaActiva = true;
  bool isCurrentUser = false;

  // 🎨 Colores
  final Color verdeOscuro = const Color(0xFF121712);
  final Color verdeOscuro2 = const Color(0xFF404F40);
  final Color verde = const Color(0xFF2B362B);
  final Color verdeClaro = const Color(0xFF38AB3D);
  final Color blancoGrisaseo = const Color(0xA9FFFFFF);

  @override
  void initState() {
    super.initState();
    _loadUsuario();
  }

  void _loadUsuario() {
    usuario = usuariosGlobales.firstWhere(
      (u) => u.idUsuario == widget.id,
      orElse: () => usuariosGlobales.first,
    );
    isCurrentUser = usuario.idUsuario == usuariosGlobales.first.idUsuario;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: verdeOscuro,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              PerfilHeader(
                color: blancoGrisaseo,
                onBack: () => Navigator.pop(context),
                onSettings: () {},
              ),
              const SizedBox(height: 16),
              ImagenPerfil(
                usuario: usuario,
                historiaActiva: historiaActiva,
                isCurrentUser: isCurrentUser,
                verdeClaro: verdeClaro,
                verdeOscuro2: verdeOscuro2,
                blancoGrisaseo: blancoGrisaseo,
                onVerHistoria: () {},
                onSubirHistoria: () {},
                onCambiarFoto: () {},
              ),
              const SizedBox(height: 16),
              if (!isCurrentUser)
                SeguirButton(
                  seguido: seguido,
                  verdeClaro: verdeClaro,
                  verdeOscuro2: verdeOscuro2,
                  onPressed: () => setState(() => seguido = !seguido),
                ),
              const SizedBox(height: 16),
              InformacionCuenta(
                seguidores: usuario.numFollowers,
                seguidos: usuario.numFollowed,
                verdeOscuro2: verdeOscuro2,
                blancoGrisaseo: blancoGrisaseo,
              ),
              const SizedBox(height: 24),
              TextoIzquierda(texto: "Reseñas", color: blancoGrisaseo),
              const SizedBox(height: 8),
              ListaResenias(
                isCurrentUser: isCurrentUser,
                verde: verde,
                verdeClaro: verdeClaro,
                blancoGrisaseo: blancoGrisaseo,
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

// ----------------------------- COMPONENTES -----------------------------

class PerfilHeader extends StatelessWidget {
  final Color color;
  final VoidCallback onBack;
  final VoidCallback onSettings;

  const PerfilHeader({
    super.key,
    required this.color,
    required this.onBack,
    required this.onSettings,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: Icon(Icons.arrow_back_ios_new, color: color),
            onPressed: onBack,
          ),
          Text(
            'Perfil',
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
          IconButton(
            icon: Icon(Icons.settings, color: color),
            onPressed: onSettings,
          ),
        ],
      ),
    );
  }
}

class ImagenPerfil extends StatelessWidget {
  final Usuario usuario;
  final bool historiaActiva;
  final bool isCurrentUser;
  final Color verdeClaro;
  final Color verdeOscuro2;
  final Color blancoGrisaseo;
  final VoidCallback onVerHistoria;
  final VoidCallback onSubirHistoria;
  final VoidCallback onCambiarFoto;

  const ImagenPerfil({
    super.key,
    required this.usuario,
    required this.historiaActiva,
    required this.isCurrentUser,
    required this.verdeClaro,
    required this.verdeOscuro2,
    required this.blancoGrisaseo,
    required this.onVerHistoria,
    required this.onSubirHistoria,
    required this.onCambiarFoto,
  });

  @override
  Widget build(BuildContext context) {
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
                  gradient: LinearGradient(colors: [verdeClaro, verdeOscuro2]),
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
                image: DecorationImage(
                  image: NetworkImage(usuario.fotoPerfilUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            if (historiaActiva)
              Positioned(
                top: 12,
                right: 12,
                child: GestureDetector(
                  onTap: onVerHistoria,
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
                  onTap: onSubirHistoria,
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
            onPressed: onCambiarFoto,
            style: ElevatedButton.styleFrom(
              backgroundColor: verdeClaro,
              foregroundColor: Colors.white,
            ),
            child: const Text('Seleccionar Imagen'),
          ),
        const SizedBox(height: 8),
        Text(
          usuario.nombre,
          style: TextStyle(
            color: blancoGrisaseo,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        Text(
          "@${usuario.email.split('@').first}",
          style: TextStyle(
            color: blancoGrisaseo.withOpacity(0.7),
            fontSize: 14,
          ),
        ),
        Text(
          'Futbolista',
          style: TextStyle(
            color: blancoGrisaseo.withOpacity(0.7),
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}

class SeguirButton extends StatelessWidget {
  final bool seguido;
  final Color verdeClaro;
  final Color verdeOscuro2;
  final VoidCallback onPressed;

  const SeguirButton({
    super.key,
    required this.seguido,
    required this.verdeClaro,
    required this.verdeOscuro2,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: seguido ? verdeOscuro2 : verdeClaro,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      ),
      child: Text(
        seguido ? 'Siguiendo' : 'Seguir',
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class InformacionCuenta extends StatelessWidget {
  final int seguidores;
  final int seguidos;
  final Color verdeOscuro2;
  final Color blancoGrisaseo;

  const InformacionCuenta({
    super.key,
    required this.seguidores,
    required this.seguidos,
    required this.verdeOscuro2,
    required this.blancoGrisaseo,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _cajaInfoNumFollow(seguidores, "Seguidores"),
        const SizedBox(width: 24),
        _cajaInfoNumFollow(seguidos, "Seguidos"),
      ],
    );
  }

  Widget _cajaInfoNumFollow(int num, String label) {
    return Container(
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
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: blancoGrisaseo.withOpacity(0.7),
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}

class TextoIzquierda extends StatelessWidget {
  final String texto;
  final Color color;

  const TextoIzquierda({super.key, required this.texto, required this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, top: 8, bottom: 8),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          texto,
          style: TextStyle(
            color: color,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

class ListaResenias extends StatelessWidget {
  final bool isCurrentUser;
  final Color verde;
  final Color verdeClaro;
  final Color blancoGrisaseo;

  const ListaResenias({
    super.key,
    required this.isCurrentUser,
    required this.verde,
    required this.verdeClaro,
    required this.blancoGrisaseo,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(3, (index) {
        return ItemReseniaPerfil(
          titulo: 'Título de reseña $index',
          descripcion: 'Descripción de la reseña del usuario.',
          calificacion: 4,
          isCurrentUser: isCurrentUser,
          verde: verde,
          verdeClaro: verdeClaro,
          blancoGrisaseo: blancoGrisaseo,
        );
      }),
    );
  }
}

class ItemReseniaPerfil extends StatelessWidget {
  final String titulo;
  final String descripcion;
  final int calificacion;
  final bool isCurrentUser;
  final Color verde;
  final Color verdeClaro;
  final Color blancoGrisaseo;

  const ItemReseniaPerfil({
    super.key,
    required this.titulo,
    required this.descripcion,
    required this.calificacion,
    required this.isCurrentUser,
    required this.verde,
    required this.verdeClaro,
    required this.blancoGrisaseo,
  });

  @override
  Widget build(BuildContext context) {
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
                  style: TextStyle(
                    color: blancoGrisaseo.withOpacity(0.8),
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 8),
                if (isCurrentUser)
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit, color: verdeClaro, size: 22),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                          size: 22,
                        ),
                        onPressed: () {},
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
