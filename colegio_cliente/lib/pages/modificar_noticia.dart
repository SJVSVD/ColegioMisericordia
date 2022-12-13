import 'package:flutter/material.dart';
import 'package:colegio_cliente/provider/noticias_provider.dart';



class ModificarNoticia extends StatefulWidget {
  final String id;
  final String titulo;
  final String contenido;
  ModificarNoticia({ this.id = '',this.titulo = '',this.contenido='', Key? key})
      : super(key: key);
  

  @override
  State<ModificarNoticia> createState() => _ModificarNoticiaState();
}

class _ModificarNoticiaState extends State<ModificarNoticia> {
  final formKey = GlobalKey<FormState>();
  TextEditingController nombreCtrl = new TextEditingController();
  String? foto = null;
  String errNombre = '';
  //Colores del Sistema
  final primerColor = Color(0xFFFFBE86);
  final AmarilloColor = Color(0xFFFFE156);
  final rosadoColor = Color(0xFFFFB5C2);
  final incipidoColor = Color(0xFFFFE9CE);
  TextEditingController tituloCtrl = new TextEditingController();
  TextEditingController contenidoCtrl = new TextEditingController();
  @override
  void initState() {
    super.initState();
      tituloCtrl.text = widget.titulo;
      contenidoCtrl.text = widget.contenido;
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Modificar Noticia'),
          backgroundColor: primerColor,
        ),
        body: Form(
          key: formKey,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(15),
                child: TextFormField(
                  controller: tituloCtrl,
                  decoration: InputDecoration(labelText: 'Titulo:'),
                  validator: (valor) {
                    if (valor == null || valor.isEmpty) {
                      return 'Indique el Titulo de la Noticia';
                    }
                    return null;
                  },
                ),
                
              ),
              Padding(
                padding: EdgeInsets.all(15),
                child: TextFormField(
                  maxLines: 5,
                  controller: contenidoCtrl,
                  decoration: InputDecoration(labelText: 'Contenido:'),
                  validator: (valor) {
                    if (valor == null || valor.isEmpty) {
                      return 'Indique el contenido de la Noticia';
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
                    child: Text("Modificar Noticia"),
                    onPressed: () async {
                      FirestoreService().noticiasEditar( widget.id, tituloCtrl.text, contenidoCtrl.text);
                      
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
