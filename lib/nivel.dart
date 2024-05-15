import 'package:flutter/material.dart';
import 'package:ods_quest/ahorcado.dart';
import 'package:ods_quest/pasapalabra.dart';
import 'package:ods_quest/sopa.dart';

class Nivel extends StatefulWidget {
  final String nombreObjetivo;

  const Nivel({Key? key, required this.nombreObjetivo}) : super(key: key);

  @override
  State<Nivel> createState() => _NivelState();
}

class _NivelState extends State<Nivel> {
  String? _tipoJuegoSeleccionado;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.nombreObjetivo,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xff60D3F2),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
        toolbarHeight: 70,
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
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Primera fila con dos columnas
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _tipoJuegoSeleccionado = 'Ahorcado';
                      });
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Ahorcado(nombreObjetivo: widget.nombreObjetivo),
                        ),
                      );
                    },
                    child: _buildJuegoCard('Ahorcado'),
                  ),

                GestureDetector(
                  onTap: () {
                    setState(() {
                      _tipoJuegoSeleccionado = 'Sopa de Letras';
                    });
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Sopa(nombreObjetivo: widget.nombreObjetivo),
                        ),
                      );
                  },
                  child: _buildJuegoCard('Sopa de Letras'),
                ),
              ],
            ),
            const SizedBox(height: 20), // Separación entre filas
            // Segunda fila con una columna centrada horizontalmente
            Center(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _tipoJuegoSeleccionado = 'Pasapalabras';
                  });
                  Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PasaPalabras(nombreObjetivo: widget.nombreObjetivo),
                        ),
                      );
                },
                child: _buildJuegoCard('Pasapalabras'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildJuegoCard(String juego) {
    return Container(
      width: 150, // Ancho del contenedor (puedes ajustar este valor)
      height: 150, // Alto del contenedor (mismo que el ancho para hacerlo cuadrado)
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 3,
            blurRadius: 5,
            offset: Offset(0, 3), // Cambia la posición de la sombra
          ),
        ],
      ),
      child: Center(
        child: Align(
          alignment: Alignment.center,
          child: Text(
            juego,
            style: TextStyle(
              color: Colors.black,
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
