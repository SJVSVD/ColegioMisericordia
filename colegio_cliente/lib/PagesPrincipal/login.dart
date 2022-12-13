import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:colegio_cliente/pages/principal_page.dart';
import 'package:colegio_cliente/provider/GoogleService.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IniciarSesion extends StatefulWidget {
  const IniciarSesion({Key? key}) : super(key: key);

  @override
  State<IniciarSesion> createState() => _IniciarSesionState();
}

class _IniciarSesionState extends State<IniciarSesion> {
  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

  @override
  Widget build(BuildContext context) {
    GoogleSignInAccount? user = _googleSignIn.currentUser;
    return Scaffold(
      appBar: AppBar(title: Text('Hola Usuario')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                padding: EdgeInsets.all(10),
                width: double.infinity,
                height: 100,
                child: SignInButton(
                  Buttons.Google,
                  text: "Iniciar por Google",
                  onPressed: () async {
                    if (await GoogleServicio().signInWithGoogle() != null) {
                      MaterialPageRoute route = new MaterialPageRoute(
                          builder: (context) => PrincipalPage());
                      Navigator.pushReplacement(context, route);
                    } else {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("ERROR"),
                            content: Text('Error en iniciar sesion'),
                            actions: [
                              TextButton(
                                child: new Text("OK"),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    }
                    ;
                  },
                )),
          ],
        ),
      ),
    );
  }
}
