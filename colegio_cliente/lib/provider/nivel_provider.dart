import 'dart:collection';
import 'dart:convert';
import 'package:image_picker/image_picker.dart';

import 'package:http/http.dart' as http;

class NivelProvider {
  final String apiUrl = 'http://10.0.2.2:8000/api/nivel';

  // Listar Niveles
  Future<List<dynamic>> getNiveles() async {
    var url = Uri.parse(apiUrl);
    var respuesta = await http.get(url);

    if (respuesta.statusCode == 200) {
      return json.decode(respuesta.body);
    } else {
      return [];
    }
  }

  //Muestra 1 nivel por su codigo o nombre
  Future<LinkedHashMap<String, dynamic>> getNivel(int cod_nivel) async {
    var url = Uri.parse('$apiUrl/$cod_nivel');
    var respuesta = await http.get(url);

    if (respuesta.statusCode == 200) {
      return json.decode(respuesta.body);
    } else {
      return new LinkedHashMap();
    }
  }

  //Agrega un Nivel
  Future<LinkedHashMap<String, dynamic>> nivelAgregar(
      String nombre_nivel, String? imagen) async {
    var url = Uri.parse('$apiUrl');
    var respuesta = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json'
        },
        body: jsonEncode(
            <String, dynamic>{'nombre_nivel': nombre_nivel, 'imagen': imagen}));
    return json.decode(respuesta.body);
  }

  //Actualizar un Nivel
  Future<LinkedHashMap<String, dynamic>> nivelsEditar(
      int cod_nivel, String nombre_nivel, String? imagen) async {
    var url = Uri.parse('$apiUrl/$cod_nivel');
    var respuesta = await http.put(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json'
        },
        body: jsonEncode(
            <String, dynamic>{'nombre_nivel': nombre_nivel, 'imagen': imagen}));
    return json.decode(respuesta.body);
  }

  //borra un nivel
  Future<bool> nivelBorrar(int cod_nivel) async {
    var url = Uri.parse('$apiUrl/$cod_nivel');
    var respuesta = await http.delete(url);
    return respuesta.statusCode == 200;
  }
}
