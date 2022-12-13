import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:colegio_cliente/provider/historial_provider.dart';

class Modificar_Historial extends StatefulWidget {
  final String nombre;
  final int Codigo;
  final String Desc;
  final String Tipo_des;
  const Modificar_Historial(
      {this.nombre = '',
      this.Codigo = 0,
      this.Desc = '',
      this.Tipo_des = '',
      Key? key})
      : super(key: key);

  @override
  State<Modificar_Historial> createState() => _Modificar_HistorialState();
}

class _Modificar_HistorialState extends State<Modificar_Historial> {
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
      DropdownMenuItem(child: Text("Descenso"), value: "Descenso"),
      DropdownMenuItem(child: Text("Ascenso"), value: "Ascenso"),
    ];

    return menuItems;
  }

  String errDesc = '';
  String selectedValue = "accidente";
  DateTime now = DateTime.now();

  final formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    DescCtrl.text = widget.Desc;
    selectedValue = widget.Tipo_des.toString();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Modificar esta historia de' + widget.nombre),
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
                      if ("Descenso" == widget.Tipo_des.toString() ||
                          "Ascenso" == widget.Tipo_des.toString() ||
                          newValue == "Ascenso" ||
                          newValue == "Descenso") {
                        return null;
                      }
                      // lo dejamos asi por un tema de que si llegarse la casualidad de que el usuario
                      // llegara a poder cambiar este historial no puede cambiarlo de su valor que no sea lo que esta en el if
                      setState(() {
                        selectedValue = newValue!;
                      });
                    },
                    items: dropdownItems),
                Container(
                    child: ElevatedButton(
                  child: Text('Modificar  Historial'),
                  onPressed: () async {
                    String Desc = DescCtrl.text.trim();
                    String formattedDate = DateFormat('yyyy-MM-dd').format(now);
                    String formattedHours = DateFormat('kk:mm').format(now);
                    var respuesta = await HistorialProvider().historialEditar(
                        widget.Codigo,
                        Desc,
                        selectedValue,
                        formattedDate,
                        formattedHours);
                    if (respuesta['message'] != null) {
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
