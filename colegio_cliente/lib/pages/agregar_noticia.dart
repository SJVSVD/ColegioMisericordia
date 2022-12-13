import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:colegio_cliente/provider/noticias_provider.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';


class AgregarNoticia extends StatefulWidget {
  AgregarNoticia({Key? key}) : super(key: key);

  @override
  State<AgregarNoticia> createState() => _AgregarNoticiaState();
}

class _AgregarNoticiaState extends State<AgregarNoticia> {
  //colores del sistema
  final primerColor = Color(0xFFFFBE86);
  final AmarilloColor = Color(0xFFFFE156);
  final rosadoColor = Color(0xFFFFB5C2);
  final incipidoColor = Color(0xFFFFE9CE);
  var formatoFecha = DateFormat('dd/MM/yyyy hh:mm');
  var fechaActual = DateTime.now();
  //formulario
  final formKey = GlobalKey<FormState>();
  String? foto = null;
  TextEditingController tituloCtrl = new TextEditingController();
  TextEditingController contenidoCtrl = new TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Agregar Noticia"),
        backgroundColor: primerColor,
      ),
      body: Form(
        key: formKey,
        child: Padding(
            padding: EdgeInsets.all(20),
            child: Container(
              child: Column(
                children: [
                  TextFormField(
                    controller: tituloCtrl,
                    decoration: InputDecoration(
                      labelText: 'Titulo de la Noticia',
                    ),
                    validator: (valor) {
                      if (valor == null || valor.isEmpty) {
                        return 'Indique el Titulo';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    maxLines: 5,
                    controller: contenidoCtrl,
                    decoration: InputDecoration(
                      labelText: 'Contenido de la noticia',
                    ),
                    validator: (valor) {
                      if (valor == null || valor.isEmpty) {
                        return 'Indique el Titulo';
                      }
                      return null;
                    },
                  ),
                  Row(
                  children: [
                    Text('Fecha de la noticia:', style: TextStyle(fontSize: 16)),
                    Text(formatoFecha.format(fechaActual),
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)), 
                  ],
                ),
                  
                  
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    width: double.infinity,
                    child: ElevatedButton(
                      child: Text("Agregar Noticia"),
                      onPressed: () {
                        String titulo = tituloCtrl.text.trim();
                        String contenido = contenidoCtrl.text.trim(); 
                        DateTime fecha = fechaActual;
                        FirestoreService().noticiasAgregar(titulo, contenido, fecha);
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        primary: AmarilloColor
                      ),
                    ),
                  )
                ],
              ),
            )),
      ),
    );
  }
}
