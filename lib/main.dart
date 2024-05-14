// ignore_for_file: avoid_print
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ods_quest/firebase_options.dart';
import 'package:ods_quest/login_page.dart';
import 'package:ods_quest/registration_page.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
FirebaseFirestore.instance.settings = const Settings();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(title: '',),

    );
  }
}

class MyHomePage extends StatelessWidget {
  final String title;
  const MyHomePage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(
                bottom: Radius.circular(30.0),
              ),
              child: Stack(
                children: [
                  // Fondo azul
                  Container(
                    color: const Color(0xff60D3F2),
                  ),
                  // Imagen de fondo
                  Image.asset(
                    'assets/logo.png', // Reemplaza 'background.jpg' por el nombre de tu imagen
                    height: double.infinity,
                    width: double.infinity,
                    
                  ),
                  const Positioned(
                    left: 16,
                    right: 16,
                    bottom: 100,
                    child: Text(
                      'ODS',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 50.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const Positioned(
                    left: 16,
                    right: 16,
                    bottom: 70,
                    child: Text(
                      'Quest',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const Positioned(
                    left: 16,
                    right: 16,
                    bottom: 40,
                    child: Text(
                      '¡Juega y cambia el mundo!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  AppBar(
                    backgroundColor: Colors.transparent, // AppBar sin fondo
                    centerTitle: true,
                    title: Text(
                      title,
                      style: const TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[

                  SizedBox(
                    width: 200,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        print('Botón de Registro presionado');
                        Navigator.push(
                          context,
                        MaterialPageRoute(builder: (context) => const RegistrationPage())


                        );

                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                        side: const BorderSide(color: Color(0xFFFEE264), width: 4),
                      ),
                      child: const Text('Registro'),
                    ),
                  ),

                  const SizedBox(height: 20),


                  SizedBox(
                    width: 200,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        print('Botón de Inicio presionado');
                        Navigator.push(
                          context,
                        MaterialPageRoute(builder: (context) => const LoginPage())


                        );
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
        ],
      ),
    );
  }
}