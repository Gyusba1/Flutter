import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterpostmatch/screens/login/bloc/login_bloc.dart';
import 'package:flutterpostmatch/screens/login/bloc/login_event.dart';
import 'package:flutterpostmatch/screens/login/bloc/login_state.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String usuario = '';
  String correo = '';
  String password = '';
  bool passwordVisible = false;

  // 🎨 Colores
  final Color verdeOscuro = const Color(0xFF121712);
  final Color verdeOscuro2 = const Color(0xFF404F40);
  final Color verdeClaro = const Color(0xFF38AB3D);
  final Color blancoGrisaseo = const Color(0xA9FFFFFF);
  final Color blanco = const Color(0xFFFFFFFF);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LoginBloc(),
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: verdeOscuro,
            body: Stack(
              children: [
                // 🔹 Fondo con imagen completa
                Positioned.fill(
                  child: Image.asset(
                    'assets/images/fondo_login.jpg',
                    fit: BoxFit.cover,
                  ),
                ),

                // 🔹 Contenido desplazado hacia la parte inferior
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: verdeOscuro.withOpacity(0.9),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(24),
                        topRight: Radius.circular(24),
                      ),
                    ),
                    child: SafeArea(
                      top: false,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            const SizedBox(height: 12),
                            _FormLogin(
                              onUsuarioChange: (v) => {
                                context.read<LoginBloc>().add(
                                  UsuarioChanged(v),
                                ),
                              },
                              onEmailChange: (v) => {
                                context.read<LoginBloc>().add(EmailChange(v)),
                              },
                              onPasswordChange: (v) => {
                                context.read<LoginBloc>().add(
                                  PasswordChange(v),
                                ),
                              },
                              passwordVisible: passwordVisible,
                              onTogglePassword: () => setState(
                                () => passwordVisible = !passwordVisible,
                              ),
                              colores: _LoginColors(
                                verdeOscuro2: verdeOscuro2,
                                verdeClaro: verdeClaro,
                                blancoGrisaseo: blancoGrisaseo,
                                blanco: blanco,
                              ),
                            ),
                            const SizedBox(height: 24),
                            _BotonesLogin(
                              usuario: usuario,
                              correo: correo,
                              password: password,
                              colores: _LoginColors(
                                verdeOscuro2: verdeOscuro2,
                                verdeClaro: verdeClaro,
                                blancoGrisaseo: blancoGrisaseo,
                                blanco: blanco,
                              ),
                              onLoginChange: () {
                                if (state.isValid) {
                                  context.push("/reviews");
                                }
                              },
                              onSingUpChange: () {
                                context.push("/registro");
                              },
                            ),
                            const SizedBox(height: 20),
                            _TextoLegal(colorTexto: blancoGrisaseo),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

//
// 🔹 PALETA CENTRALIZADA
//
class _LoginColors {
  final Color verdeOscuro2;
  final Color verdeClaro;
  final Color blancoGrisaseo;
  final Color blanco;

  const _LoginColors({
    required this.verdeOscuro2,
    required this.verdeClaro,
    required this.blancoGrisaseo,
    required this.blanco,
  });
}

//
// 🔹 FORMULARIO DE LOGIN
//
class _FormLogin extends StatelessWidget {
  final Function(String) onUsuarioChange;
  final Function(String) onEmailChange;
  final Function(String) onPasswordChange;
  final bool passwordVisible;
  final VoidCallback onTogglePassword;
  final _LoginColors colores;

  const _FormLogin({
    required this.onUsuarioChange,
    required this.onEmailChange,
    required this.onPasswordChange,
    required this.passwordVisible,
    required this.onTogglePassword,
    required this.colores,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _FieldLogin(
          label: 'Usuario',
          onChange: onUsuarioChange,
          colores: colores,
        ),
        const SizedBox(height: 12),
        _FieldLogin(label: 'Email', onChange: onEmailChange, colores: colores),
        const SizedBox(height: 12),
        _PasswordField(
          label: 'Password',
          value: '',
          onChanged: onPasswordChange,
          passwordVisible: passwordVisible,
          onToggleVisibility: onTogglePassword,
          colores: colores,
        ),
      ],
    );
  }
}

//
// 🔹 INPUT NORMAL
//
class _FieldLogin extends StatelessWidget {
  final Function(String) onChange;
  final String label;
  final _LoginColors colores;

  const _FieldLogin({
    required this.onChange,
    required this.label,
    required this.colores,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (value) => onChange(value),
      style: TextStyle(color: colores.blanco),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: colores.blancoGrisaseo),
        filled: true,
        fillColor: colores.verdeOscuro2,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: colores.verdeClaro.withOpacity(0.5)),
          borderRadius: BorderRadius.circular(8.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: colores.verdeClaro),
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
    );
  }
}

//
// 🔹 INPUT DE PASSWORD
//
class _PasswordField extends StatelessWidget {
  final String label;
  final String value;
  final ValueChanged<String> onChanged;
  final bool passwordVisible;
  final VoidCallback onToggleVisibility;
  final _LoginColors colores;

  const _PasswordField({
    required this.label,
    required this.value,
    required this.onChanged,
    required this.passwordVisible,
    required this.onToggleVisibility,
    required this.colores,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      obscureText: !passwordVisible,
      style: TextStyle(color: colores.blanco),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: colores.blancoGrisaseo),
        filled: true,
        fillColor: colores.verdeOscuro2,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: colores.verdeClaro.withOpacity(0.5)),
          borderRadius: BorderRadius.circular(8.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: colores.verdeClaro),
          borderRadius: BorderRadius.circular(8.0),
        ),
        suffixIcon: IconButton(
          icon: Icon(
            passwordVisible ? Icons.visibility : Icons.visibility_off,
            color: colores.blancoGrisaseo,
          ),
          onPressed: onToggleVisibility,
        ),
      ),
    );
  }
}

//
// 🔹 BOTONES DE LOGIN
//
class _BotonesLogin extends StatelessWidget {
  final String usuario;
  final String correo;
  final String password;
  final Function() onLoginChange;
  final Function() onSingUpChange;
  final _LoginColors colores;

  const _BotonesLogin({
    required this.usuario,
    required this.correo,
    required this.password,
    required this.colores,
    required this.onLoginChange,
    required this.onSingUpChange,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ElevatedButton(
          onPressed: onLoginChange,
          style: ElevatedButton.styleFrom(
            backgroundColor: colores.verdeClaro,
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
          onPressed: onSingUpChange,
          style: ElevatedButton.styleFrom(
            backgroundColor: colores.verdeOscuro2,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Text(
            'Sign Up',
            style: TextStyle(
              color: colores.blanco,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}

//
// 🔹 TEXTO LEGAL
//
class _TextoLegal extends StatelessWidget {
  final Color colorTexto;

  const _TextoLegal({required this.colorTexto});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Text(
        'Al continuar, aceptas nuestros Términos de servicio y Política de privacidad',
        textAlign: TextAlign.center,
        style: TextStyle(color: colorTexto, fontSize: 13),
      ),
    );
  }
}
