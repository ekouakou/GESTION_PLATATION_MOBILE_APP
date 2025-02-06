import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

Future<void> importData() async {
  // Instance de Firestore
  final firestore = FirebaseFirestore.instance;

  // Vos données à importer
  final data = [
    {"STR_COMMUNE": "Abobo", "STR_REGION": "ABIDJAN", "STR_DISTRICT": "ABIDJAN"},
    {"STR_COMMUNE": "Adjamé", "STR_REGION": "ABIDJAN", "STR_DISTRICT": "ABIDJAN"},
    {"STR_COMMUNE": "Attecoubé", "STR_REGION": "ABIDJAN", "STR_DISTRICT": "ABIDJAN"},
    {"STR_COMMUNE": "Plateau", "STR_REGION": "ABIDJAN", "STR_DISTRICT": "ABIDJAN"},
    {"STR_COMMUNE": "Treichville", "STR_REGION": "ABIDJAN", "STR_DISTRICT": "ABIDJAN"},
    {"STR_COMMUNE": "Marcory", "STR_REGION": "ABIDJAN", "STR_DISTRICT": "ABIDJAN"},
    {"STR_COMMUNE": "Koumassi", "STR_REGION": "ABIDJAN", "STR_DISTRICT": "ABIDJAN"},
    {"STR_COMMUNE": "Port-Bouet", "STR_REGION": "ABIDJAN", "STR_DISTRICT": "ABIDJAN"},
    {"STR_COMMUNE": "Cocody", "STR_REGION": "ABIDJAN", "STR_DISTRICT": "ABIDJAN"},
    {"STR_COMMUNE": "Yopougon", "STR_REGION": "ABIDJAN", "STR_DISTRICT": "ABIDJAN"},
    {"STR_COMMUNE": "Anyama", "STR_REGION": "ABIDJAN", "STR_DISTRICT": "ABIDJAN"},
    {"STR_COMMUNE": "Bingerville", "STR_REGION": "ABIDJAN", "STR_DISTRICT": "ABIDJAN"},
    {"STR_COMMUNE": "Songon", "STR_REGION": "ABIDJAN", "STR_DISTRICT": "ABIDJAN"},
  ];

  // Référence à la collection 'communes'
  final collectionRef = firestore.collection('communes');

  // Importer les données
  for (var item in data) {
    try {
      await collectionRef.add(item);
      print('Donnée importée: $item');
    } catch (e) {
      print('Erreur lors de l\'importation de $item: $e');
    }
  }

  print('Importation terminée!');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await importData();
}
