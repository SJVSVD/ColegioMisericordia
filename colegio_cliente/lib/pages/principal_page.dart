import 'package:flutter/material.dart';
import 'package:colegio_cliente/PagesPrincipal/login.dart';
import 'package:colegio_cliente/pages/configuraciones.dart';
import 'package:colegio_cliente/pages/gestion_niveles.dart';
import 'package:colegio_cliente/pages/listado_alumnos.dart';
import 'package:colegio_cliente/pages/listar_nivel.dart';
import 'package:colegio_cliente/provider/GoogleService.dart';
import 'package:colegio_cliente/provider/nivel_provider.dart';
import 'package:colegio_cliente/widgets/card.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class PrincipalPage extends StatefulWidget {
  PrincipalPage({Key? key}) : super(key: key);

  @override
  State<PrincipalPage> createState() => _PrincipalPageState();
}

class _PrincipalPageState extends State<PrincipalPage> {
  final primerColor = Color(0xFFFFBE86);
  final AmarilloColor = Color(0xFFFFE156);
  final rosadoColor = Color(0xFFFFB5C2);
  final incipidoColor = Color(0xFFFFE9CE);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AmarilloColor,
      appBar: AppBar(
        title: Text('Colegio Misericordia'),
        leading: IconButton(
          icon: Icon(MdiIcons.cog),
          onPressed: () {
            MaterialPageRoute route =
                new MaterialPageRoute(builder: (context) => Configuracion());
            Navigator.push(context, route).then((value) {
              setState(() {});
            });
          },
        ),
        actions: [
          PopupMenuButton(
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'logout',
                child: Text('Cerrar Sesion'),
              ),
            ],
            onSelected: (opcion) async {
              if (opcion == 'logout') {
                GoogleServicio().SingOut();
                MaterialPageRoute route = MaterialPageRoute(
                  builder: (context) => IniciarSesion(),
                );
                Navigator.pushReplacement(context, route);
              }
            },
          ),
        ],
        backgroundColor: primerColor,
      ),
      body: Padding(
        padding: EdgeInsets.all(5),
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
                physics: const BouncingScrollPhysics(),
                separatorBuilder: (_, __) => Divider(),
                itemCount: snap.data.length,
                itemBuilder: (context, index) {
                  var nvl = snap.data[index];
                  return ElevatedButton(
                      child: CardWidgets(texto: nvl['nombre_nivel'].toString()),
                      onPressed: () {
                        MaterialPageRoute route = new MaterialPageRoute(
                            builder: (context) => ListarNivel(
                                  nivel: nvl['nombre_nivel'],
                                  codigo: nvl['cod_nivel'],
                                ));
                        Navigator.push(context, route);
                        setState(() {});
                      },
                      style: ElevatedButton.styleFrom(
                        primary: AmarilloColor,
                      ));
                  /*return Container(
                    child: CardWidgets(texto: nvl['nombre_nivel'].toString())
                  );*/
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
