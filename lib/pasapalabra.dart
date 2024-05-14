import 'package:flutter/material.dart';

class PasaPalabras extends StatefulWidget {
  final String nombreObjetivo;

  const PasaPalabras({Key? key, required this.nombreObjetivo}) : super(key: key);

  @override
  State<PasaPalabras> createState() => _PasaPalabrasState();
}

class _PasaPalabrasState extends State<PasaPalabras> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70), // Altura preferida para la AppBar
        child: AppBar(
          backgroundColor: const Color(0xff60D3F2),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(20),
            ),
          ),
          toolbarHeight: 70, // Altura específica para la AppBar
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
            height: double.infinity,
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 24, // Espacio entre el nombreObjetivo y "PasaPalabras"
                ),
                Text(
                  widget.nombreObjetivo,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'PasaPalabras',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Container(
          // Aquí puedes agregar el contenido del juego "PasaPalabras"
          // Por ejemplo, un formulario, juego interactivo, etc.
        ),
      ),
    );
  }
}
