import 'dart:collection';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HistorialProvider {
  final String apiUrl = 'http://10.0.2.2:8000/api/historial';

  //Listar todos los historiales
  Future<List<dynamic>> getHistoriales() async {
    var url = Uri.parse(apiUrl);
    var respuesta = await http.get(url);

    if (respuesta.statusCode == 200) {
      return json.decode(respuesta.body);
    } else {
      return [];
    }
  }

  Future<List<dynamic>> getXRut(String rut_alumno) async {
    var url = Uri.parse('$apiUrl/rut/$rut_alumno');
    var respuesta = await http.get(url);

    if (respuesta.statusCode == 200) {
      return json.decode(respuesta.body);
    } else {
      return [];
    }
  }

  //Listar un historial por su codigo
  Future<LinkedHashMap<String, dynamic>> getHistorial(int cod_historial) async {
    var url = Uri.parse('$apiUrl/$cod_historial');
    var respuesta = await http.get(url);

    if (respuesta.statusCode == 200) {
      return json.decode(respuesta.body);
    } else {
      return new LinkedHashMap();
    }
  }

  //Agregar un Historial
  Future<LinkedHashMap<String, dynamic>> historialAgregar(String descripcion,
      String tipo_evento, String fecha, String hora, String rut_alumno) async {
    var url = Uri.parse('$apiUrl');
    var respuesta = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json'
        },
        body: jsonEncode(<String, dynamic>{
          'descripcion': descripcion,
          'tipo_evento': tipo_evento,
          'fecha': fecha,
          'hora': hora,
          'rut_alumno': rut_alumno
        }));
    return json.decode(respuesta.body);
  }

  //Actualizar un historial
  Future<LinkedHashMap<String, dynamic>> historialEditar(
    int cod_historial,
    String descripcion,
    String tipo_evento,
    String fecha,
    String hora,
  ) async {
    var url = Uri.parse('$apiUrl/$cod_historial');
    var respuesta = await http.put(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json'
        },
        body: jsonEncode(<String, dynamic>{
          'descripcion': descripcion,
          'tipo_evento': tipo_evento,
          'fecha': fecha,
          'hora': hora,
        }));
    return json.decode(respuesta.body);
  }

  //borra un historial
  Future<bool> historialBorrar(int cod_historial) async {
    var url = Uri.parse('$apiUrl/$cod_historial');
    var respuesta = await http.delete(url);
    return respuesta.statusCode == 200;
  }
}
