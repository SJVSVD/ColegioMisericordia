import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:colegio_cliente/provider/alumnos_provider.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'dart:io';

class FormAgregarAlumnosPage extends StatefulWidget {
  final int codigo;
  final String nivel;

  FormAgregarAlumnosPage({this.codigo = 0, this.nivel = '', Key? key})
      : super(key: key);

  @override
  State<FormAgregarAlumnosPage> createState() => _FormAgregarAlumnosPageState();
}

class _FormAgregarAlumnosPageState extends State<FormAgregarAlumnosPage> {
  //Formulario
  final formKey = GlobalKey<FormState>();
  TextEditingController rutCtrl = TextEditingController();
  TextEditingController nombreCtrl = TextEditingController();
  TextEditingController sNombreCtrl = TextEditingController();
  TextEditingController apellido_pCtrl = TextEditingController();
  TextEditingController apellido_mCtrl = TextEditingController();

  String nombre = '';
  String? genero = 'M';
  DateTime fechaSeleccionada = DateTime.now();
  var ffecha = DateFormat('dd-MM-yyyy');
  String nomReg = r"/^[a-zA-Z'-]+$";
  //campos para imagen
  File? imagen;
  final picker = ImagePicker();
  String? imagen64;
  //Captura de Errores
  String errRut = '';
  String errNombre = '';
  String errFechaNacimiento = '';
  String errSexo = '';
  //colores para el sistema
  final primerColor = Color(0xFFFFBE86);
  final AmarilloColor = Color(0xFFFFE156);
  final rosadoColor = Color(0xFFFFB5C2);
  final incipidoColor = Color(0xFFFFE9CE);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primerColor,
        title: Text('Agregar Alumno a ' + widget.nivel),
      ),
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: ListView(
            children: [
              campoRut(),
              Container(
                alignment: Alignment.center,
                child: Text(
                  errRut,
                  style:
                      TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                ),
              ),
              campoPrimerNombre(),
              Container(
                alignment: Alignment.center,
                child: Text(
                  errNombre,
                  style:
                      TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                ),
              ),
              campoSegundoNombre(),
              campoPrimerApellido(),
              campoSegundoApellido(),
              campoSexo(),
              Container(
                alignment: Alignment.center,
                child: Text(
                  errSexo,
                  style:
                      TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                ),
              ),
              campoFechaNacimiento(),
              Container(
                alignment: Alignment.center,
                child: Text(
                  errFechaNacimiento,
                  style:
                      TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                ),
              ),
              campoFoto(),
              botonMatricular(),
            ],
          ),
        ),
      ),
    );
  }

  TextFormField campoRut() {
    return TextFormField(
      controller: rutCtrl,
      decoration: InputDecoration(
        labelText: 'Rut del alumno. sin punto y sin guion',
      ),
      validator: (valor) {
        if (valor == null || valor.isEmpty) {
          return 'Indique su Rut';
        }
        return null;
      },
    );
  }

  TextFormField campoPrimerNombre() {
    return TextFormField(
      controller: nombreCtrl,
      decoration: InputDecoration(
        labelText: 'Primer Nombre',
      ),
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

  TextFormField campoSegundoNombre() {
    return TextFormField(
      controller: sNombreCtrl,
      decoration: InputDecoration(
        labelText: 'Segundo Nombre',
      ),
      validator: (valor) {
        if (valor == null || valor.isEmpty) {
          return 'Indique su segundo nombre';
        }
        if (!RegExp(nomReg).hasMatch(valor)) {
          return "Formato de nombre no Valido";
        }
        return null;
      },
    );
  }

  TextFormField campoPrimerApellido() {
    return TextFormField(
      controller: apellido_pCtrl,
      decoration: InputDecoration(
        labelText: 'Primer Apellido',
      ),
      validator: (valor) {
        if (valor == null || valor.isEmpty) {
          return 'Indique su primer apellido';
        }
        if (!RegExp(nomReg).hasMatch(valor)) {
          return "Formato de apellido no Valido";
        }
        return null;
      },
    );
  }

  TextFormField campoSegundoApellido() {
    return TextFormField(
      controller: apellido_mCtrl,
      decoration: InputDecoration(
        labelText: 'Segundo Apellido',
      ),
      validator: (valor) {
        if (valor == null || valor.isEmpty) {
          return 'Indique su segundo apellido';
        }
        if (!RegExp(nomReg).hasMatch(valor)) {
          return "Formato de apellido no Valido";
        }
        return null;
      },
    );
  }

  Container campoSexo() {
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                children: [
                  Radio(
                      value: 'M',
                      groupValue: genero,
                      onChanged: (value) {
                        setState(() {
                          genero = value.toString();
                        });
                      }),
                  Text('Masculino')
                ],
              ),
              Row(
                children: [
                  Radio(
                      value: 'F',
                      groupValue: genero,
                      onChanged: (value) {
                        setState(() {
                          genero = value.toString();
                        });
                      }),
                  Text('Femenino')
                ],
              ),
              Row(
                children: [
                  Radio(
                      value: 'I',
                      groupValue: genero,
                      onChanged: (value) {
                        setState(() {
                          genero = value.toString();
                        });
                      }),
                  Text('Otro')
                ],
              ),
            ],
          ),
        ],
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
        imagen == null
            ? Center()
            : Container(
                height: 150,
                width: 150,
                child: Image.file(imagen!),
              )
      ],
    );
  }

  Container botonMatricular() {
    return Container(
      width: double.infinity,
      child: ElevatedButton(
          child: Text('Matricular'),
          onPressed: () async {
            String rut = rutCtrl.text;
            String nombre = nombreCtrl.text +
                " " +
                sNombreCtrl.text +
                " " +
                apellido_pCtrl.text +
                " " +
                apellido_mCtrl.text;
            String fecha =
                "${fechaSeleccionada.year}-${fechaSeleccionada.month}-${fechaSeleccionada.day}";
            var foto = null;
            if (imagen != null) {
              foto = imagen!.path;
              List<int> bytes = await new File(foto).readAsBytesSync();
              imagen64 = base64.encode(bytes);
            }
            String sexo = genero.toString();
            int cod_nivel = widget.codigo;

            if (!validarRut(rut.trim())) {
              errRut = 'Formato de Rut Invalido';
              setState(() {});
              return;
            }

            var respuesta = await AlumnosProvider().alumnoAgregar(
                rut.trim(), nombre.trim(), fecha, foto, sexo, cod_nivel);

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
            Navigator.pop(context);
          },
          style: ElevatedButton.styleFrom(
            primary: primerColor,
          )),
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

  bool validarRut(String rut) {
    bool verificacion = false;
    if (rut.length == 9) {
      String number = rut.substring(0, 8);
      String dv = rut[8];

      int suma = 0;
      var j = 3;

      for (int i = 0; i < number.length; i++) {
        if (j == 1) {
          j = 7;
        }
        suma = suma + (j * int.parse(number[i]));
        j--;
      }
      int resto = suma % 11;
      int dig = 11 - resto;
      String ddv;
      if (dig < 10 && dig > 0) {
        ddv = dig.toString();
      } else {
        if (dig == 10) {
          ddv = 'K';
        } else {
          ddv = '0';
        }
      }

      if (dv.toUpperCase() == ddv.toUpperCase()) {
        verificacion = true;
      } else {
        verificacion = false;
      }
    }

    return verificacion;
  }
}
