import 'package:flutter/material.dart';
import 'package:flutterpostmatch/screens/notificaciones_screen.dart';
import 'package:flutterpostmatch/screens/partido_detail_screen.dart';
import 'package:flutterpostmatch/screens/partidos_screen.dart';
import 'package:flutterpostmatch/screens/registro/registro_screen.dart';
import 'package:flutterpostmatch/screens/review_detail_screen.dart';
import 'package:flutterpostmatch/screens/reviews_screen.dart';
import 'package:flutterpostmatch/screens/perfil_screen.dart';
import 'package:flutterpostmatch/screens/login/login_screen.dart';
import 'package:go_router/go_router.dart';

final _router = GoRouter(
  routes: [
    GoRoute(path: "/", builder: (context, state) => const PartidosScreen()),
    GoRoute(
      path: "/reviews",
      builder: (context, state) => const ReviewsScreen(),
    ),
    GoRoute(
      path: "/partidos",
      builder: (context, state) => const PartidosScreen(),
    ),
    GoRoute(path: "/login", builder: (context, state) => const LoginScreen()),
    GoRoute(
      path: "/registro",
      builder: (context, state) => const RegistroScreen(),
    ),
    GoRoute(
      path: "/notificaciones",
      builder: (context, state) => const NotificacionesScreen(),
    ),
    GoRoute(
      path: "/perfil/:idUsuario",
      builder: (context, state) {
        final id = state.pathParameters['idUsuario'];
        return PerfilScreen(id: id);
      },
    ),
    GoRoute(
      path: "/review/:idReview",
      builder: (context, state) {
        final idReview = state.pathParameters['idReview']!;
        return ReviewDetailScreen(idReview: idReview);
      },
    ),
    GoRoute(
      path: "/partido/:idPartido",
      builder: (context, state) {
        final idPartido = state.pathParameters['idPartido']!;
        return PartidoDetailScreen(idPartido: idPartido);
      },
    ),
  ],
);

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(routerConfig: _router);
  }
}
