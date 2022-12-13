
import 'package:flutter/material.dart';
import 'package:colegio_cliente/PagesPrincipal/gestor_noticias.dart';
import 'package:colegio_cliente/pages/gestion_niveles.dart';

import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';



class Configuracion extends StatefulWidget {

  @override
  State<Configuracion> createState() => _ConfiguracionState();
  
}


class _ConfiguracionState extends State<Configuracion> {
  int _currentIndex = 0;
  final primerColor = Color(0xFFFFBE86);
  final AmarilloColor = Color(0xFFFFE156);
  final rosadoColor = Color(0xFFFFB5C2);
  final incipidoColor = Color(0xFFFFE9CE);
 
  List paginas = [];

  @override
    void initState() {
    super.initState();
    paginas = [
    {"pagina":GestionNiveles(), 'texto': 'Gestion Niveles', 'icono': MdiIcons.humanChild, 'color':0xFFFFBE86},
    {'pagina':gestor_noticias(), 'texto': 'Gestion Noticias', 'icono': MdiIcons.newspaper, 'color':0xFFFFBE86},
    ];
    
  }
  
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: paginas[_currentIndex]['pagina'] as Widget,
      bottomNavigationBar: BottomNavigationBar(
        
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.shifting,
        items: paginas.map((p) {
          return BottomNavigationBarItem(
            label: p['texto'],
            icon: Icon(p['icono']),
            backgroundColor: Color(p['color']),
          );
        }).toList(),
       
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
