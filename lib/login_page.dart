import 'package:flutter/material.dart';
import 'package:ods_quest/dashboard.dart';
import 'package:ods_quest/utils/auth.dart'; // Importa tu AuthService aquí

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _authService = AuthService(); // Instancia de tu AuthService

  String _email = '';
  String _password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'assets/logo.png',
          height: 200,
          fit: BoxFit.contain,
        ),
        backgroundColor: const Color(0xff60D3F2),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
        toolbarHeight: 300,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
            size: 30,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(20),
            ),
            color: Color(0xff60D3F2),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 70),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Correo electrónico',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      borderSide: BorderSide(color: Color(0xFFFEE264), width: 4),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      borderSide: BorderSide(color: Color(0xFFFEE264), width: 4),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      borderSide: BorderSide(color: Color(0xFFFEE264), width: 4),
                    ),
                  ),
                  onChanged: (value) {
                    _email = value;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Contraseña',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      borderSide: BorderSide(color: Color(0xFFFEE264), width: 4),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      borderSide: BorderSide(color: Color(0xFFFEE264), width: 4),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      borderSide: BorderSide(color: Color(0xFFFEE264), width: 4),
                    ),
                  ),
                  onChanged: (value) {
                    _password = value;
                  },
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: 200,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () async {
                      _formKey.currentState?.save();
                      if (_formKey.currentState?.validate() ?? false) {
                        // Llamada a la función signInWithEmailAndPassword
                        final result = await _authService.signInWithEmailAndPassword(_email, _password);
                        if (result != null) {

                          print('iniciando sesion');
                          // Si el inicio de sesión es exitoso, navegar a la pantalla Dashboard
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => const Dashboard()),
                          );
                        } else {
                          // Si hay un error durante el inicio de sesión, puedes mostrar un mensaje
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Error al iniciar sesión'),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFEE264),
                      foregroundColor: Colors.black,
                    ),
                    child: const Text('Inicia sesión'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
