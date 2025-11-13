import 'package:flutter/material.dart';
import 'package:flutterpostmatch/uiModels/Review.dart';
import 'package:flutterpostmatch/data/local/reviews_list.dart';

class ReviewsScreen extends StatefulWidget {
  const ReviewsScreen({super.key});

  @override
  State<ReviewsScreen> createState() => _ReviewsScreenState();
}

class _ReviewsScreenState extends State<ReviewsScreen> {
  List<Review> _reviews = [];

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() {
    load();
  }

  void load() {
    setState(() {
      _reviews = reviewsGlobales; // usa tu lista de datos mockeados
    });
  }

  @override
  Widget build(BuildContext context) {
    final Color verdeOscuro3 = const Color(0xFF1C1F1E);
    final Color verdePigmentado = const Color(0xFF1F241F);

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
                  itemCount: _reviews.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 16),
                  itemBuilder: (context, index) {
                    final review = _reviews[index];
                    return _reviewCard(
                      review: review,
                      background: verdePigmentado,
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
  required Review review,
  required Color background,
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
                      review.likedByUser
                          ? Icons.favorite
                          : Icons.favorite_border,
                      size: 16,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    "${review.numLikes}",
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                  ),
                  const SizedBox(width: 16),
                  const Icon(Icons.comment, size: 16, color: Colors.white),
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
        // Imagen del partido
        GestureDetector(
          onTap: onReviewClick,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              review.partidoFotoUrl,
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
        ),
      ],
    ),
  );
}
