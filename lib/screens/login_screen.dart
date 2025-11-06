import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController usuarioController = TextEditingController();
  final TextEditingController correoController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool passwordVisible = false;

  // 🎨 Colores del colors.xml
  final Color verdeOscuro = const Color(0xFF121712);
  final Color verdeOscuro2 = const Color(0xFF404F40);
  final Color verdeClaro = const Color(0xFF38AB3D);
  final Color blancoGrisaseo = const Color(0xA9FFFFFF);
  final Color blanco = const Color(0xFFFFFFFF);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: verdeOscuro,
      body: Stack(
        children: [
          Image.asset(
            'assets/fondo_login.png',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const SizedBox(height: 100),
                _formLogin(),
                const SizedBox(height: 30),
                _botonesLogin(context),
                const SizedBox(height: 25),
                _textoLegal(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _formLogin() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _fieldLogin(
          label: 'Usuario',
          controller: usuarioController,
        ),
        const SizedBox(height: 12),
        _fieldLogin(
          label: 'Correo',
          controller: correoController,
        ),
        const SizedBox(height: 12),
        _passwordField(
          label: 'Contraseña',
          controller: passwordController,
        ),
      ],
    );
  }

  Widget _fieldLogin({
    required String label,
    required TextEditingController controller,
  }) {
    return TextField(
      controller: controller,
      style: TextStyle(color: blanco),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: blancoGrisaseo),
        filled: true,
        fillColor: verdeOscuro2,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: verdeClaro.withOpacity(0.5)),
          borderRadius: BorderRadius.circular(8.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: verdeClaro),
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
    );
  }

  Widget _passwordField({
    required String label,
    required TextEditingController controller,
  }) {
    return TextField(
      controller: controller,
      obscureText: !passwordVisible,
      style: TextStyle(color: blanco),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: blancoGrisaseo),
        filled: true,
        fillColor: verdeOscuro2,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: verdeClaro.withOpacity(0.5)),
          borderRadius: BorderRadius.circular(8.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: verdeClaro),
          borderRadius: BorderRadius.circular(8.0),
        ),
        suffixIcon: IconButton(
          icon: Icon(
            passwordVisible ? Icons.visibility : Icons.visibility_off,
            color: blancoGrisaseo,
          ),
          onPressed: () {
            setState(() {
              passwordVisible = !passwordVisible;
            });
          },
        ),
      ),
    );
  }

  Widget _botonesLogin(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ElevatedButton(
          onPressed: () {
            // Acción de login
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: verdeClaro,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: const Text(
            'Log In',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 12),
        ElevatedButton(
          onPressed: () {
            // Acción de sign up
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: verdeOscuro2,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Text(
            'Sign Up',
            style: TextStyle(color: blanco, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  Widget _textoLegal() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Text(
        'Al continuar, aceptas nuestros Términos de servicio y Política de privacidad',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: blancoGrisaseo,
          fontSize: 13,
        ),
      ),
    );
  }
}
