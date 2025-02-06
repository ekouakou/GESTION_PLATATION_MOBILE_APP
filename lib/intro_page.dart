import 'package:flutter/material.dart';
import 'dart:async';

class IntroPage extends StatefulWidget {
  @override
  _IntroPageState createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  @override
  void initState() {
    super.initState();
    // Rediriger vers la page de bienvenue après 3 secondes
    Timer(Duration(seconds: 3), () {
      Navigator.of(context).pushReplacementNamed('/welcome');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF007D3C), Color(0xFF005F2E)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Logo
              Image.asset(
                'assets/images/logo.png', // Assurez-vous que l'image est dans le répertoire assets
                width: 64, // Ajustez la largeur selon vos besoins
                height: 64, // Ajustez la hauteur selon vos besoins
              ),
              SizedBox(height: 20), // Espacement entre le logo et la barre de progression horizontale
              // Barre de progression horizontale
              Container(
                width: 200, // Largeur de la barre de progression
                child: LinearProgressIndicator(
                  backgroundColor: Colors.white.withOpacity(0.3),
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              ),
              SizedBox(height: 20), // Espacement entre la barre de progression et le texte
              /*Text(
                'Introduction',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),*/
            ],
          ),
        ),
      ),
    );
  }
}
