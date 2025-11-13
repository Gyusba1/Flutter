import 'package:flutter/material.dart';

class RegistroScreen extends StatefulWidget {
  const RegistroScreen({super.key});

  @override
  State<RegistroScreen> createState() => _RegistroScreenState();
}

class _RegistroScreenState extends State<RegistroScreen> {
  String nombre = "";
  String email = "";
  String password = "";
  String fotoUrl = "";
  String? errorMessage;

  final Color verdeOscuro = const Color(0xFF121712);
  final Color verdeOscuro3 = const Color(0xFF1C1F1E);
  final Color verdePigmentado = const Color(0xFF1F241F);
  final Color verdeClaro = const Color(0xFF38AB3D);
  final Color blancoGrisaseo = const Color(0xA9FFFFFF);
  final Color colorPiel = const Color(0xFFF5E1C5);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: verdeOscuro3,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _encabezadoRegistro(context),

              const SizedBox(height: 60),

              _campoTexto(
                label: "Nombre",
                value: nombre,
                onChanged: (v) => setState(() => nombre = v),
              ),
              const SizedBox(height: 30),

              _campoTexto(
                label: "Email",
                value: email,
                onChanged: (v) => setState(() => email = v),
              ),
              const SizedBox(height: 30),

              _campoTexto(
                label: "Contraseña",
                value: password,
                onChanged: (v) => setState(() => password = v),
                obscureText: true,
              ),
              const SizedBox(height: 30),

              _campoTexto(
                label: "Foto de perfil (URL)",
                value: fotoUrl,
                onChanged: (v) => setState(() => fotoUrl = v),
              ),

              const SizedBox(height: 10),

              if (errorMessage != null)
                Text(errorMessage!, style: const TextStyle(color: Colors.red)),

              const SizedBox(height: 40),

              _botonRegistrar(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _encabezadoRegistro(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back_ios_new),
              color: Colors.white,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            const Expanded(
              child: Text(
                "Registro de usuario",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ),
            const SizedBox(width: 48), // balance visual
          ],
        ),
        const SizedBox(height: 25),

        // Logo
        Container(
          width: 125,
          height: 125,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Colors.transparent,
            image: const DecorationImage(
              image: AssetImage('assets/images/logo_postmatch.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),

        const SizedBox(height: 15),

        const Text(
          "Empieza a postear",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _campoTexto({
    required String label,
    required String value,
    required ValueChanged<String> onChanged,
    bool obscureText = false,
  }) {
    return TextField(
      style: const TextStyle(color: Colors.white),
      obscureText: obscureText,
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white70),
        filled: true,
        fillColor: verdePigmentado,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 18,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _botonRegistrar() {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: verdeClaro,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        onPressed: () {
          setState(() {
            // Aquí iría la lógica del ViewModel
            if (nombre.isEmpty || email.isEmpty || password.isEmpty) {
              errorMessage = "Por favor completa todos los campos";
            } else {
              errorMessage = null;
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Usuario registrado con éxito")),
              );
            }
          });
        },
        child: const Text(
          "Registrar",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    );
  }
}
