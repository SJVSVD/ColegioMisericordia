import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:colegio_cliente/provider/alumnos_provider.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'dart:io';
import 'package:colegio_cliente/provider/nivel_provider.dart';

import '../provider/educadores_provider.dart';

class FormAgregarEducadorPage extends StatefulWidget {
  final int codigo;
  final String nivel;

  FormAgregarEducadorPage({this.codigo = 0, this.nivel = '', Key? key})
      : super(key: key);

  @override
  State<FormAgregarEducadorPage> createState() =>
      _FormAgregarEducadorPageState();
}

class _FormAgregarEducadorPageState extends State<FormAgregarEducadorPage> {
  //Formulario
  final formKey = GlobalKey<FormState>();
  TextEditingController rutCtrl = TextEditingController();
  TextEditingController telefonoCtrl = TextEditingController();
  TextEditingController nombreCtrl = TextEditingController();
  TextEditingController sNombreCtrl = TextEditingController();
  TextEditingController apellido_pCtrl = TextEditingController();
  TextEditingController apellido_mCtrl = TextEditingController();
  TextEditingController emailCtrl = TextEditingController();

  String nivel = '';
  String nombre = '';
  String? genero = 'M';
  DateTime fechaSeleccionada = DateTime.now();
  var ffecha = DateFormat('dd-MM-yyyy');
  String nomReg = r"/^[a-zA-Z'-]+$";
  String email = '';
  String telefono = '1';
  //Captura de Errores
  String errTelefono='';
  String errRut = '';
  String errNombre = '';
  String errFechaNacimiento = '';
  String errSexo = '';
  String errEmail = '';
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
        title: Text('Agregar Educador '),
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
              campoTelefono(),
              Container(
                alignment: Alignment.center,
                child: Text(
                  errTelefono,
                  style:
                      TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                ),
              ),
              campoEmail(),
              Container(
                alignment: Alignment.center,
                child: Text(
                  errEmail,
                  style:
                      TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                ),
              ),
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
              botonAgregarEducador(),
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
        labelText: 'Rut del educador',
      ),
      validator: (valor) {
        if (valor == null || valor.isEmpty) {
          return 'Indique su Rut';
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

  Container botonAgregarEducador() {
    return Container(
      width: double.infinity,
      child: ElevatedButton(
          child: Text('Agregar'),
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
            if (!validarRut(rut.trim())){
              errRut = 'Rut invalido';
              setState(() {
                
              });
              return ;
            }
            var respuesta = await EducadoresProvider().educadorAgregar(
                rut.trim(),
                nombre.trim(),
                fecha,
                telefonoCtrl.text.trim(),
                emailCtrl.text.trim(),
                genero.toString(),
                widget.codigo);

            if (respuesta['message'] != null) {
              //rut
              if (respuesta['errors']['rut'] != null) {
                errRut = respuesta['errors']['rut'][0];
              }
              //telefono
              if (respuesta['errors']['telefono'] != null) {
                errTelefono = respuesta['errors']['telefono'][0];
              }
              //nombre
              if (respuesta['errors']['nombre'] != null) {
                errNombre = respuesta['errors']['nombre'][0];
              }
              //email
              if (respuesta['errors']['email'] != null) {
                errEmail = respuesta['errors']['email'][0];
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
  bool validarRut(String rut) {
    if(rut.length == 8){
      rut = '0'+ rut;
    }
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
