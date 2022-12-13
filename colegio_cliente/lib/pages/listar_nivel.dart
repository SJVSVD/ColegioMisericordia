
import 'package:flutter/material.dart';
import 'package:colegio_cliente/pages/listado_educadores.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'listado_alumnos.dart';

class ListarNivel extends StatefulWidget {
  final int codigo;
  final String nivel;
  
  ListarNivel({
    this.codigo = 0,
    this.nivel = '',
    Key? key}) : super(key: key);

  @override
  State<ListarNivel> createState() => _ListarNivelState();
  
}


class _ListarNivelState extends State<ListarNivel> {
  int _currentIndex = 0;
  final primerColor = Color(0xFFFFBE86);
  final AmarilloColor = Color(0xFFFFE156);
  final rosadoColor = Color(0xFFFFB5C2);
  final incipidoColor = Color(0xFFFFE9CE);
  int codigo=0;
  String nivel='';
 
  List paginas = [];

  @override
    void initState() {
    super.initState();
    paginas = [
    {"pagina":ListadoAlumnos(codigo: widget.codigo, nivel: widget.nivel,), 'texto': 'Alumnos', 'icono': MdiIcons.humanChild, 'color':0xFFFFBE86},
    {'pagina':ListadoEducadores(codigo: widget.codigo, nivel: widget.nivel,), 'texto': 'Educadores', 'icono': MdiIcons.human, 'color':0xFFFFBE86},
    ];
    
  }
  
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('nivel: ' + widget.nivel),
        backgroundColor:primerColor,
      ),
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