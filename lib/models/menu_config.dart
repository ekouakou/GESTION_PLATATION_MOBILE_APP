// lib/config/menu_config.dart
import 'menu_item.dart';
import 'package:flutter/material.dart';


const MENU_ITEMS = [
  {
    "id": "dashboard",
    "title": "Dashboard",
    "icon": Icons.dashboard, // Icons.dashboard
    "route": "/dashboard"
  },
  {
    "id": "liste_inscrit",
    "title": "Liste inscrit",
    "icon": Icons.list, // Icons.list
    "route": "/liste"
  },
  {
    "id": "ventes",
    "title": "Ventes",
    "icon": Icons.book, // Icons.book
    "children": [
      {
        "id": "save_vente",
        "title": "Enregistrer une vente",
        "icon": Icons.home,
        "route": "/saveVente"
      },
      {
        "id": "liste_vente",
        "title": "Liste des ventes",
        "icon": Icons.home,
        "route": "/listevente"
      }
    ]
  },
  {
    "id": "membres",
    "title": "Membres",
    "icon": Icons.home,
    "children": [
      {
        "id": "save_membre",
        "title": "Enregistrer un membre",
        "icon": Icons.home,
        "route": "/saveMembre"
      },
      {
        "id": "save_cotisation",
        "title": "Enregistrer une cotisation",
        "icon": Icons.home,
        "route": "/saveCotisation"
      },
      {
        "id": "liste_membre",
        "title": "Liste des membres",
        "icon": Icons.home,
        "route": "/listeMembre"
      }
    ]
  },
  {
    "id": "theme_toggle",
    "title": "Thème",
    "icon": Icons.brightness_6 // Icons.brightness_6
  },
  {
    "id": "logout",
    "title": "Déconnexion",
    "icon": Icons.logout // Icons.logout
  }
];

Future<List<MenuItem>> loadMenuItems() async {
  // Simuler un chargement asynchrone
  return Future.value(
    MENU_ITEMS.map((item) => MenuItem.fromJson(item)).toList(),
  );
}