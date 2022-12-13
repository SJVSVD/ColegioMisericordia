import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:colegio_cliente/pages/agregar_historial_form.dart';
import 'package:colegio_cliente/pages/modificar_alumno.dart';
import 'package:colegio_cliente/pages/modificar_historial.dart';
import 'dart:convert';
import 'package:colegio_cliente/provider/alumnos_provider.dart';
import 'package:colegio_cliente/provider/historial_provider.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class Ver_Alumnos extends StatefulWidget {
  final int codigo;
  final String rut;
  final String nivel;
  const Ver_Alumnos({this.codigo = 0, this.rut = '', this.nivel = '', Key? key})
      : super(key: key);

  @override
  State<Ver_Alumnos> createState() => _Ver_AlumnosState();
}

String nombre = '';

class _Ver_AlumnosState extends State<Ver_Alumnos> {
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
        title: Text("Informacion del alumno"),
      ),
      body: FutureBuilder(
        future: AlumnosProvider().getAlumno(widget.rut),
        builder: (context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          var alumno = snapshot.data;
          var sexo;
          if (alumno['sexo'] == 'M') {
            sexo = "Masculino";
          } else if (alumno['sexo'] == 'F') {
            sexo = "Femenino";
          } else {
            sexo = "Indeterminado";
          }

          var imagen;

          if (alumno['foto'] != null) {
            imagen = Container(
              child: Image.file(
                File(alumno['foto'].toString()),
                width: 150,
                height: 150,
              ),
            );
          } else {
            imagen = Container(child: Text("Alumno sin Imagen"));
          }

          return Column(
            children: [
              Container(
                padding: EdgeInsets.all(10),
                child: Text(
                  alumno['nombre'],
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Row(
                children: [
                  Container(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Container(
                        alignment: Alignment.center,
                        height: 150,
                        width: 150,
                        decoration: BoxDecoration(
                          border: Border.all(width: 2, color: Colors.black),
                          color: Colors.grey,
                        ),
                        child: imagen,
                      ),
                    ),
                  ),
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
                            "Rut: " + alumno['rut'],
                            style: TextStyle(fontSize: 18, fontFamily: 'Arial'),
                          ),
                          Text(
                            "Fecha Nac: " + alumno['fechaNacimiento'],
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
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                width: 500,
                margin: EdgeInsets.all(2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                     ElevatedButton(
                        
                        child: Text('Modificar Datos'),
                        onPressed: () {
                          MaterialPageRoute route = new MaterialPageRoute(
                              builder: (context) => ModificarAlumno(
                                    codigo: widget.codigo,
                                    rut: alumno['rut'],
                                    sexo: alumno['sexo'],
                                    nombre: alumno['nombre'],
                                    foto: alumno['foto'].toString(),
                                    fechaNacimiento: alumno['fechaNacimiento'],
                                  ));
                          Navigator.push(context, route).then((value) {
                            setState(() {});
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.yellow,
                        )),
                    ElevatedButton(
                      child: Text(
                        'Eliminar Alumno',
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(primary: Colors.red),
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                  title: Text('Eliminar Alumno'),
                                  content: Text(
                                      '¿Esta seguro de Eliminar este Alumno?'),
                                  actions: [
                                    TextButton.icon(
                                      icon: Icon(MdiIcons.check),
                                      label: Text("OK"),
                                      onPressed: () {
                                        AlumnosProvider()
                                            .alumnoBorrar(widget.rut)
                                            .then((borrado) {
                                          if (borrado) {
                                            showDialog(
                                                context: context,
                                                builder: (context) =>
                                                    AlertDialog(
                                                      title:
                                                          Text("Informacion"),
                                                      content: Text(
                                                          "Alumno Eliminado!"),
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
                                                          "Alumno no se pudo Eliminar!"),
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
                      child: Text(
                        'Agregar Historial',
                        style: TextStyle(color: Colors.black),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AgregarHistorialForm(
                                    rut: widget.rut.toString(),
                                    nombre: alumno['nombre'],
                                  )),
                        ).then((value) {
                          setState(() {});
                        });
                      },
                    ),
                   
                    
                  ],
                ),
              ),
             
              //ListView.builder
              Expanded(
                child: FutureBuilder(
                  future: HistorialProvider().getXRut(alumno['rut']),
                  builder: (context, AsyncSnapshot snapRut) {
                    if (!snapRut.hasData) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return ListView.separated(
                        separatorBuilder: (_, __) => Divider(),
                        shrinkWrap: true,
                        itemCount: snapRut.data.length,
                        itemBuilder: (context, index) {
                          var historial = snapRut.data[index];
                          return Slidable(
                            child: ListTile(
                              title: Text(
                                historial['fecha'].toString(),
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                              trailing: Text(
                                historial['tipo_evento'].toString(),
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                              subtitle: Text(
                                historial['hora'].toString(),
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text("Detalle del historial"),
                                      content: Text(
                                        historial['descripcion'].toString(),
                                      ),
                                      actions: [
                                        TextButton(
                                          child: new Text("OK"),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                            ),
                            startActionPane: ActionPane(
                              motion: ScrollMotion(),
                              children: [
                                SlidableAction(
                                  onPressed: (context) {
                                    if (historial['tipo_evento'] ==
                                            "Descenso" ||
                                        historial['tipo_evento'] == "Ascenso") {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title:
                                                Text("Detalle del historial"),
                                            content: Text(
                                              'No se puede modificar esto tipo de dato ' +
                                                  historial['tipo_evento']
                                                      .toString(),
                                            ),
                                            actions: [
                                              TextButton(
                                                child: new Text("OK"),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                      return null;
                                    }
                                    MaterialPageRoute route =
                                        new MaterialPageRoute(
                                            builder: (context) =>
                                                Modificar_Historial(
                                                  Codigo: historial[
                                                      'cod_historial'],
                                                  Desc: historial['descripcion']
                                                      .toString(),
                                                  nombre: alumno['nombre'],
                                                  Tipo_des:
                                                      historial['tipo_evento']
                                                          .toString(),
                                                ));
                                    Navigator.push(context, route)
                                        .then((value) {
                                      setState(() {});
                                    });
                                    ;
                                  },
                                  backgroundColor:
                                      Color.fromARGB(255, 155, 255, 255),
                                  icon: MdiIcons.pen,
                                  label: 'Editar',
                                ),
                              ],
                            ),
                            endActionPane: ActionPane(
                              motion: ScrollMotion(),
                              children: [
                                SlidableAction(
                                  onPressed: (context) {
                                    showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                              title: Text('Eliminar Historial'),
                                              content: Text(
                                                  '¿Esta seguro de Eliminar este registro?'),
                                              actions: [
                                                TextButton.icon(
                                                  icon: Icon(MdiIcons.check),
                                                  label: Text("OK"),
                                                  onPressed: () {
                                                    HistorialProvider()
                                                        .historialBorrar(
                                                            historial[
                                                                'cod_historial'])
                                                        .then((borrado) {
                                                      if (borrado) {
                                                        showDialog(
                                                            context: context,
                                                            builder:
                                                                (context) =>
                                                                    AlertDialog(
                                                                      title: Text(
                                                                          "Informacion"),
                                                                      content: Text(
                                                                          "registro Eliminado!"),
                                                                      actions: [
                                                                        TextButton
                                                                            .icon(
                                                                          icon:
                                                                              Icon(MdiIcons.check),
                                                                          label:
                                                                              Text('OK'),
                                                                          onPressed:
                                                                              () {
                                                                            Navigator.pop(context);
                                                                          },
                                                                        )
                                                                      ],
                                                                    ));
                                                      } else {
                                                        showDialog(
                                                            context: context,
                                                            builder:
                                                                (context) =>
                                                                    AlertDialog(
                                                                      title: Text(
                                                                          "Informacion"),
                                                                      content: Text(
                                                                          "registro no se pudo Eliminar!"),
                                                                      actions: [
                                                                        TextButton
                                                                            .icon(
                                                                          icon:
                                                                              Icon(MdiIcons.check),
                                                                          label:
                                                                              Text('OK'),
                                                                          onPressed:
                                                                              () {
                                                                            Navigator.pop(context);
                                                                          },
                                                                        )
                                                                      ],
                                                                    ));
                                                      }
                                                    });
                                                    Navigator.of(context)
                                                        .pop('OK');
                                                    setState(() {});
                                                  },
                                                ),
                                                TextButton.icon(
                                                  icon: Icon(MdiIcons.close),
                                                  label: Text("Cancelar"),
                                                  onPressed: () {
                                                    Navigator.of(context)
                                                        .pop('Cancelar');
                                                  },
                                                ),
                                              ],
                                            )).then((value) => print(value));
                                  },
                                  backgroundColor:
                                      Color.fromARGB(255, 95, 14, 14),
                                  icon: MdiIcons.trashCan,
                                  label: 'Borrar',
                                ),
                              ],
                            ),
                          );
                        });
                  },
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
