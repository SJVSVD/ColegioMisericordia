import 'package:flutter/material.dart';
import 'package:colegio_cliente/pages/agregar_nivel.dart';
import 'package:colegio_cliente/pages/modificar_nivel.dart';
import 'package:colegio_cliente/provider/alumnos_provider.dart';
import 'package:colegio_cliente/provider/nivel_provider.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class GestionNiveles extends StatefulWidget {
  GestionNiveles({Key? key}) : super(key: key);

  @override
  State<GestionNiveles> createState() => _GestionNivelesState();
}

class _GestionNivelesState extends State<GestionNiveles> {
  final primerColor = Color(0xFFFFBE86);
  final AmarilloColor = Color(0xFFFFE156);
  final rosadoColor = Color(0xFFFFB5C2);
  final incipidoColor = Color(0xFFFFE9CE);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Gestion de Cursos"),
        backgroundColor: primerColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Expanded(
            child: FutureBuilder(
          future: NivelProvider().getNiveles(),
          builder: (context, AsyncSnapshot snap) {
            if (!snap.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView.separated(
                separatorBuilder: ((context, index) => Divider()),
                itemCount: snap.data.length,
                itemBuilder: (context, index) {
                  var nvl = snap.data[index];
                  return ListTile(
                      title: Text(nvl['nombre_nivel'].toString()),
                      leading: Text(nvl['cod_nivel'].toString()),
                      onTap: () {
                        MaterialPageRoute route = new MaterialPageRoute(
                            builder: (contex) => ModificarNivel(
                                  codigo: nvl['cod_nivel'],
                                  nombre: nvl['nombre_nivel'].toString(),
                                ));
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
                                    title: Text('Eliminar Nivel'),
                                    content: Text(
                                        '¿Esta seguro de Eliminar este Nivel?'),
                                    actions: [
                                      TextButton.icon(
                                        icon: Icon(MdiIcons.check),
                                        label: Text("Si"),
                                        onPressed: () async {
                                          var cant = await AlumnosProvider()
                                              .getCantidadXNivel(
                                                  (nvl['cod_nivel']));

                                          if (cant != 0) {
                                            Navigator.pop(context);
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  title: Text("ERROR"),
                                                  content: Text(
                                                      'No se puede eliminar por que hay alumnos'),
                                                  actions: [
                                                    TextButton(
                                                      child: new Text("OK"),
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                    ),
                                                  ],
                                                );
                                              },
                                            );

                                            return null;
                                          }
                                          NivelProvider()
                                              .nivelBorrar(nvl['cod_nivel'])
                                              .then((borrado) {
                                            if (borrado) {
                                              snap.data.removeAt(index);
                                              showDialog(
                                                  context: context,
                                                  builder: (context) =>
                                                      AlertDialog(
                                                        title:
                                                            Text("Informacion"),
                                                        content: Text(
                                                            "Nivel Eliminado!"),
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
                                                            "Nivel no se pudo Eliminar!"),
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
                      ));
                });
          },
        )),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: AmarilloColor,
        onPressed: () {
          MaterialPageRoute route =
              new MaterialPageRoute(builder: ((context) => AgregarNivel()));
          Navigator.push(context, route).then((value) {
            setState(() {});
          });
        },
      ),
    );
  }
}
