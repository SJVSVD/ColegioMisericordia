import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:colegio_cliente/provider/alumnos_provider.dart';
import 'package:colegio_cliente/provider/educadores_provider.dart';
import 'package:colegio_cliente/provider/nivel_provider.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class ModificarEducador extends StatefulWidget {
  final String rut;
  final String nombre;
  final String fechaNacimiento;
  final String email;
  final String telefono;
  final String sexo;
  final int codigo;
  ModificarEducador(
      {this.rut = '',
      this.nombre = '',
      this.fechaNacimiento = '',
      this.email = '',
      this.telefono = '',
      this.sexo = '',
      this.codigo = 0,
      Key? key})
      : super(key: key);

  @override
  State<ModificarEducador> createState() => _ModificarEducadorState();
}

class _ModificarEducadorState extends State<ModificarEducador> {
  final verdeClaro = Color(0xFF89DA59);
  //formulario
  final formKey = GlobalKey<FormState>();
  TextEditingController rutCtrl = TextEditingController();
  TextEditingController telefonoCtrl = TextEditingController();
  TextEditingController nombreCtrl = TextEditingController();
  TextEditingController apellido_pCtrl = TextEditingController();
  TextEditingController apellido_mCtrl = TextEditingController();
  TextEditingController emailCtrl = TextEditingController();
  String nomReg = r"/^[a-zA-Z'-]+$";
  //campo sexo
  String? sexo;
  //campo Nivel
  String nivel = '';
  //campo Fecha Nacimiento
  DateTime fechaSeleccionada = DateTime.now();
  var ffecha = DateFormat('dd-MM-yyyy');
  //campos para imagen
  //para errores
  String errRut = '';
  String errNombre = '';
  String errFechaNacimiento = '';
  String errSexo = '';
  String errEmail = '';
  String errtelefono = '';
  @override
  void initState() {
    super.initState();
    rutCtrl.text = widget.rut;
    nombreCtrl.text = widget.nombre;
    sexo = widget.sexo;
    nivel = widget.codigo.toString();
    fechaSeleccionada = DateTime.parse(widget.fechaNacimiento);
    emailCtrl.text = widget.email;
    telefonoCtrl.text = widget.telefono;
  }

  final primerColor = Color(0xFFFFBE86);
  final AmarilloColor = Color(0xFFFFE156);
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
                campoEmail(),
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    errEmail,
                    style: TextStyle(
                        color: Colors.red, fontWeight: FontWeight.bold),
                  ),
                ),
                campoTelefono(),
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    errtelefono,
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

  TextFormField campoEmail() {
    return TextFormField(
      controller: emailCtrl,
      decoration: InputDecoration(
        labelText: 'E-mail',
      ),
      validator: (valor) {
        if (valor == null || valor.isEmpty) {
          return 'Indique su email';
        }
        return null;
      },
    );
  }

  TextFormField campoTelefono() {
    return TextFormField(
      controller: telefonoCtrl,
      decoration: InputDecoration(
        labelText: 'Telefono del educador',
      ),
      validator: (valor) {
        if (valor == null || valor.isEmpty) {
          return 'Indique su telefono';
        }
        return null;
      },
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
          child: Icon(MdiIcons.calendar, color: verdeClaro),
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

  Container campoActualizar() {
    return Container(
      width: double.infinity,
      child: ElevatedButton(
          child: Text('Actualizar Educador'),
          onPressed: () async {
            String rut = rutCtrl.text;
            String nombre = nombreCtrl.text;
            String fecha =
                "${fechaSeleccionada.year}-${fechaSeleccionada.month}-${fechaSeleccionada.day}";
            int cod_nivel = int.parse(nivel);

            var respuesta = await EducadoresProvider().educadorEditar(
                rut.trim(),
                nombre.trim(),
                fecha,
                telefonoCtrl.text,
                sexo.toString(),
                emailCtrl.text,
                cod_nivel);

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
              if (respuesta['errors']['telefono'] != null) {
                errtelefono = respuesta['errors']['fechaNacimiento'][0];
              }
              if (respuesta['errors']['email'] != null) {
                errEmail = respuesta['errors']['fechaNacimiento'][0];
              }
              //Sexo
              if (respuesta['errors']['sexo'] != null) {
                errSexo = respuesta['errors']['sexo'][0];
              }

              setState(() {});
              return;
            }
            Navigator.pop(context);
          },
          style: ElevatedButton.styleFrom(
            primary: AmarilloColor,
          )),
    );
  }
}
