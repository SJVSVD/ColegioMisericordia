import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:colegio_cliente/PagesPrincipal/Login.dart';
import 'package:colegio_cliente/PagesPrincipal/gestor_noticias.dart';

import 'package:colegio_cliente/pages/agregar_educador_form.dart';
import 'package:colegio_cliente/pages/principal_page.dart';

import 'PagesPrincipal/menu_principal.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      supportedLocales: [
        const Locale('es', 'ES'),
      ],
      locale: Locale('es'),
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.yellow,
      ),
      home:MenuPrincipal(),
    );
  }
}
