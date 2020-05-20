import 'package:flutter/material.dart';
import 'package:ui_practice/AllIngredients.dart';
import 'WelcomeScreen.dart';
import 'CustomColors.dart';
import 'package:flutter/services.dart' ;

void main() => runApp(MyApp());
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
      ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Cocktail",
      routes: {
        
        '/ingredientsPage' : (context) => AllIngredients(),
      },
      theme: ThemeData(
        accentColor: Colors.white30,
        primaryColorDark: dark,
        fontFamily: "Montserrat",
        ),
      home: WelcomeScreen(),
    );
  }
}