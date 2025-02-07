import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'intro_page.dart';
import 'choix_inscrption.dart';
import 'login_page.dart';
import 'dashboard_page.dart';
import 'form_page.dart';
import 'moduleVente/save_vente_forme.dart';
import 'registration_list_page.dart';
import 'welcome_page.dart';
import 'commune_page.dart';
import 'utils/theme_provider.dart';
import 'networkListener/network_provider.dart';
import 'networkListener/network_listener.dart';
import 'utils/app_theme.dart'; // Import the new theme utility


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //await Firebase.initializeApp();  // Décommenter pour IOS
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyA7Z0e_B8rzN1xfljvI5qtC6lBnL27iO_E",
      appId: "1:718726928056:android:7c9d74f4653dc0d797464d",
      messagingSenderId: "Messaging sender id here",
      projectId: "recensement-de-population",
    ),
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => NetworkProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          title: 'Flutter Firebase Auth',
          theme: AppTheme.getLightTheme(context),
          darkTheme: AppTheme.getDarkTheme(context),
          themeMode: themeProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
          home: NetworkListener(child: LoginPage()),
          routes: {
            '/welcome': (context) => NetworkListener(child: WelcomePage()),
            '/login': (context) => NetworkListener(child: LoginPage()),
            '/dashboard': (context) => NetworkListener(child: DashboardPage()),
            '/form': (context) => NetworkListener(child: FormPage()),
            '/saveVente': (context) => NetworkListener(child: SaveVenteForm()),
            '/liste': (context) => NetworkListener(child: RegistrationList()),
            '/choixinscription': (context) => NetworkListener(child: ChoixInscriptionPage()),
          },
        );
      },
    );
  }
}