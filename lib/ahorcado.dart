import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ods_quest/dashboard.dart'; // Importa la librería de Firestore

class Ahorcado extends StatefulWidget {
  final String nombreObjetivo;

  const Ahorcado({Key? key, required this.nombreObjetivo}) : super(key: key);

  @override
  State<Ahorcado> createState() => _AhorcadoState();
}

class _AhorcadoState extends State<Ahorcado> {
  final _formKey = GlobalKey<FormState>();
  HangmanGame _hangmanGame = HangmanGame();
  TextEditingController _letterController = TextEditingController();
  int _errors = 0;

  @override
  void dispose() {
    _letterController.dispose();
    super.dispose();
  }

  void _submitLetter() {
    String letter = _letterController.text.trim().toUpperCase();
    if (letter.isNotEmpty && !_hangmanGame.isLetterGuessed(letter)) {
      bool correctGuess = _hangmanGame.guessLetter(letter);
      setState(() {
        if (!correctGuess) {
          _errors++;
          if (_errors == 4) {
            _showGameOverDialog();
          }
        } else {
          if (_hangmanGame.getVisibleWord() == _hangmanGame._word) {
            _showSuccessDialog();
          }
        }
      });
      _letterController.clear();
    }
  }

  void _restartGame() {
    setState(() {
      _hangmanGame = HangmanGame();
      _errors = 0;
    });
  }

  void _navigateToHomePage() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => Dashboard()),
      (route) => false,
    );
  }

  Future<void> _showGameOverDialog() async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text('Fin del Juego'),
          content: Text('¡Has cometido 4 errores! ¿Qué deseas hacer?'),
          actions: [
            ButtonBar(
              alignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                    _navigateToHomePage();
                  },
                  icon: Icon(Icons.home, color: Colors.white),
                  label: Text(
                    'Volver',
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                    padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(10)),
                  ),
                ),
                TextButton.icon(
                  onPressed: () {
                    _restartGame();
                    Navigator.pop(context);
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => Ahorcado(nombreObjetivo: widget.nombreObjetivo)),
                    );
                  },
                  icon: Icon(Icons.arrow_forward, color: Colors.white),
                  label: Text(
                    'Reintentar',
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(const Color(0xff60D3F2)),
                    padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.all(10)),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Future<void> _showSuccessDialog() async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Center(
            child: Text(
              '¡Felicidades!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          content: Container(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: Image.asset(
                    'assets/img2.png',
                    width: 150,
                    height: 150,
                  ),
                ),
                SizedBox(width: 20),
                Expanded(
                  flex: 2,
                  child: Text(
                    _hangmanGame.getExplanation(),
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            ButtonBar(
              alignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                    _navigateToHomePage();
                  },
                  icon: Icon(Icons.home, color: Colors.white),
                  label: Text(
                    'Regresar',
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                    padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(10)),
                  ),
                ),
                TextButton.icon(
                  onPressed: () {
                    _restartGame();
                    Navigator.pop(context);
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => Ahorcado(nombreObjetivo: widget.nombreObjetivo)),
                    );
                  },
                  icon: Icon(Icons.arrow_forward, color: Colors.white),
                  label: Text(
                    'Continuar',
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(const Color(0xff60D3F2)),
                    padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.all(10)),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

 @override
Widget build(BuildContext context) {
  List<Widget> letterBoxes = [];

  String visibleWord = _hangmanGame.getVisibleWord();

  if (_hangmanGame._word.isNotEmpty) {
    for (int i = 0; i < _hangmanGame._word.length; i++) {
      String letter = _hangmanGame._word[i];
      bool isLetterVisible = visibleWord[i] != ' ';

      Widget letterBox = Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Center(
          child: Text(
            isLetterVisible ? letter : '',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );

      letterBoxes.add(letterBox);
      letterBoxes.add(SizedBox(width: 10));
    }
  }

  return Scaffold(
    appBar: AppBar(
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
      title: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.nombreObjetivo,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Ahorcado',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      actions: [
        _buildLivesIndicator(3 - _errors),
        SizedBox(width: 16),
      ],
    ),
    body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Image.asset(
                    'assets/img1.png',
                    width: 80,
                    height: 80,
                    fit: BoxFit.contain,
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      _hangmanGame.getQuestion(),
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Image.asset(
              'assets/hangman$_errors.png',
              width: 200,
              height: 200,
            ),
            SizedBox(height: 20),
            Wrap(
              spacing: 10, // Espacio horizontal entre las letterBoxes
              runSpacing: 10, // Espacio vertical entre las filas de letterBoxes
              children: letterBoxes,
            ),
            SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: TextField(
                    controller: _letterController,
                    decoration: InputDecoration(
                      labelText: 'Adivina una letra',
                      border: OutlineInputBorder(),
                    ),
                    textAlign: TextAlign.center,
                    autocorrect: false,
                    textCapitalization: TextCapitalization.characters,
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _submitLetter,
                  child: Text('Enviar'),
                ),
              ],
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    ),
  );
}


  Widget _buildLivesIndicator(int lives) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: const Color.fromARGB(0, 244, 67, 54),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.favorite,
            color: Colors.red,
            size: 20,
          ),
          SizedBox(width: 8),
          Text(
            lives.toString(),
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _loadQuestionData(); // Cargar los datos al iniciar el widget
  }

  Future<void> _loadQuestionData() async {
    try {
      // Obtenemos una referencia a la colección de Firebase Firestore
      CollectionReference collection = FirebaseFirestore.instance.collection('preguntas');

      // Obtenemos el documento correspondiente al objetivo seleccionado
      QuerySnapshot querySnapshot = await collection.doc('ahorcado').collection('ods_${_getODSNumber()}').get();

      // Verificamos si hay documentos disponibles
      if (querySnapshot.docs.isNotEmpty) {
        // Obtenemos un documento aleatorio de la lista de documentos
        DocumentSnapshot randomDocument = querySnapshot.docs[Random().nextInt(querySnapshot.docs.length)];

        // Extraemos los datos del documento aleatorio
        String pregunta = randomDocument['pregunta'];
        String respuesta = randomDocument['respuesta'];
        String explicacion = randomDocument['explicacion'];

        // Imprimimos los datos obtenidos
        print('Pregunta: $pregunta');
        print('Respuesta: $respuesta');
        print('Explicación: $explicacion');

        // Actualizamos las variables del juego
        setState(() {
          String respuesta = randomDocument['respuesta'];
          String pregunta = randomDocument['pregunta'];
          String explicacion = randomDocument['explicacion'];

          _hangmanGame.initializeWord(respuesta);
          _hangmanGame.initializeQuestion(pregunta);
          _hangmanGame.initializeExplanation(explicacion);
        });

      } else {
        print('No se encontraron documentos para el objetivo seleccionado.');
      }
    } catch (e) {
      print('Error al cargar los datos: $e');
    }
  }

  // Método para obtener el número de ODS según el nombre del objetivo
  int _getODSNumber() {
    final List<String> nombres = [
      'Fin de la pobreza', 'Hambre cero', 'Salud y bienestar', 'Educación de calidad', 'Igualdad de Género', 'Agua limpia y saneamiento',
      'Energía asequible y no contaminante', 'Trabajo decente y crecimiento económico', 'Industria, innovación e infraestructura', 'Reducción de las desigualdades',
      'Ciudades y comunidades sostenibles', 'Producción y consumo responsables', 'Acción por el clima', 'Vida submarina', 'Vida de ecosistemas terrestres',
      'Paz, justicia e instituciones sólidas', 'Alianzas para lograr los objetivos'
    ];

    return nombres.indexOf(widget.nombreObjetivo) + 1;
  }
}

class HangmanGame {
  late String _word = '';
  late String _question = '';
  late String _explanation = '';
  Set<String> _guessedLetters = {};

  String getQuestion() => _question;

  String getVisibleWord() {
    String visible = '';
    for (int i = 0; i < (_word.length ?? 0); i++) {
      String letter = _word[i];
      if (_guessedLetters.contains(letter)) {
        visible += letter;
      } else {
        visible += ' ';
      }
    }
    return visible;
  }

  bool isLetterGuessed(String letter) {
    return _guessedLetters.contains(letter);
  }

  bool guessLetter(String letter) {
    bool correctGuess = _word.contains(letter.toUpperCase());
    if (correctGuess) {
      _guessedLetters.add(letter.toUpperCase());
    }
    return correctGuess;
  }

  String getExplanation() => _explanation;

  void setExplanation(String explanation) {
    _explanation = explanation;
  }

  void initializeWord(String word) {
    _word = word.toUpperCase();
  }

  void initializeQuestion(String question) {
    _question = question;
  }

  void initializeExplanation(String explanation) {
    _explanation = explanation;
  }
}
