import 'package:flutter/material.dart';
class CardNoticias extends StatelessWidget {
  final String titulo;
  final String contenido;
  final String fecha;
  

  const CardNoticias(
      {this.titulo = '',
      this.contenido = '',
      this.fecha = '',
      
      Key? key})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final primerColor = Color(0xFFFFBE86);
    final AmarilloColor = Color(0xFFFFE156);
    final rosadoColor = Color(0xFFFFB5C2);
    final incipidoColor = Color(0xFFFFE9CE);
    return Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          margin: EdgeInsets.all(15),
          elevation: 10,
          color:  Color(0xFFFFE9CE),
          // Dentro de esta propiedad usamos ClipRRect
          child: ClipRRect(
            // Los bordes del contenido del card se cortan usando BorderRadius
            borderRadius: BorderRadius.circular(15),
            // EL widget hijo que será recortado segun la propiedad anterior
            child: Column(
              children: <Widget>[
                // Usamos Container para el contenedor de la descripción
                Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  decoration: new BoxDecoration(color:AmarilloColor),
                  padding: EdgeInsets.all(5),
                  child: Text(titulo,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20)),
                ),
                Container(
                  decoration: new BoxDecoration(color: incipidoColor),
                  padding: EdgeInsets.all(10),
                  child: Text(contenido,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15)),
                ),
                Container(
                  decoration: new BoxDecoration(color: incipidoColor),
                  padding: EdgeInsets.all(5),
                  child: Text(fecha,style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                ),
              ],
            ),
          )
    );
  }
}
