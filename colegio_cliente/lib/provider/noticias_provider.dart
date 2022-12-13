import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:intl/intl.dart';

class FirestoreService {
  //obtener todos los noticias
  Stream<QuerySnapshot> noticias() {
    // return FirebaseFirestore.instance.collection('noticias').snapshots();
    return FirebaseFirestore.instance.collection('noticias').snapshots();
  }

  //agregar noticias
  Future noticiasAgregar(String titulo, String contenido, DateTime fecha) {
    return FirebaseFirestore.instance.collection('noticias').doc().set({
      'titulo': titulo,
      'contenido': contenido,
      'fecha': fecha,
    });
  }

  //borrar producto
  Future noticiasBorrar(String id) {
    return FirebaseFirestore.instance.collection('noticias').doc(id).delete();
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getNoticias(String id) async {
    return await FirebaseFirestore.instance.collection('noticias').doc(id).get();
    // print(prod['nombre']);
  }

  Future noticiasEditar(String id, String titulo, String contenido) {
    return FirebaseFirestore.instance.collection('noticias').doc(id).update({
      'titulo': titulo,
      'contenido': contenido,
      
    });
  }
}