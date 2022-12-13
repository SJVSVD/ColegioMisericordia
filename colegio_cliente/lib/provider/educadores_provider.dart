import 'dart:collection';
import 'dart:convert';

import 'package:http/http.dart' as http;

class EducadoresProvider {
  final String apiUrl = 'http://10.0.2.2:8000/api/educadores';

  //Listar todos los Educadores
  Future<List<dynamic>> getEducadores() async {
    var url = Uri.parse(apiUrl);
    var respuesta = await http.get(url);

    if (respuesta.statusCode == 200) {
      return json.decode(respuesta.body);
    } else {
      return [];
    }
  }

  //Listar todos los Educadores por nivel
  Future<List<dynamic>> getEducadoresXNivel(int nivel) async {
    var url = Uri.parse('$apiUrl/niv/$nivel');
    var respuesta = await http.get(url);

    if (respuesta.statusCode == 200) {
      return json.decode(respuesta.body);
    } else {
      return [];
    }
  }

  //Listar un Educador por Rut
  Future<LinkedHashMap<String, dynamic>> getEducador(String rut) async {
    var url = Uri.parse('$apiUrl/$rut');
    var respuesta = await http.get(url);

    if (respuesta.statusCode == 200) {
      return json.decode(respuesta.body);
    } else {
      return new LinkedHashMap();
    }
  }

  //Agregar un Educador
  Future<LinkedHashMap<String, dynamic>> educadorAgregar(
      String rut,
      String nombre,
      String fechaNacimiento,
      String telefono,
      String email,
      String sexo,
      int cod_nivel) async {
    var url = Uri.parse('$apiUrl');
    var respuesta = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json'
        },
        body: jsonEncode(<String, dynamic>{
          'rut': rut,
          'nombre': nombre,
          'fechaNacimiento': fechaNacimiento,
          'telefono': telefono,
          'email': email,
          'sexo': sexo,
          'cod_nivel': cod_nivel
        }));
    return json.decode(respuesta.body);
  }

  //Actualizar un Educador
  Future<LinkedHashMap<String, dynamic>> educadorEditar(
      String rut,
      String nombre,
      String fechaNacimiento,
      String telefono,
      String sexo,
      String email,
      int cod_nivel) async {
    var url = Uri.parse('$apiUrl/$rut');
    var respuesta = await http.put(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json'
        },
        body: jsonEncode(<String, dynamic>{
          'nombre': nombre,
          'fechaNacimiento': fechaNacimiento,
          'telefono': telefono,
          'sexo': sexo,
          'email': email,
          'cod_nivel': cod_nivel
        }));
    return json.decode(respuesta.body);
  }

  //borra un educador
  Future<bool> educadorBorrar(String rut) async {
    var url = Uri.parse('$apiUrl/$rut');
    var respuesta = await http.delete(url);
    return respuesta.statusCode == 200;
  }
}
