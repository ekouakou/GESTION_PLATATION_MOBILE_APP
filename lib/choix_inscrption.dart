import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Importer Firebase Auth
import 'dashboard_page.dart'; // Importer la page du tableau de bord
import 'login_page.dart'; // Importer la page LoginScreen.dart

class ChoixInscriptionPage extends StatelessWidget {

  final FirebaseAuth _auth = FirebaseAuth.instance;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF007D3C), Color(0xFF005F2E)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 0.0, bottom: 5.0, left: 16.0, right: 16.0),
              child: Image.asset('assets/images/logo.png', height: 50),
            ),
            SizedBox(height: 10),
            const Text(
              'Bienvenue!',
              style: TextStyle(
                fontSize: 70,
                fontFamily: 'Rosellinda',
                color: Color(0xFFe4fb7c),
              ),
            ),
            SizedBox(height: 10),
            const Text(
              'Votre application de recensement des nouveaux ',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                color: Colors.white,
              ),
            ),
            const Text(
              'électeurs non inscrits sur la liste électorale.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 15),
            Container(
              padding: EdgeInsets.only(top: 5.0, bottom: 12.0, left: 50.0, right: 50.0),
              width: double.infinity,
              child: Image.asset(
                'assets/images/img-1.png',
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 20),
            Image.asset('assets/images/personne-question.png', height: 50),
            const Text(
              'Êtes-vous un agent recenseur ?',
              style: TextStyle(
                fontSize: 12,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacementNamed('/form');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFCC9B21),
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 60, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Text('Non'),
                ),
                SizedBox(width: 20),
                ElevatedButton(

                  /*onPressed: () {
                    Navigator.of(context).pushReplacementNamed('/login');
                  },*/
                  onPressed: () async {
                    User? user = _auth.currentUser;
                    if (user != null) {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => DashboardPage(),
                        ),
                      );
                    } else {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => LoginPage(),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFe4fb7c),
                    foregroundColor: Colors.black,
                    padding: EdgeInsets.symmetric(horizontal: 60, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Text('Oui'),
                ),
              ],
            ),
            Spacer(),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Développé par ',
                    style: TextStyle(color: Colors.white),
                  ),
                  Image.asset('assets/images/logo.png', height: 20),
                ],
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: Color(0xFF007D3C),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pushReplacementNamed('/welcome');
          },
        ),
        /*title: Text(
          'Connexion',
          style: TextStyle(color: Colors.white),
        ),*/
      ),
    );
  }
}
