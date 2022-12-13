import 'package:flutter/material.dart';
import 'package:colegio_cliente/pages/Ver_Educador.dart';
import 'package:colegio_cliente/pages/agregar_alumno_form.dart';
import 'package:colegio_cliente/pages/ver_alumno.dart';
import 'package:colegio_cliente/provider/alumnos_provider.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../provider/educadores_provider.dart';
import 'agregar_educador_form.dart';

class ListadoEducadores extends StatefulWidget {
  final String nivel;
  final int codigo;
  ListadoEducadores({this.nivel = '', this.codigo = 0, Key? key})
      : super(key: key);

  @override
  State<ListadoEducadores> createState() => _ListadoEducadoresState();
}

class _ListadoEducadoresState extends State<ListadoEducadores> {
  final primerColor = Color(0xFFFFBE86);
  final AmarilloColor = Color(0xFFFFE156);
  final rosadoColor = Color(0xFFFFB5C2);
  final incipidoColor = Color(0xFFFFE9CE);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(5),
        child: Expanded(
          child: FutureBuilder(
            future: EducadoresProvider().getEducadoresXNivel(widget.codigo),
            builder: (context, AsyncSnapshot snap) {
              if (!snap.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return ListView.separated(
                physics: const BouncingScrollPhysics(),
                separatorBuilder: (_, __) => Divider(),
                itemCount: snap.data.length,
                itemBuilder: (context, index) {
                  var educador = snap.data[index];
                  return ListTile(
                    title: Text(educador['nombre'].toString()),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Ver_Educador(
                                  codigo: widget.codigo,
                                  rut: educador['rut'].toString(),
                                  nivel: widget.nivel,
                                )),
                      ).then((value) {
                        setState(() {});
                      });
                    },
                  );
                },
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => FormAgregarEducadorPage(
                      codigo: widget.codigo,
                      nivel: widget.nivel.toString(),
                    )),
          ).then((value) {
            setState(() {});
          });
        },
        child: Icon(Icons.add),
        backgroundColor: AmarilloColor,
      ),
    );
  }
}
