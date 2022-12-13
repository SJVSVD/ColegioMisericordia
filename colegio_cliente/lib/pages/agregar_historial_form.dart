import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:colegio_cliente/provider/historial_provider.dart';

class AgregarHistorialForm extends StatefulWidget {
  final String rut;
  final String nombre;
  const AgregarHistorialForm({this.rut = '', this.nombre = '', Key? key})
      : super(key: key);

  @override
  State<AgregarHistorialForm> createState() => _AgregarHistorialFormState();
}

class _AgregarHistorialFormState extends State<AgregarHistorialForm> {
  TextEditingController DescCtrl = TextEditingController();
  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(child: Text("accidente"), value: "accidente"),
      DropdownMenuItem(child: Text("agresion"), value: "agresion"),
      DropdownMenuItem(child: Text("bullying"), value: "bullying"),
      DropdownMenuItem(child: Text("retiro"), value: "retiro"),
      DropdownMenuItem(child: Text("suspension"), value: "suspension"),
      DropdownMenuItem(
          child: Text("mal comportamiento"), value: "mal comportamiento"),
      DropdownMenuItem(
          child: Text("buen comportamiento"), value: "buen comportamiento"),
      DropdownMenuItem(child: Text("sin respuestas"), value: "sin respuestas"),
    ];

    return menuItems;
  }

  String errDesc = '';
  String selectedValue = "accidente";
  DateTime now = DateTime.now();
  final primerColor = Color(0xFFFFBE86);
  final AmarilloColor = Color(0xFFFFE156);
  final rosadoColor = Color(0xFFFFB5C2);
  final incipidoColor = Color(0xFFFFE9CE);

  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primerColor,
        title: Text('Agregar Historial de ' + widget.nombre),
      ),
      body: Form(
          key: formKey,
          child: Padding(
            padding: EdgeInsets.all(5),
            child: ListView(
              children: [
                TextFormField(
                  controller: DescCtrl,
                  decoration: InputDecoration(
                    labelText: 'Descripcion',
                  ),
                  validator: (valor) {
                    if (valor == null || valor.isEmpty) {
                      return 'Indique La Descripcion';
                    }
                    return null;
                  },
                ),
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    errDesc,
                    style: TextStyle(
                        color: Colors.red, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 50),
                Container(
                  child: Text(
                    'tipo evento',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                DropdownButton(
                    style: TextStyle(color: Colors.black, fontSize: 20),
                    value: selectedValue,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedValue = newValue!;
                      });
                    },
                    items: dropdownItems),
                Container(
                    child: ElevatedButton(
                       style: ElevatedButton.styleFrom(primary: AmarilloColor),
                        child: Text('Agregar Historial'),
                        onPressed: () async {
                    String Desc = DescCtrl.text.trim();
                    String formattedDate = DateFormat('yyyy-MM-dd').format(now);
                    String formattedHours = DateFormat('kk:mm').format(now);
                    var respuesta = await HistorialProvider().historialAgregar(
                        Desc,
                        selectedValue,
                        formattedDate,
                        formattedHours,
                        widget.rut);
                    if (respuesta['message'] != null) {
                      //rut
                      if (respuesta['errors']['descripcion'] != null) {
                        errDesc = respuesta['errors']['descripcion'][0];
                      }
                      setState(() {});
                      return;
                    }
                    Navigator.pop(context);
                  },
                )),
              ],
            ),
          )),
    );
  }
}
