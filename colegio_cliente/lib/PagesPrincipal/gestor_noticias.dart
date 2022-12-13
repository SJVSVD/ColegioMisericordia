import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:colegio_cliente/pages/agregar_noticia.dart';
import 'package:colegio_cliente/pages/modificar_noticia.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import '../provider/noticias_provider.dart';

class gestor_noticias extends StatefulWidget {
  gestor_noticias({Key? key}) : super(key: key);

  @override
  State<gestor_noticias> createState() => _gestor_noticiasState();
}

class _gestor_noticiasState extends State<gestor_noticias> {
  final primerColor = Color(0xFFFFBE86);
  final AmarilloColor = Color(0xFFFFE156);
  final rosadoColor = Color(0xFFFFB5C2);
  final incipidoColor = Color(0xFFFFE9CE);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primerColor,
        title: Text('Noticias'),
        
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: FirestoreService().noticias(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData ||
                    snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return ListView.separated(
                  separatorBuilder: (context, index) => Divider(),
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    var noticias = snapshot.data!.docs[index];
                    DateTime fecha = noticias['fecha'].toDate();
                    
                    print(fecha);
                    return ListTile(
                      leading: Icon(MdiIcons.newspaper),
                      title: Text('${noticias['titulo']}'),
                      subtitle: Text(
                          'contenido: ${noticias['contenido']}\nfecha:${fecha}'),
                          onTap: () {
                        MaterialPageRoute route = new MaterialPageRoute(
                            builder: (contex) => ModificarNoticia(id:noticias.id, titulo:noticias['titulo'], contenido:noticias['contenido']));
                        Navigator.push(context, route)
                            .then((value) => setState(() {}));
                      },
                      trailing: ElevatedButton(
                        
                        child: Text(
                          'Eliminar',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                    title: Text('Eliminar Noticia'),
                                    content: Text(
                                        '¿Esta seguro de Eliminar este Noticia?'),
                                    actions: [
                                      TextButton.icon(
                                        icon: Icon(MdiIcons.check),
                                        label: Text("OK"),
                                        onPressed: () {
                                          FirestoreService().noticiasBorrar(noticias.id)
                                              .then((borrado) {
                                            if (borrado) {
                                              showDialog(
                                                  context: context,
                                                  builder: (context) =>
                                                      AlertDialog(
                                                        title:
                                                            Text("Informacion"),
                                                        content: Text(
                                                            "Noticia Eliminado!"),
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
                                                            "Noticia no se pudo Eliminar!"),
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
                                          setState(() {});
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
                        },
                        style: ElevatedButton.styleFrom(primary: Colors.red),
                      )
                    );
                  },
                );
              },
            ),
          ),
          
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(MdiIcons.newspaperPlus),
        backgroundColor: AmarilloColor,
        onPressed: () {
          MaterialPageRoute route =
              new MaterialPageRoute(builder: ((context) => AgregarNoticia()));
          Navigator.push(context, route).then((value) {
            setState(() {});
          });
        },
      ),
    );
  }
}
