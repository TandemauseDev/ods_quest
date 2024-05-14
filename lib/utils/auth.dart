import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class AuthService{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore db = FirebaseFirestore.instance;

Future createAcount(String correo, String contrasena, String nombre, String edad) async {
  try {
    UserCredential userCredential = await _auth.createUserWithEmailAndPassword(email: correo, password: contrasena);
    print('Usuario creado con éxito: ${userCredential.user?.uid}');
    
    // Guardar datos adicionales en Firestore
    await db.collection('usuarios').doc(userCredential.user?.uid).set({
      'nombre': nombre,
      'edad': edad,
      'correo': correo,
    });

    // Retorna el UID del usuario
    return userCredential.user?.uid;
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      print('La contraseña es débil: ${e.message}');
      return 'La contraseña es débil';
    } else if (e.code == 'email-already-in-use') {
      print('La cuenta ya existe para ese email: ${e.message}');
      return 'El correo ya está en uso';
    } else {
      // Imprimir mensaje de error para otras excepciones FirebaseAuth
      print('Error de FirebaseAuth: ${e.code} - ${e.message}');
      return 'Error al crear la cuenta: ${e.message}';
    }
  } catch (e) {
    // Imprimir mensaje de error para otras excepciones no controladas
    print('Error al crear la cuenta: $e');
    return 'Error al crear la cuenta: $e';
  }
}



 Future<String?> signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = userCredential.user;
      if (user != null) {
        return user.uid; // Retorna el UID del usuario si el inicio de sesión es exitoso
      } else {
        return null; // Maneja el caso de usuario nulo si ocurre de manera inesperada
      }
    } catch (e) {
      print('Error al iniciar sesión: $e');
      return null; // Maneja el error y devuelve null
    }
  }

  // Opcional: Implementa la función de cierre de sesión si es necesaria en tu aplicación
  Future<void> signOut() async {
    await _auth.signOut();
  }
}

