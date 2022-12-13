import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:colegio_cliente/provider/alumnos_provider.dart';
import 'package:colegio_cliente/provider/historial_provider.dart';
import 'package:colegio_cliente/provider/nivel_provider.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class ModificarAlumno extends StatefulWidget {
  final String rut;
  final String nombre;
  final String fechaNacimiento;
  final String foto;
  final String sexo;
  final int codigo;
  ModificarAlumno(
      {this.rut = '',
      this.nombre = '',
      this.fechaNacimiento = '',
      this.foto = '',
      this.sexo = '',
      this.codigo = 0,
      Key? key})
      : super(key: key);

  @override
  State<ModificarAlumno> createState() => _ModificarAlumnoState();
}

class _ModificarAlumnoState extends State<ModificarAlumno> {
  final primerColor = Color(0xFFFFBE86);
  final AmarilloColor = Color(0xFFFFE156);
  final rosadoColor = Color(0xFFFFB5C2);
  final incipidoColor = Color(0xFFFFE9CE);
  DateTime now = DateTime.now();
  //formulario
  final formKey = GlobalKey<FormState>();
  TextEditingController rutCtrl = TextEditingController();
  TextEditingController nombreCtrl = TextEditingController();
  String nomReg = r"/^[a-zA-Z'-]+$";
  //campo sexo
  String? sexo;
  //campo Nivel
  String nivel = '';
  //campo Fecha Nacimiento
  DateTime fechaSeleccionada = DateTime.now();
  var ffecha = DateFormat('dd-MM-yyyy');
  //campos para imagen
  File? imagen;
  final picker = ImagePicker();
  String? imagen64;
  //para errores
  String errRut = '';
  String errNombre = '';
  String errFechaNacimiento = '';
  String errSexo = '';
  @override
  void initState() {
    super.initState();
    rutCtrl.text = widget.rut;
    nombreCtrl.text = widget.nombre;
    sexo = widget.sexo;
    nivel = widget.codigo.toString();
    fechaSeleccionada = DateTime.parse(widget.fechaNacimiento);
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Modificar Alumno"),
          elevation: 0,
          backgroundColor: primerColor,
        ),
        body: Form(
          key: formKey,
          child: Padding(
            padding: EdgeInsets.all(10),
            child: ListView(
              children: [
                campoRut(),
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    errRut,
                    style: TextStyle(
                        color: Colors.red, fontWeight: FontWeight.bold),
                  ),
                ),
                campoNombre(),
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    errNombre,
                    style: TextStyle(
                        color: Colors.red, fontWeight: FontWeight.bold),
                  ),
                ),
                campoSexo(),
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    errSexo,
                    style: TextStyle(
                        color: Colors.red, fontWeight: FontWeight.bold),
                  ),
                ),
                campoNivel(),
                campoFechaNacimiento(),
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    errFechaNacimiento,
                    style: TextStyle(
                        color: Colors.red, fontWeight: FontWeight.bold),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    campoFoto(),
                    imagen == null
                        ? Container(
                            padding: EdgeInsets.all(15),
                            child: Text(
                              'Alumno sin Imagen',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                          )
                        : Container(
                            height: 150,
                            width: 150,
                            child: Image.file(imagen!),
                          )
                  ],
                ),
                campoActualizar(),
              ],
            ),
          ),
        ));
  }

  TextFormField campoRut() {
    return TextFormField(
      enabled: false,
      controller: rutCtrl,
      decoration: InputDecoration(labelText: 'Rut: '),
      validator: (valor) {
        if (valor == null || valor.isEmpty) {
          return 'Indique su Rut';
        }
        return null;
      },
    );
  }

  TextFormField campoNombre() {
    return TextFormField(
      controller: nombreCtrl,
      decoration: InputDecoration(labelText: 'Nombre:'),
      validator: (valor) {
        if (valor == null || valor.isEmpty) {
          return 'Indique su primer nombre';
        }
        if (!RegExp(nomReg).hasMatch(valor)) {
          return "Formato de nombre no Valido";
        }
        return null;
      },
    );
  }

  Row campoSexo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Radio<String>(
          groupValue: sexo,
          value: 'M',
          onChanged: (sex) {
            setState(() {
              sexo = sex!;
            });
          },
        ),
        Text('Masculino'),
        Radio<String>(
          groupValue: sexo,
          value: 'F',
          onChanged: (sex) {
            setState(() {
              sexo = sex!;
            });
          },
        ),
        Text('Femenino'),
        Radio<String>(
          groupValue: sexo,
          value: 'I',
          onChanged: (sex) {
            setState(() {
              sexo = sex!;
            });
          },
        ),
        Text('Otro'),
      ],
    );
  }

  Container campoNivel() {
    return Container(
      child: FutureBuilder(
        future: NivelProvider().getNiveles(),
        builder: (context, AsyncSnapshot snap) {
          if (!snap.hasData) {
            return DropdownButtonFormField<String>(
              hint: Text("Cargando Niveles"),
              items: [],
              onChanged: (value) {},
            );
          }
          var niveles = snap.data;
          return DropdownButtonFormField<String>(
            hint: Text('Nivel'),
            items: niveles.map<DropdownMenuItem<String>>((nivel) {
              return DropdownMenuItem<String>(
                child: Text(nivel['nombre_nivel']),
                value: nivel['cod_nivel'].toString(),
              );
            }).toList(),
            value: nivel.isEmpty ? null : nivel,
            onChanged: (nuevoNivel) {
              setState(() {
                nivel = nuevoNivel.toString();
              });
            },
          );
        },
      ),
    );
  }

  Row campoFechaNacimiento() {
    return Row(
      children: [
        Text('Fecha de Nacimiento:', style: TextStyle(fontSize: 16)),
        Text(ffecha.format(fechaSeleccionada),
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        Spacer(),
        TextButton(
          child: Icon(MdiIcons.calendar, color: primerColor),
          onPressed: () {
            showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(DateTime.now().year - 7),
              lastDate: DateTime.now(),
              locale: Locale('es', 'ES'),
            ).then((fecha) {
              setState(() {
                fechaSeleccionada = fecha ?? fechaSeleccionada;
              });
            });
          },
        ),
      ],
    );
  }

  Row campoFoto() {
    return Row(
      children: [
        ElevatedButton(
            child: Text("Seleccione una imagen"),
            onPressed: () {
              opciones(context);
            },
            style: ElevatedButton.styleFrom(
              primary: primerColor,
            )),
      ],
    );
  }

  opciones(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            contentPadding: EdgeInsets.all(0),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      selImagen(1);
                    },
                    child: Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          border: Border(
                              bottom:
                                  BorderSide(width: 1, color: Colors.grey))),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Tomar una Foto',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                          Icon(
                            Icons.camera_alt,
                            color: Colors.blue,
                          )
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      selImagen(2);
                    },
                    child: Container(
                      padding: EdgeInsets.all(20),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Seleccionar una Foto',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                          Icon(
                            Icons.image,
                            color: Colors.blue,
                          )
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(color: Colors.red),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Cancelar',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  Future selImagen(op) async {
    var pickedFile;
    if (op == 1) {
      pickedFile = await picker.pickImage(source: ImageSource.camera);
    } else {
      pickedFile = await picker.pickImage(source: ImageSource.gallery);
    }

    setState(() {
      if (pickedFile != null) {
        imagen = File(pickedFile.path);
      } else {
        print('No seleccionaste ninguna foto');
      }
    });
    Navigator.of(context).pop();
  }

  Container campoActualizar() {
    return Container(
      width: double.infinity,
      child: ElevatedButton(
          child: Text('Actualizar Alumno'),
          onPressed: () async {
            String rut = rutCtrl.text;
            String nombre = nombreCtrl.text;
            String fecha =
                "${fechaSeleccionada.year}-${fechaSeleccionada.month}-${fechaSeleccionada.day}";
            var foto = null;
            if (imagen != null) {
              foto = imagen!.path;
              List<int> bytes = await new File(foto).readAsBytesSync();
              imagen64 = base64.encode(bytes);
            }
            int cod_nivel = int.parse(nivel);

            var respuesta = await AlumnosProvider().alumnoEditar(rut.trim(),
                nombre.trim(), fecha, foto, sexo.toString(), cod_nivel);

            if (respuesta['message'] != null) {
              //rut
              if (respuesta['errors']['rut'] != null) {
                errRut = respuesta['errors']['rut'][0];
              }
              //nombre
              if (respuesta['errors']['nombre'] != null) {
                errNombre = respuesta['errors']['nombre'][0];
              }
              //fechaNacimiento
              if (respuesta['errors']['fechaNacimiento'] != null) {
                errFechaNacimiento = respuesta['errors']['fechaNacimiento'][0];
              }
              //Sexo
              if (respuesta['errors']['sexo'] != null) {
                errSexo = respuesta['errors']['sexo'][0];
              }

              setState(() {});
              return;
            }
            print("CODIGO NIVEL ANT: " + widget.codigo.toString() + "\n"
            + "CODIGO NUEVO: " + cod_nivel.toString());
            String formattedDate = DateFormat('yyyy-MM-dd').format(now);
            String formattedHours = DateFormat('kk:mm').format(now);

            if (cod_nivel != widget.codigo){
              if (cod_nivel > widget.codigo){
                var respuesta2 = await HistorialProvider()
                .historialAgregar("Alumno Asciende de nivel", "Ascenso", formattedDate, formattedHours, widget.rut);
              }else{
                var respuesta2 = await HistorialProvider()
                .historialAgregar("Alumno Desciende de nivel", "Descenso", formattedDate, formattedHours, widget.rut);
              }
            }
            
            
            Navigator.pop(context);
          },
          style: ElevatedButton.styleFrom(
            primary: primerColor,
          )),
    );
  }
}
