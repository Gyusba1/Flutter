import 'package:flutter/material.dart';
import 'package:flutterpostmatch/screens/registro_screen.dart';
import 'package:flutterpostmatch/screens/reviews_screen.dart';
import 'package:flutterpostmatch/screens/perfil_screen.dart';
import 'package:flutterpostmatch/screens/login_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: PerfilScreen());
  }
}
