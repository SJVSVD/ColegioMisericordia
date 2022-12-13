import 'package:flutter/material.dart';
import 'package:colegio_cliente/provider/nivel_provider.dart';

class AgregarNivel extends StatefulWidget {
  AgregarNivel({Key? key}) : super(key: key);

  @override
  State<AgregarNivel> createState() => _AgregarNivelState();
}

class _AgregarNivelState extends State<AgregarNivel> {
  //colores del sistema
  final primerColor = Color(0xFFFFBE86);
  final AmarilloColor = Color(0xFFFFE156);
  final rosadoColor = Color(0xFFFFB5C2);
  final incipidoColor = Color(0xFFFFE9CE);
  //formulario
  final formKey = GlobalKey<FormState>();
  String? foto = null;
  TextEditingController nombreCtrl = new TextEditingController();
  String errNombre = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Agregar Nivel"),
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
                    controller: nombreCtrl,
                    decoration: InputDecoration(
                      labelText: 'Nombre del Nivel',
                    ),
                    validator: (valor) {
                      if (valor == null || valor.isEmpty) {
                        return 'Indique el Nombre';
                      }
                      return null;
                    },
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      errNombre,
                      style:
                          TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    width: double.infinity,
                    child: ElevatedButton(
                      child: Text("Agregar Nivel"),
                      onPressed: () async {
                        var respuesta = await NivelProvider()
                            .nivelAgregar(nombreCtrl.text.trim(), foto);

                        if (respuesta['message'] != null) {
                          if (respuesta['errors']['nombre_nivel'] != null) {
                            errNombre = respuesta['errors']['nombre_nivel'][0];
                          }
                          setState(() {});
                          return;
                        }
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
