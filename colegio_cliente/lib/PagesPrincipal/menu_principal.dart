import 'package:flutter/material.dart';
import 'package:colegio_cliente/PagesPrincipal/login.dart';
import 'package:colegio_cliente/pages/principal_page.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'listado_noticias.dart';

class MenuPrincipal extends StatefulWidget {
  MenuPrincipal({Key? key}) : super(key: key);

  @override
  State<MenuPrincipal> createState() => _MenuPrincipalState();
}

class _MenuPrincipalState extends State<MenuPrincipal> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('                      Menu'),
        leading: Icon(MdiIcons.tree),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          
      Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.only(bottom: 20),
        height: 100,
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => IniciarSesion()),
            ).then((value) {
              setState(() {});
            });
          },
          child: Text('Gestor Colegio'),
        ),
      ),

      
      
        Container(
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.only(top: 20),
          height: 100,
          width: double.infinity,
          child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Listado_noticias()),
            ).then((value) {
              setState(() {});
            });
          },
          child: Text('Noticias'),
      ),
        ),

         
        ],
      ),
    );
  }
}
