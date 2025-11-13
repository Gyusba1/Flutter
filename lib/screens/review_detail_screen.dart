import 'package:flutter/material.dart';
import 'package:flutterpostmatch/uiModels/Review.dart';
import 'package:flutterpostmatch/data/local/reviews_list.dart';

class ReviewDetailScreen extends StatefulWidget {
  final String idReview;

  const ReviewDetailScreen({super.key, required this.idReview});

  @override
  State<ReviewDetailScreen> createState() => _ReviewDetailScreenState();
}

class _ReviewDetailScreenState extends State<ReviewDetailScreen> {
  Review? review;

  @override
  void initState() {
    super.initState();
    _loadReview();
  }

  void _loadReview() {
    review = reviewsGlobales.firstWhere(
      (r) => r.idReview == widget.idReview,
      orElse: () => reviewsGlobales.first,
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (review == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final r = review!;

    final Color verdeOscuro = const Color(0xFF121712);
    final Color verdePigmentado = const Color(0xFF1F241F);

    return Scaffold(
      backgroundColor: verdeOscuro,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _Header(),

            const SizedBox(height: 16),

            _ReviewCard(
              r: r,
              fondo: verdePigmentado,
              onLike: () {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text("Like en ${r.titulo}")));
              },
              onComentar: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Comentario en ${r.titulo}")),
                );
              },
            ),

            const SizedBox(height: 20),

            _PartidoInfo(r: r),

            const SizedBox(height: 20),

            _EstadisticasPartido(r: r),

            const SizedBox(height: 30),

            _SeccionComentariosDummy(),
          ],
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Text(
      "Postmatch",
      style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 22,
      ),
    );
  }
}

class _ReviewCard extends StatelessWidget {
  final Review r;
  final Color fondo;
  final VoidCallback onComentar;
  final VoidCallback onLike;

  const _ReviewCard({
    required this.r,
    required this.fondo,
    required this.onComentar,
    required this.onLike,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: fondo,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Columna izquierda
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${r.usuarioNombre} - ${r.usuarioEmail}",
                  style: const TextStyle(color: Colors.white70, fontSize: 12),
                ),
                const SizedBox(height: 4),
                Text(
                  r.titulo,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),

                const SizedBox(height: 4),

                // ⭐ Calificación
                Row(
                  children: List.generate(
                    r.calificacion,
                    (_) =>
                        const Icon(Icons.star, color: Colors.amber, size: 16),
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  "${r.fecha.day}/${r.fecha.month}/${r.fecha.year}",
                  style: const TextStyle(color: Colors.white60, fontSize: 12),
                ),

                const SizedBox(height: 10),

                Text(
                  r.descripcion,
                  style: const TextStyle(color: Colors.white70, fontSize: 13),
                ),

                const SizedBox(height: 12),

                // ❤️ Likes + 👤 Comentarios
                Row(
                  children: [
                    Icon(
                      r.likedByUser ? Icons.favorite : Icons.favorite_border,
                      color: Colors.white,
                      size: 18,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      "${r.numLikes}",
                      style: const TextStyle(color: Colors.white),
                    ),

                    const SizedBox(width: 20),

                    const Icon(Icons.person, color: Colors.white, size: 18),
                    const SizedBox(width: 4),
                    Text(
                      "${r.numComentarios}",
                      style: const TextStyle(color: Colors.white),
                    ),
                  ],
                ),

                const SizedBox(height: 10),

                const Divider(color: Colors.white24),

                Row(
                  children: [
                    IconButton(
                      onPressed: onComentar,
                      icon: const Icon(
                        Icons.add_comment,
                        color: Colors.white70,
                      ),
                    ),
                    IconButton(
                      onPressed: onLike,
                      icon: const Icon(Icons.favorite, color: Colors.white70),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(width: 12),

          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              r.partidoFotoUrl,
              width: 110,
              height: 90,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Image.asset(
                'assets/images/fondo_estadio.png',
                width: 110,
                height: 90,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PartidoInfo extends StatelessWidget {
  final Review r;

  const _PartidoInfo({required this.r});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF1F241F),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            r.partidoNombre,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),

          const SizedBox(height: 10),

          Text(
            "${r.partidoLocal}  ${r.partidoGolesLocal} - ${r.partidoGolesVisitante}  ${r.partidoVisitante}",
            style: const TextStyle(color: Colors.white70, fontSize: 16),
          ),

          const SizedBox(height: 6),

          Text(
            "${r.partidoFecha.day}/${r.partidoFecha.month}/${r.partidoFecha.year}",
            style: const TextStyle(color: Colors.white60, fontSize: 12),
          ),
        ],
      ),
    );
  }
}

class _EstadisticasPartido extends StatelessWidget {
  final Review r;

  const _EstadisticasPartido({required this.r});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF1F241F),
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Estadísticas del Partido",
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),

          SizedBox(height: 10),

          Text(
            "⚽ Goles, posesión, remates... (mock)",
            style: TextStyle(color: Colors.white70),
          ),
        ],
      ),
    );
  }
}

class _SeccionComentariosDummy extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Text(
      "Comentarios (próximamente)",
      style: TextStyle(color: Colors.white70, fontSize: 14),
    );
  }
}
