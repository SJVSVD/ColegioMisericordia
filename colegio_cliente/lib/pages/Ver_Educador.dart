import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:colegio_cliente/pages/Modificar_Educador.dart';
import 'dart:convert';
import 'package:colegio_cliente/provider/educadores_provider.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class Ver_Educador extends StatefulWidget {
  final int codigo;
  final String rut;
  final String nivel;
  const Ver_Educador(
      {this.codigo = 0, this.rut = '', this.nivel = '', Key? key})
      : super(key: key);

  @override
  State<Ver_Educador> createState() => _Ver_EducadorState();
}

String nombre = '';

class _Ver_EducadorState extends State<Ver_Educador> {
  final verdeClaro = Color(0xFF89DA59);
  @override
  void initState() {
    super.initState();
  }

  final primerColor = Color(0xFFFFBE86);
  final AmarilloColor = Color(0xFFFFE156);
  final rosadoColor = Color(0xFFFFB5C2);
  final incipidoColor = Color(0xFFFFE9CE);
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primerColor,
        title: Text("Informacion del Educador"),
      ),
      body: FutureBuilder(
        future: EducadoresProvider().getEducador(widget.rut),
        builder: (context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          var Educador = snapshot.data;
          var sexo;
          if (Educador['sexo'] == 'M') {
            sexo = "Masculino";
          } else if (Educador['sexo'] == 'F') {
            sexo = "Femenino";
          } else {
            sexo = "Indeterminado";
          }

          return Column(
            children: [
              Container(
                padding: EdgeInsets.all(10),
                child: Text(
                  Educador['nombre'],
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Row(
                children: [
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "Rut: " + Educador['rut'],
                            style: TextStyle(fontSize: 18, fontFamily: 'Arial'),
                          ),
                          Text(
                            "Fecha Nac: " + Educador['fechaNacimiento'],
                            style: TextStyle(fontSize: 18, fontFamily: 'Arial'),
                          ),
                          Text(
                            "Sexo: " + sexo,
                            style: TextStyle(fontSize: 18, fontFamily: 'Arial'),
                          ),
                          Text(
                            "Nivel: " + widget.nivel,
                            style: TextStyle(fontSize: 18, fontFamily: 'Arial'),
                          ),
                          Text(
                            "Telefono: " + Educador['telefono'],
                            style: TextStyle(fontSize: 18, fontFamily: 'Arial'),
                          ),
                          Text(
                            "Email: " + Educador['email'],
                            style: TextStyle(fontSize: 18, fontFamily: 'Arial'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      child: Text(
                        'Eliminar Educador',
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(primary: Colors.red),
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                  title: Text('Eliminar Educador'),
                                  content: Text(
                                      '¿Esta seguro de Eliminar este Educador?'),
                                  actions: [
                                    TextButton.icon(
                                      icon: Icon(MdiIcons.check),
                                      label: Text("OK"),
                                      onPressed: () {
                                        EducadoresProvider()
                                            .educadorBorrar(widget.rut)
                                            .then((borrado) {
                                          if (borrado) {
                                            showDialog(
                                                context: context,
                                                builder: (context) =>
                                                    AlertDialog(
                                                      title:
                                                          Text("Informacion"),
                                                      content: Text(
                                                          "Educador Eliminado!"),
                                                      actions: [
                                                        TextButton.icon(
                                                          icon: Icon(
                                                              MdiIcons.check),
                                                          label: Text('OK'),
                                                          onPressed: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                        )
                                                      ],
                                                    ));
                                          } else {
                                            showDialog(
                                                context: context,
                                                builder: (context) =>
                                                    AlertDialog(
                                                      title:
                                                          Text("Informacion"),
                                                      content: Text(
                                                          "Educador no se pudo Eliminar!"),
                                                      actions: [
                                                        TextButton.icon(
                                                          icon: Icon(
                                                              MdiIcons.check),
                                                          label: Text('OK'),
                                                          onPressed: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                        )
                                                      ],
                                                    ));
                                          }
                                        });
                                        Navigator.of(context).pop('OK');
                                        Navigator.pop(context);
                                      },
                                    ),
                                    TextButton.icon(
                                      icon: Icon(MdiIcons.close),
                                      label: Text("Cancelar"),
                                      onPressed: () {
                                        Navigator.of(context).pop('Cancelar');
                                      },
                                    ),
                                  ],
                                )).then((value) => print(value));
                        setState(() {});
                      },
                    ),
                    ElevatedButton(
                        child: Text('Modificar Datos'),
                        onPressed: () {
                          MaterialPageRoute route = new MaterialPageRoute(
                              builder: (context) => ModificarEducador(
                                    codigo: widget.codigo,
                                    rut: Educador['rut'],
                                    sexo: Educador['sexo'],
                                    nombre: Educador['nombre'],
                                    telefono: Educador['telefono'],
                                    email: Educador['telefono'].toString(),
                                    fechaNacimiento:
                                        Educador['fechaNacimiento'],
                                  ));
                          Navigator.push(context, route).then((value) {
                            setState(() {});
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.yellow,
                        )),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
