import 'package:flutter/material.dart';
import 'package:formvalidation/src/blocs/provider.dart';
import 'package:formvalidation/src/pages/home_page.dart';
import 'package:formvalidation/src/pages/login_page.dart';
import 'package:formvalidation/src/pages/producto_page.dart';
import 'package:formvalidation/src/pages/signup_page.dart';
import 'package:formvalidation/src/preferens/preferens_user.dart';
 
void main() async { 

  final prefs = new PreferenciasUsuario();
  await prefs.initPrefs();
  
  runApp(MyApp());
}
 
class MyApp extends StatelessWidget {
  Color _color = Colors.deepPurple;
  @override
  Widget build(BuildContext context) {
    final prefs = new PreferenciasUsuario();
    //print(prefs.token);
    return Provider(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        initialRoute: 'login',
        routes: {
          'login': (BuildContext context) => LoginPage(),
          'home': (BuildContext context) => HomePage(),
          'producto': (BuildContext context) => ProductoPage(),
          'registro': (BuildContext context) => SignUpPage(),
        },
        theme: ThemeData(
          primaryColor: _color,
          floatingActionButtonTheme: FloatingActionButtonThemeData(
            backgroundColor: _color
          ),
        ),
      ),
    );
  }
}