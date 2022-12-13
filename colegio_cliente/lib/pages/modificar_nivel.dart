import 'package:flutter/material.dart';

import '../provider/nivel_provider.dart';

class ModificarNivel extends StatefulWidget {
  final String nombre;
  final int codigo;

  ModificarNivel({this.nombre = '', this.codigo = 0, Key? key})
      : super(key: key);

  @override
  State<ModificarNivel> createState() => _ModificarNivelState();
}

class _ModificarNivelState extends State<ModificarNivel> {
  final formKey = GlobalKey<FormState>();
  TextEditingController nombreCtrl = new TextEditingController();
  String? foto = null;
  String errNombre = '';
  //Colores del Sistema
  final primerColor = Color(0xFFFFBE86);
  final AmarilloColor = Color(0xFFFFE156);
  final rosadoColor = Color(0xFFFFB5C2);
  final incipidoColor = Color(0xFFFFE9CE);
  @override
  void initState() {
    super.initState();
    nombreCtrl.text = widget.nombre;
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Modificar Nivel'),
          backgroundColor: primerColor,
        ),
        body: Form(
          key: formKey,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(15),
                child: TextFormField(
                  controller: nombreCtrl,
                  decoration: InputDecoration(labelText: 'Nivel:'),
                  validator: (valor) {
                    if (valor == null || valor.isEmpty) {
                      return 'Indique el Nombre del Nivel';
                    }
                    return null;
                  },
                ),
              ),
              Container(
                alignment: Alignment.center,
                child: Text(
                  errNombre,
                  style: TextStyle(
                    color: Colors.red, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(15),
                child: Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(top: 20),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: AmarilloColor,),
                    child: Text("Modificar Nivel"),
                    onPressed: () async {
                      var respuesta = await NivelProvider().nivelsEditar(
                          widget.codigo, nombreCtrl.text.trim(), foto);

                      if (respuesta['message'] != null) {
                        if (respuesta['errors']['nombre_nivel'] != null) {
                          errNombre = respuesta['errors']['nombre_nivel'][0];
                        }
                        setState(() {});
                        return;
                      }
                      Navigator.pop(context);
                    },
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
