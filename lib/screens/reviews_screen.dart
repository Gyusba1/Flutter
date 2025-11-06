import 'package:flutter/material.dart';

// modelo simple para pruebas
class ReviewInfo {
  final String idReview;
  final String titulo;
  final String descripcion;
  final String usuarioNombre;
  final String usuarioEmail;
  final int numLikes;
  final int numComentarios;
  final String partidoFotoUrl;

  ReviewInfo({
    required this.idReview,
    required this.titulo,
    required this.descripcion,
    required this.usuarioNombre,
    required this.usuarioEmail,
    required this.numLikes,
    required this.numComentarios,
    required this.partidoFotoUrl,
  });
}

class ReviewsScreen extends StatelessWidget {
  const ReviewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Color verdeOscuro3 = const Color(0xFF1C1F1E);
    final Color verdePigmentado = const Color(0xFF1F241F);
    final Color verdeClaro = const Color(0xFF38AB3D);

    // datos quemados (mock)
    final List<ReviewInfo> reviews = [
      ReviewInfo(
        idReview: "1",
        titulo: "Victoria épica del Real Madrid",
        descripcion: "Un partido lleno de emoción y goles hasta el final.",
        usuarioNombre: "Carlos Pérez",
        usuarioEmail: "carlos@example.com",
        numLikes: 23,
        numComentarios: 5,
        partidoFotoUrl:
            "https://upload.wikimedia.org/wikipedia/commons/5/5c/Santiago_Bernabeu_Stadium_2019.jpg",
      ),
      ReviewInfo(
        idReview: "2",
        titulo: "El clásico más intenso de los últimos años",
        descripcion: "Barcelona y Madrid dieron un espectáculo increíble.",
        usuarioNombre: "María López",
        usuarioEmail: "maria@example.com",
        numLikes: 17,
        numComentarios: 8,
        partidoFotoUrl:
            "https://upload.wikimedia.org/wikipedia/commons/f/fc/Camp_Nou_stadium_view.jpg",
      ),
      ReviewInfo(
        idReview: "3",
        titulo: "Remontada histórica del City",
        descripcion: "El City logró revertir un 0-2 en los últimos 10 minutos.",
        usuarioNombre: "Juan Torres",
        usuarioEmail: "juan@example.com",
        numLikes: 32,
        numComentarios: 12,
        partidoFotoUrl:
            "https://upload.wikimedia.org/wikipedia/commons/7/7a/Etihad_Stadium_Inside_2015.jpg",
      ),
    ];

    return Scaffold(
      backgroundColor: verdeOscuro3,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _reviewHeader(),
              const SizedBox(height: 16),
              Expanded(
                child: ListView.separated(
                  itemCount: reviews.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 16),
                  itemBuilder: (context, index) {
                    final review = reviews[index];
                    return _reviewCard(
                      review: review,
                      background: verdePigmentado,
                      accent: verdeClaro,
                      onLikeClick: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Like en ${review.titulo}')),
                        );
                      },
                      onReviewClick: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Abrir detalles de ${review.titulo}'),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _reviewHeader() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Postmatch",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ],
    );
  }

  Widget _reviewCard({
    required ReviewInfo review,
    required Color background,
    required Color accent,
    required VoidCallback onLikeClick,
    required VoidCallback onReviewClick,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Texto principal
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${review.usuarioNombre} - ${review.usuarioEmail}",
                  style: const TextStyle(color: Colors.white70, fontSize: 12),
                ),
                const SizedBox(height: 4),
                Text(
                  review.titulo,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  review.descripcion,
                  style: const TextStyle(color: Colors.white70, fontSize: 12),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    GestureDetector(
                      onTap: onLikeClick,
                      child: Icon(
                        Icons.favorite_border,
                        size: 16,
                        color: accent,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      "${review.numLikes}",
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                    ),
                    const SizedBox(width: 16),
                    Icon(Icons.person, size: 16, color: accent),
                    const SizedBox(width: 4),
                    Text(
                      "${review.numComentarios}",
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          // Imagen
          GestureDetector(
            onTap: onReviewClick,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                review.partidoFotoUrl,
                width: 120,
                height: 80,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  color: Colors.grey.shade700,
                  width: 120,
                  height: 80,
                  child: const Icon(Icons.broken_image, color: Colors.white70),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
