import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'intro_page.dart';
import 'choix_inscrption.dart';
import 'login_page.dart';
import 'dashboard_page.dart';
import 'form_page.dart';
import 'registration_list_page.dart';
import 'welcome_page.dart';
import 'commune_page.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  /*await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyA7Z0e_B8rzN1xfljvI5qtC6lBnL27iO_E",
      appId: "1:718726928056:android:7c9d74f4653dc0d797464d",
      //appId: "1:718726928056:ios:bc000d775a28c66497464d",
      messagingSenderId: "Messaging sender id here",
      projectId: "recensement-de-population",
    ),
  );*/
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Firebase Auth',
      theme: ThemeData.light(), // Thème clair par défaut
      //darkTheme: ThemeData.dark(), // Thème sombre
      themeMode: ThemeMode.system, // Utiliser le mode système par défaut
      home: IntroPage(),
      //home: CommunePage(),
      routes: {
        '/welcome': (context) => WelcomePage(),
        '/login': (context) => LoginPage(),
        '/dashboard': (context) => DashboardPage(),
        '/form': (context) => FormPage(),
        '/liste': (context) => RegistrationList(),
        '/choixinscription': (context) => ChoixInscriptionPage(),
      },
    );
  }
}
