import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CommunePage extends StatelessWidget {
  // Méthode pour importer les données
  Future<void> importData() async {
    final firestore = FirebaseFirestore.instance;
    final data =   [
      {
        "STR_COMMUNE": "Abengourou",
        "STR_DEPARTEMENT": "",
        "STR_DISTRICT": "COMOE",
        "STR_REGION": "INDENIE-DJUABLIN",
        "STR_SOUSPREFECTURE": ""
      },
      {
        "STR_COMMUNE": "Abobo",
        "STR_DEPARTEMENT": "",
        "STR_DISTRICT": "ABIDJAN",
        "STR_REGION": "ABIDJAN",
        "STR_SOUSPREFECTURE": ""
      },
      {
        "STR_COMMUNE": "Aboisso",
        "STR_DEPARTEMENT": "",
        "STR_DISTRICT": "COMOE",
        "STR_REGION": "SUD-COMOE",
        "STR_SOUSPREFECTURE": ""
      },
      {
        "STR_COMMUNE": "Adiake",
        "STR_DEPARTEMENT": "",
        "STR_DISTRICT": "COMOE",
        "STR_REGION": "SUD-COMOE",
        "STR_SOUSPREFECTURE": ""
      },
      {
        "STR_COMMUNE": "Adjamé",
        "STR_DEPARTEMENT": "",
        "STR_DISTRICT": "ABIDJAN",
        "STR_REGION": "ABIDJAN",
        "STR_SOUSPREFECTURE": ""
      },
      {
        "STR_COMMUNE": "Adzopé",
        "STR_DEPARTEMENT": "",
        "STR_DISTRICT": "LAGUNES",
        "STR_REGION": "LA ME",
        "STR_SOUSPREFECTURE": ""
      },
      {
        "STR_COMMUNE": "Affery",
        "STR_DEPARTEMENT": "",
        "STR_DISTRICT": "LAGUNES",
        "STR_REGION": "LA ME",
        "STR_SOUSPREFECTURE": ""
      },
      {
        "STR_COMMUNE": "Agboville",
        "STR_DEPARTEMENT": "",
        "STR_DISTRICT": "LAGUNES",
        "STR_REGION": "AGNEBY TIASSA",
        "STR_SOUSPREFECTURE": ""
      },
      {
        "STR_COMMUNE": "Agnibilekrou",
        "STR_DEPARTEMENT": "",
        "STR_DISTRICT": "COMOE",
        "STR_REGION": "INDENIE-DJUABLIN",
        "STR_SOUSPREFECTURE": ""
      },
      {
        "STR_COMMUNE": "Agou",
        "STR_DEPARTEMENT": "",
        "STR_DISTRICT": "LAGUNES",
        "STR_REGION": "LA ME",
        "STR_SOUSPREFECTURE": ""
      },
      {
        "STR_COMMUNE": "Akoupé",
        "STR_DEPARTEMENT": "",
        "STR_DISTRICT": "LAGUNES",
        "STR_REGION": "LA ME",
        "STR_SOUSPREFECTURE": ""
      },
      {
        "STR_COMMUNE": "Alépé",
        "STR_DEPARTEMENT": "",
        "STR_DISTRICT": "LAGUNES",
        "STR_REGION": "LA ME",
        "STR_SOUSPREFECTURE": ""
      },
      {
        "STR_COMMUNE": "Anoumaba",
        "STR_DEPARTEMENT": "",
        "STR_DISTRICT": "LACS",
        "STR_REGION": "N'ZI",
        "STR_SOUSPREFECTURE": ""
      },
      {
        "STR_COMMUNE": "Anyama",
        "STR_DEPARTEMENT": "",
        "STR_DISTRICT": "ABIDJAN",
        "STR_REGION": "ABIDJAN",
        "STR_SOUSPREFECTURE": ""
      },
      {
        "STR_COMMUNE": "Arrah",
        "STR_DEPARTEMENT": "",
        "STR_DISTRICT": "LACS",
        "STR_REGION": "N'ZI",
        "STR_SOUSPREFECTURE": ""
      },
      {
        "STR_COMMUNE": "Assinie-mafia",
        "STR_DEPARTEMENT": "",
        "STR_DISTRICT": "COMOE",
        "STR_REGION": "SUD-COMOE",
        "STR_SOUSPREFECTURE": ""
      },
      {
        "STR_COMMUNE": "Assuéfry",
        "STR_DEPARTEMENT": "",
        "STR_DISTRICT": "ZANZAN",
        "STR_REGION": "GONTOUGO",
        "STR_SOUSPREFECTURE": ""
      },
      {
        "STR_COMMUNE": "Attecoubé",
        "STR_DEPARTEMENT": "",
        "STR_DISTRICT": "ABIDJAN",
        "STR_REGION": "ABIDJAN",
        "STR_SOUSPREFECTURE": ""
      },
      {
        "STR_COMMUNE": "Attiegouakro",
        "STR_DEPARTEMENT": "",
        "STR_DISTRICT": "YAMOUSSOUKRO",
        "STR_REGION": "YAMOUSSOUKRO",
        "STR_SOUSPREFECTURE": ""
      },
      {
        "STR_COMMUNE": "Ayame",
        "STR_DEPARTEMENT": "",
        "STR_DISTRICT": "COMOE",
        "STR_REGION": "SUD-COMOE",
        "STR_SOUSPREFECTURE": ""
      },
      {
        "STR_COMMUNE": "Azaguié",
        "STR_DEPARTEMENT": "",
        "STR_DISTRICT": "LAGUNES",
        "STR_REGION": "AGNEBY TIASSA",
        "STR_SOUSPREFECTURE": ""
      },
      {
        "STR_COMMUNE": "Bako",
        "STR_DEPARTEMENT": "",
        "STR_DISTRICT": "DENGUELE",
        "STR_REGION": "KABADOUGOU",
        "STR_SOUSPREFECTURE": ""
      },
      {
        "STR_COMMUNE": "Bangolo",
        "STR_DEPARTEMENT": "",
        "STR_DISTRICT": "MONTAGNES",
        "STR_REGION": "GUEMON",
        "STR_SOUSPREFECTURE": ""
      },
      {
        "STR_COMMUNE": "Bassawa",
        "STR_DEPARTEMENT": "",
        "STR_DISTRICT": "VALLEE DU BANDAMA",
        "STR_REGION": "HAMBOL",
        "STR_SOUSPREFECTURE": ""
      },
      {
        "STR_COMMUNE": "Bediala",
        "STR_DEPARTEMENT": "",
        "STR_DISTRICT": "SASSANDRA-MARAHOUE",
        "STR_REGION": "HAUT-SASSANDRA",
        "STR_SOUSPREFECTURE": ""
      },
      {
        "STR_COMMUNE": "Beoumi",
        "STR_DEPARTEMENT": "",
        "STR_DISTRICT": "VALLEE DU BANDAMA",
        "STR_REGION": "GBEKE",
        "STR_SOUSPREFECTURE": ""
      },
      {
        "STR_COMMUNE": "Bettie",
        "STR_DEPARTEMENT": "",
        "STR_DISTRICT": "COMOE",
        "STR_REGION": "INDENIE-DJUABLIN",
        "STR_SOUSPREFECTURE": ""
      },
      {
        "STR_COMMUNE": "Biankouma",
        "STR_DEPARTEMENT": "",
        "STR_DISTRICT": "MONTAGNES",
        "STR_REGION": "TONKPI",
        "STR_SOUSPREFECTURE": ""
      },
      {
        "STR_COMMUNE": "Bin-Houyé",
        "STR_DEPARTEMENT": "",
        "STR_DISTRICT": "MONTAGNES",
        "STR_REGION": "TONKPI",
        "STR_SOUSPREFECTURE": ""
      },
      {
        "STR_COMMUNE": "Bingerville",
        "STR_DEPARTEMENT": "",
        "STR_DISTRICT": "ABIDJAN",
        "STR_REGION": "ABIDJAN",
        "STR_SOUSPREFECTURE": ""
      },
      {
        "STR_COMMUNE": "Bloléquin",
        "STR_DEPARTEMENT": "",
        "STR_DISTRICT": "MONTAGNES",
        "STR_REGION": "CAVALY",
        "STR_SOUSPREFECTURE": ""
      },
      {
        "STR_COMMUNE": "Bocanda",
        "STR_DEPARTEMENT": "",
        "STR_DISTRICT": "LACS",
        "STR_REGION": "N'ZI",
        "STR_SOUSPREFECTURE": ""
      },
      {
        "STR_COMMUNE": "Bodokro",
        "STR_DEPARTEMENT": "",
        "STR_DISTRICT": "VALLEE DU BANDAMA",
        "STR_REGION": "GBEKE",
        "STR_SOUSPREFECTURE": ""
      },
      {
        "STR_COMMUNE": "Bondoukou",
        "STR_DEPARTEMENT": "",
        "STR_DISTRICT": "ZANZAN",
        "STR_REGION": "GONTOUGO",
        "STR_SOUSPREFECTURE": ""
      },
      {
        "STR_COMMUNE": "Bongouanou",
        "STR_DEPARTEMENT": "",
        "STR_DISTRICT": "LACS",
        "STR_REGION": "N'ZI",
        "STR_SOUSPREFECTURE": ""
      },
      {
        "STR_COMMUNE": "Bonieredougou",
        "STR_DEPARTEMENT": "",
        "STR_DISTRICT": "VALLEE DU BANDAMA",
        "STR_REGION": "HAMBOL",
        "STR_SOUSPREFECTURE": ""
      },
      {
        "STR_COMMUNE": "Bonon",
        "STR_DEPARTEMENT": "",
        "STR_DISTRICT": "SASSANDRA-MARAHOUE",
        "STR_REGION": "MARAHOUE",
        "STR_SOUSPREFECTURE": ""
      },
      {
        "STR_COMMUNE": "Bonoua",
        "STR_DEPARTEMENT": "",
        "STR_DISTRICT": "COMOE",
        "STR_REGION": "SUD-COMOE",
        "STR_SOUSPREFECTURE": ""
      },
      {
        "STR_COMMUNE": "Booko",
        "STR_DEPARTEMENT": "",
        "STR_DISTRICT": "WOROBA",
        "STR_REGION": "BAFFING",
        "STR_SOUSPREFECTURE": ""
      },
      {
        "STR_COMMUNE": "Borotou",
        "STR_DEPARTEMENT": "",
        "STR_DISTRICT": "WOROBA",
        "STR_REGION": "BAFFING",
        "STR_SOUSPREFECTURE": ""
      },
      {
        "STR_COMMUNE": "Botro",
        "STR_DEPARTEMENT": "",
        "STR_DISTRICT": "VALLEE DU BANDAMA",
        "STR_REGION": "GBEKE",
        "STR_SOUSPREFECTURE": ""
      },
      {
        "STR_COMMUNE": "Bouafle",
        "STR_DEPARTEMENT": "",
        "STR_DISTRICT": "SASSANDRA-MARAHOUE",
        "STR_REGION": "MARAHOUE",
        "STR_SOUSPREFECTURE": ""
      },
      {
        "STR_COMMUNE": "Bouake",
        "STR_DEPARTEMENT": "",
        "STR_DISTRICT": "VALLEE DU BANDAMA",
        "STR_REGION": "GBEKE",
        "STR_SOUSPREFECTURE": ""
      },
      {
        "STR_COMMUNE": "Bouna",
        "STR_DEPARTEMENT": "",
        "STR_DISTRICT": "ZANZAN",
        "STR_REGION": "BOUNKANI",
        "STR_SOUSPREFECTURE": ""
      },
      {
        "STR_COMMUNE": "Boundiali",
        "STR_DEPARTEMENT": "",
        "STR_DISTRICT": "SAVANES",
        "STR_REGION": "BAGOUE",
        "STR_SOUSPREFECTURE": ""
      },
      {
        "STR_COMMUNE": "Brobo",
        "STR_DEPARTEMENT": "",
        "STR_DISTRICT": "VALLEE DU BANDAMA",
        "STR_REGION": "GBEKE",
        "STR_SOUSPREFECTURE": ""
      },
      {
        "STR_COMMUNE": "Buyo",
        "STR_DEPARTEMENT": "",
        "STR_DISTRICT": "BAS-SASSANDRA",
        "STR_REGION": "NAWA",
        "STR_SOUSPREFECTURE": ""
      },
      {
        "STR_COMMUNE": "Cocody",
        "STR_DEPARTEMENT": "",
        "STR_DISTRICT": "ABIDJAN",
        "STR_REGION": "ABIDJAN",
        "STR_SOUSPREFECTURE": ""
      },
      {
        "STR_COMMUNE": "Dabakala",
        "STR_DEPARTEMENT": "",
        "STR_DISTRICT": "VALLEE DU BANDAMA",
        "STR_REGION": "HAMBOL",
        "STR_SOUSPREFECTURE": ""
      },
      {
        "STR_COMMUNE": "Dabou",
        "STR_DEPARTEMENT": "",
        "STR_DISTRICT": "LAGUNES",
        "STR_REGION": "GRANDS PONTS",
        "STR_SOUSPREFECTURE": ""
      },
      {
        "STR_COMMUNE": "Daloa",
        "STR_DEPARTEMENT": "",
        "STR_DISTRICT": "SASSANDRA-MARAHOUE",
        "STR_REGION": "HAUT-SASSANDRA",
        "STR_SOUSPREFECTURE": ""
      },
      {
        "STR_COMMUNE": "Danané",
        "STR_DEPARTEMENT": "",
        "STR_DISTRICT": "MONTAGNES",
        "STR_REGION": "TONKPI",
        "STR_SOUSPREFECTURE": ""
      },
      {
        "STR_COMMUNE": "Daoukro",
        "STR_DEPARTEMENT": "",
        "STR_DISTRICT": "LACS",
        "STR_REGION": "IFFOU",
        "STR_SOUSPREFECTURE": ""
      },
      {
        "STR_COMMUNE": "Diabo",
        "STR_DEPARTEMENT": "",
        "STR_DISTRICT": "VALLEE DU BANDAMA",
        "STR_REGION": "GBEKE",
        "STR_SOUSPREFECTURE": ""
      },
      {
        "STR_COMMUNE": "Dianra",
        "STR_DEPARTEMENT": "",
        "STR_DISTRICT": "WOROBA",
        "STR_REGION": "BERE",
        "STR_SOUSPREFECTURE": ""
      },
      {
        "STR_COMMUNE": "Diawala",
        "STR_DEPARTEMENT": "",
        "STR_DISTRICT": "SAVANES",
        "STR_REGION": "TCHOLOGO",
        "STR_SOUSPREFECTURE": ""
      },
      {
        "STR_COMMUNE": "Didievi",
        "STR_DEPARTEMENT": "",
        "STR_DISTRICT": "LACS",
        "STR_REGION": "BELIER",
        "STR_SOUSPREFECTURE": ""
      },
      {
        "STR_COMMUNE": "Dikodougou",
        "STR_DEPARTEMENT": "",
        "STR_DISTRICT": "SAVANES",
        "STR_REGION": "PORO",
        "STR_SOUSPREFECTURE": ""
      },
      {
        "STR_COMMUNE": "Dimbokro",
        "STR_DEPARTEMENT": "",
        "STR_DISTRICT": "LACS",
        "STR_REGION": "N'ZI",
        "STR_SOUSPREFECTURE": ""
      },
      {
        "STR_COMMUNE": "Dioulatiédougou",
        "STR_DEPARTEMENT": "",
        "STR_DISTRICT": "DENGUELE",
        "STR_REGION": "KABADOUGOU",
        "STR_SOUSPREFECTURE": ""
      },
      {
        "STR_COMMUNE": "Divo",
        "STR_DEPARTEMENT": "",
        "STR_DISTRICT": "GOH-DJIBOUA",
        "STR_REGION": "LOH-DJIBOUA",
        "STR_SOUSPREFECTURE": ""
      },
      {
        "STR_COMMUNE": "Diégonéfla",
        "STR_DEPARTEMENT": "",
        "STR_DISTRICT": "GOH-DJIBOUA",
        "STR_REGION": "GOH",
        "STR_SOUSPREFECTURE": ""
      },
      {
        "STR_COMMUNE": "Djekanou",
        "STR_DEPARTEMENT": "",
        "STR_DISTRICT": "LACS",
        "STR_REGION": "BELIER",
        "STR_SOUSPREFECTURE": ""
      },
      {
        "STR_COMMUNE": "Djibrosso",
        "STR_DEPARTEMENT": "",
        "STR_DISTRICT": "WOROBA",
        "STR_REGION": "WORODOUGOU",
        "STR_SOUSPREFECTURE": ""
      },
      {
        "STR_COMMUNE": "Doropo",
        "STR_DEPARTEMENT": "",
        "STR_DISTRICT": "ZANZAN",
        "STR_REGION": "BOUNKANI",
        "STR_SOUSPREFECTURE": ""
      },
      {
        "STR_COMMUNE": "Dualla",
        "STR_DEPARTEMENT": "",
        "STR_DISTRICT": "WOROBA",
        "STR_REGION": "WORODOUGOU",
        "STR_SOUSPREFECTURE": ""
      },
      {
        "STR_COMMUNE": "Duekoué",
        "STR_DEPARTEMENT": "",
        "STR_DISTRICT": "MONTAGNES",
        "STR_REGION": "GUEMON",
        "STR_SOUSPREFECTURE": ""
      },
      {
        "STR_COMMUNE": "Ettrokro",
        "STR_DEPARTEMENT": "",
        "STR_DISTRICT": "LACS",
        "STR_REGION": "IFFOU",
        "STR_SOUSPREFECTURE": ""
      },
      {
        "STR_COMMUNE": "Facobly",
        "STR_DEPARTEMENT": "",
        "STR_DISTRICT": "MONTAGNES",
        "STR_REGION": "GUEMON",
        "STR_SOUSPREFECTURE": ""
      },
      {
        "STR_COMMUNE": "Ferkessedougou",
        "STR_DEPARTEMENT": "",
        "STR_DISTRICT": "SAVANES",
        "STR_REGION": "TCHOLOGO",
        "STR_SOUSPREFECTURE": ""
      },
      {
        "STR_COMMUNE": "Foumbolo",
        "STR_DEPARTEMENT": "",
        "STR_DISTRICT": "VALLEE DU BANDAMA",
        "STR_REGION": "HAMBOL",
        "STR_SOUSPREFECTURE": ""
      },
      {
        "STR_COMMUNE": "Fresco",
        "STR_DEPARTEMENT": "",
        "STR_DISTRICT": "BAS-SASSANDRA",
        "STR_REGION": "GBÔKLE",
        "STR_SOUSPREFECTURE": ""
      },
      {
        "STR_COMMUNE": "Fronan",
        "STR_DEPARTEMENT": "",
        "STR_DISTRICT": "VALLEE DU BANDAMA",
        "STR_REGION": "HAMBOL",
        "STR_SOUSPREFECTURE": ""
      },
      {
        "STR_COMMUNE": "Gagnoa",
        "STR_DEPARTEMENT": "",
        "STR_DISTRICT": "GOH-DJIBOUA",
        "STR_REGION": "GOH",
        "STR_SOUSPREFECTURE": ""
      },
      {
        "STR_COMMUNE": "Gbeleban",
        "STR_DEPARTEMENT": "",
        "STR_DISTRICT": "DENGUELE",
        "STR_REGION": "KABADOUGOU",
        "STR_SOUSPREFECTURE": ""
      },
      {
        "STR_COMMUNE": "Gboguihe",
        "STR_DEPARTEMENT": "",
        "STR_DISTRICT": "SASSANDRA-MARAHOUE",
        "STR_REGION": "HAUT-SASSANDRA",
        "STR_SOUSPREFECTURE": ""
      },
      {
        "STR_COMMUNE": "Gbon",
        "STR_DEPARTEMENT": "",
        "STR_DISTRICT": "SAVANES",
        "STR_REGION": "BAGOUE",
        "STR_SOUSPREFECTURE": ""
      },
      {
        "STR_COMMUNE": "Gbonné",
        "STR_DEPARTEMENT": "",
        "STR_DISTRICT": "MONTAGNES",
        "STR_REGION": "TONKPI",
        "STR_SOUSPREFECTURE": ""
      },
      {
        "STR_COMMUNE": "Gohitafla",
        "STR_DEPARTEMENT": "",
        "STR_DISTRICT": "SASSANDRA-MARAHOUE",
        "STR_REGION": "MARAHOUE",
        "STR_SOUSPREFECTURE": ""
      },
      {
        "STR_COMMUNE": "Goulia",
        "STR_DEPARTEMENT": "",
        "STR_DISTRICT": "DENGUELE",
        "STR_REGION": "FOLON",
        "STR_SOUSPREFECTURE": ""
      },
      {
        "STR_COMMUNE": "Grabo",
        "STR_DEPARTEMENT": "",
        "STR_DISTRICT": "BAS-SASSANDRA",
        "STR_REGION": "SAN-PEDRO",
        "STR_SOUSPREFECTURE": ""
      },
      {
        "STR_COMMUNE": "Grand-Béréby",
        "STR_DEPARTEMENT": "",
        "STR_DISTRICT": "BAS-SASSANDRA",
        "STR_REGION": "SAN-PEDRO",
        "STR_SOUSPREFECTURE": ""
      },
      {
        "STR_COMMUNE": "Grand-Lahou",
        "STR_DEPARTEMENT": "",
        "STR_DISTRICT": "LAGUNES",
        "STR_REGION": "GRANDS PONTS",
        "STR_SOUSPREFECTURE": ""
      },
      {
        "STR_COMMUNE": "Grand-Zattry",
        "STR_DEPARTEMENT": "",
        "STR_DISTRICT": "BAS-SASSANDRA",
        "STR_REGION": "NAWA",
        "STR_SOUSPREFECTURE": ""
      },
      {
        "STR_COMMUNE": "Grand-bassam",
        "STR_DEPARTEMENT": "",
        "STR_DISTRICT": "COMOE",
        "STR_REGION": "SUD-COMOE",
        "STR_SOUSPREFECTURE": ""
      },
      {
        "STR_COMMUNE": "Gueyo",
        "STR_DEPARTEMENT": "",
        "STR_DISTRICT": "BAS-SASSANDRA",
        "STR_REGION": "NAWA",
        "STR_SOUSPREFECTURE": ""
      },
      {
        "STR_COMMUNE": "Guiberoua",
        "STR_DEPARTEMENT": "",
        "STR_DISTRICT": "GOH-DJIBOUA",
        "STR_REGION": "GOH",
        "STR_SOUSPREFECTURE": ""
      },
      {
        "STR_COMMUNE": "Guiembe",
        "STR_DEPARTEMENT": "",
        "STR_DISTRICT": "SAVANES",
        "STR_REGION": "PORO",
        "STR_SOUSPREFECTURE": ""
      },
      {
        "STR_COMMUNE": "Guiglo",
        "STR_DEPARTEMENT": "",
        "STR_DISTRICT": "MONTAGNES",
        "STR_REGION": "CAVALY",
        "STR_SOUSPREFECTURE": ""
      },
      {
        "STR_COMMUNE": "Guintéguéla",
        "STR_DEPARTEMENT": "",
        "STR_DISTRICT": "WOROBA",
        "STR_REGION": "BAFFING",
        "STR_SOUSPREFECTURE": ""
      },
      {
        "STR_COMMUNE": "Guitry",
        "STR_DEPARTEMENT": "",
        "STR_DISTRICT": "GOH-DJIBOUA",
        "STR_REGION": "LOH-DJIBOUA",
        "STR_SOUSPREFECTURE": ""
      },
      {
        "STR_COMMUNE": "Hiré",
        "STR_DEPARTEMENT": "",
        "STR_DISTRICT": "GOH-DJIBOUA",
        "STR_REGION": "LOH-DJIBOUA",
        "STR_SOUSPREFECTURE": ""
      },
      {
        "STR_COMMUNE": "Issia",
        "STR_DEPARTEMENT": "",
        "STR_DISTRICT": "SASSANDRA-MARAHOUE",
        "STR_REGION": "HAUT-SASSANDRA",
        "STR_SOUSPREFECTURE": ""
      },
      {
        "STR_COMMUNE": "Jacqueville",
        "STR_DEPARTEMENT": "",
        "STR_DISTRICT": "LAGUNES",
        "STR_REGION": "GRANDS PONTS",
        "STR_SOUSPREFECTURE": ""
      },
      {
        "STR_COMMUNE": "Kanakono",
        "STR_DEPARTEMENT": "",
        "STR_DISTRICT": "SAVANES",
        "STR_REGION": "BAGOUE",
        "STR_SOUSPREFECTURE": ""
      },
      {
        "STR_COMMUNE": "Kani",
        "STR_DEPARTEMENT": "",
        "STR_DISTRICT": "WOROBA",
        "STR_REGION": "WORODOUGOU",
        "STR_SOUSPREFECTURE": ""
      },
      {
        "STR_COMMUNE": "Kaniasso",
        "STR_DEPARTEMENT": "",
        "STR_DISTRICT": "DENGUELE",
        "STR_REGION": "FOLON",
        "STR_SOUSPREFECTURE": ""
      },
      {
        "STR_COMMUNE": "Karakoro",
        "STR_DEPARTEMENT": "",
        "STR_DISTRICT": "SAVANES",
        "STR_REGION": "PORO",
        "STR_SOUSPREFECTURE": ""
      },
      {
        "STR_COMMUNE": "Kasseret",
        "STR_DEPARTEMENT": "",
        "STR_DISTRICT": "SAVANES",
        "STR_REGION": "BAGOUE",
        "STR_SOUSPREFECTURE": ""
      },
      {
        "STR_COMMUNE": "Katiola",
        "STR_DEPARTEMENT": "",
        "STR_DISTRICT": "VALLEE DU BANDAMA",
        "STR_REGION": "HAMBOL",
        "STR_SOUSPREFECTURE": ""
      },
      {
        "STR_COMMUNE": "Kokoumbo",
        "STR_DEPARTEMENT": "",
        "STR_DISTRICT": "LACS",
        "STR_REGION": "BELIER",
        "STR_SOUSPREFECTURE": ""
      },
      {
        "STR_COMMUNE": "Kolia",
        "STR_DEPARTEMENT": "",
        "STR_DISTRICT": "SAVANES",
        "STR_REGION": "BAGOUE",
        "STR_SOUSPREFECTURE": ""
      },
      {
        "STR_COMMUNE": "Komborodougou",
        "STR_DEPARTEMENT": "",
        "STR_DISTRICT": "SAVANES",
        "STR_REGION": "PORO",
        "STR_SOUSPREFECTURE": ""
      },
      {
        "STR_COMMUNE": "Kong",
        "STR_DEPARTEMENT": "",
        "STR_DISTRICT": "SAVANES",
        "STR_REGION": "TCHOLOGO",
        "STR_SOUSPREFECTURE": ""
      },
      {
        "STR_COMMUNE": "Kongasso",
        "STR_DEPARTEMENT": "",
        "STR_DISTRICT": "WOROBA",
        "STR_REGION": "BERE",
        "STR_SOUSPREFECTURE": ""
      },
      {
        "STR_COMMUNE": "Koonan",
        "STR_DEPARTEMENT": "",
        "STR_DISTRICT": "WOROBA",
        "STR_REGION": "BAFFING",
        "STR_SOUSPREFECTURE": ""
      },
      {
        "STR_COMMUNE": "Korhogo",
        "STR_DEPARTEMENT": "",
        "STR_DISTRICT": "SAVANES",
        "STR_REGION": "PORO",
        "STR_SOUSPREFECTURE": ""
      },
      {
        "STR_COMMUNE": "Koro",
        "STR_DEPARTEMENT": "",
        "STR_DISTRICT": "WOROBA",
        "STR_REGION": "BAFFING",
        "STR_SOUSPREFECTURE": ""
      },
      {
        "STR_COMMUNE": "Kouassi-Datékro",
        "STR_DEPARTEMENT": "",
        "STR_DISTRICT": "ZANZAN",
        "STR_REGION": "GONTOUGO",
        "STR_SOUSPREFECTURE": ""
      },
      {
        "STR_COMMUNE": "Kouassi-kouassikro",
        "STR_DEPARTEMENT": "",
        "STR_DISTRICT": "LACS",
        "STR_REGION": "N'ZI",
        "STR_SOUSPREFECTURE": ""
      },
      {
        "STR_COMMUNE": "Kouibly",
        "STR_DEPARTEMENT": "",
        "STR_DISTRICT": "MONTAGNES",
        "STR_REGION": "GUEMON",
        "STR_SOUSPREFECTURE": ""
      },
      {
        "STR_COMMUNE": "Koumassi",
        "STR_DEPARTEMENT": "",
        "STR_DISTRICT": "ABIDJAN",
        "STR_REGION": "ABIDJAN",
        "STR_SOUSPREFECTURE": ""
      },
      {
        "STR_COMMUNE": "Koumbala",
        "STR_DEPARTEMENT": "",
        "STR_DISTRICT": "SAVANES",
        "STR_REGION": "TCHOLOGO",
        "STR_SOUSPREFECTURE": ""
      },
      {
        "STR_COMMUNE": "Koun-Fao",
        "STR_DEPARTEMENT": "",
        "STR_DISTRICT": "ZANZAN",
        "STR_REGION": "GONTOUGO",
        "STR_SOUSPREFECTURE": ""
      },
      {
        "STR_COMMUNE": "Kounahiri",
        "STR_DEPARTEMENT": "",
        "STR_DISTRICT": "WOROBA",
        "STR_REGION": "BERE",
        "STR_SOUSPREFECTURE": ""
      },
      {
        "STR_COMMUNE": "Kouto",
        "STR_DEPARTEMENT": "",
        "STR_DISTRICT": "SAVANES",
        "STR_REGION": "BAGOUE",
        "STR_SOUSPREFECTURE": ""
      },
      {
        "STR_COMMUNE": "Lakota",
        "STR_DEPARTEMENT": "",
        "STR_DISTRICT": "GOH-DJIBOUA",
        "STR_REGION": "LOH-DJIBOUA",
        "STR_SOUSPREFECTURE": ""
      },
      {
        "STR_COMMUNE": "Logoualé",
        "STR_DEPARTEMENT": "",
        "STR_DISTRICT": "MONTAGNES",
        "STR_REGION": "TONKPI",
        "STR_SOUSPREFECTURE": ""
      },
      {
        "STR_COMMUNE": "M'bahiakro",
        "STR_DEPARTEMENT": "",
        "STR_DISTRICT": "LACS",
        "STR_REGION": "IFFOU",
        "STR_SOUSPREFECTURE": ""
      },
      {
        "STR_COMMUNE": "M'batto",
        "STR_DEPARTEMENT": "",
        "STR_DISTRICT": "LACS",
        "STR_REGION": "N'ZI",
        "STR_SOUSPREFECTURE": ""
      },
      {
        "STR_COMMUNE": "M'bengué",
        "STR_DEPARTEMENT": "",
        "STR_DISTRICT": "SAVANES",
        "STR_REGION": "BAGOUE",
        "STR_SOUSPREFECTURE": ""
      },
      {
        "STR_COMMUNE": "Madinani",
        "STR_DEPARTEMENT": "",
        "STR_DISTRICT": "DENGUELE",
        "STR_REGION": "KABADOUGOU",
        "STR_SOUSPREFECTURE": ""
      },
      {
        "STR_COMMUNE": "Mafere",
        "STR_DEPARTEMENT": "",
        "STR_DISTRICT": "COMOE",
        "STR_REGION": "SUD-COMOE",
        "STR_SOUSPREFECTURE": ""
      },
      {
        "STR_COMMUNE": "Man",
        "STR_DEPARTEMENT": "",
        "STR_DISTRICT": "MONTAGNES",
        "STR_REGION": "TONKPI",
        "STR_SOUSPREFECTURE": ""
      },
      {
        "STR_COMMUNE": "Mankono",
        "STR_DEPARTEMENT": "",
        "STR_DISTRICT": "WOROBA",
        "STR_REGION": "BERE",
        "STR_SOUSPREFECTURE": ""
      },
      {
        "STR_COMMUNE": "Marcory",
        "STR_DEPARTEMENT": "",
        "STR_DISTRICT": "ABIDJAN",
        "STR_REGION": "ABIDJAN",
        "STR_SOUSPREFECTURE": ""
      },
      {
        "STR_COMMUNE": "Massala",
        "STR_DEPARTEMENT": "",
        "STR_DISTRICT": "WOROBA",
        "STR_REGION": "WORODOUGOU",
        "STR_SOUSPREFECTURE": ""
      },
      {
        "STR_COMMUNE": "Mayo",
        "STR_DEPARTEMENT": "",
        "STR_DISTRICT": "BAS-SASSANDRA",
        "STR_REGION": "NAWA",
        "STR_SOUSPREFECTURE": ""
      },
      {
        "STR_COMMUNE": "Minignan",
        "STR_DEPARTEMENT": "",
        "STR_DISTRICT": "DENGUELE",
        "STR_REGION": "FOLON",
        "STR_SOUSPREFECTURE": ""
      },
      {
        "STR_COMMUNE": "Morondo",
        "STR_DEPARTEMENT": "",
        "STR_DISTRICT": "WOROBA",
        "STR_REGION": "WORODOUGOU",
        "STR_SOUSPREFECTURE": ""
      },
      {
        "STR_COMMUNE": "Méagui",
        "STR_DEPARTEMENT": "",
        "STR_DISTRICT": "BAS-SASSANDRA",
        "STR_REGION": "NAWA",
        "STR_SOUSPREFECTURE": ""
      },
      {
        "STR_COMMUNE": "N'Djebonouan",
        "STR_DEPARTEMENT": "",
        "STR_DISTRICT": "VALLEE DU BANDAMA",
        "STR_REGION": "GBEKE",
        "STR_SOUSPREFECTURE": ""
      },
      {
        "STR_COMMUNE": "N'Douci",
        "STR_DEPARTEMENT": "",
        "STR_DISTRICT": "LAGUNES",
        "STR_REGION": "AGNEBY TIASSA",
        "STR_SOUSPREFECTURE": ""
      },
      {
        "STR_COMMUNE": "Napieledougou",
        "STR_DEPARTEMENT": "",
        "STR_DISTRICT": "SAVANES",
        "STR_REGION": "PORO",
        "STR_SOUSPREFECTURE": ""
      },
      {
        "STR_COMMUNE": "Nassian",
        "STR_DEPARTEMENT": "",
        "STR_DISTRICT": "ZANZAN",
        "STR_REGION": "BOUNKANI",
        "STR_SOUSPREFECTURE": ""
      },
      {
        "STR_COMMUNE": "Niablé",
        "STR_DEPARTEMENT": "",
        "STR_DISTRICT": "COMOE",
        "STR_REGION": "INDENIE-DJUABLIN",
        "STR_SOUSPREFECTURE": ""
      },
      {
        "STR_COMMUNE": "Niakaramandougou",
        "STR_DEPARTEMENT": "",
        "STR_DISTRICT": "VALLEE DU BANDAMA",
        "STR_REGION": "HAMBOL",
        "STR_SOUSPREFECTURE": ""
      },
      {
        "STR_COMMUNE": "Nielle",
        "STR_DEPARTEMENT": "",
        "STR_DISTRICT": "SAVANES",
        "STR_REGION": "TCHOLOGO",
        "STR_SOUSPREFECTURE": ""
      },
      {
        "STR_COMMUNE": "Niofoin",
        "STR_DEPARTEMENT": "",
        "STR_DISTRICT": "SAVANES",
        "STR_REGION": "PORO",
        "STR_SOUSPREFECTURE": ""
      },
      {
        "STR_COMMUNE": "Odienné",
        "STR_DEPARTEMENT": "",
        "STR_DISTRICT": "DENGUELE",
        "STR_REGION": "KABADOUGOU",
        "STR_SOUSPREFECTURE": ""
      },
      {
        "STR_COMMUNE": "Ouangolodougou",
        "STR_DEPARTEMENT": "",
        "STR_DISTRICT": "SAVANES",
        "STR_REGION": "TCHOLOGO",
        "STR_SOUSPREFECTURE": ""
      },
      {
        "STR_COMMUNE": "Ouaninou",
        "STR_DEPARTEMENT": "",
        "STR_DISTRICT": "WOROBA",
        "STR_REGION": "BAFFING",
        "STR_SOUSPREFECTURE": ""
      },
      {
        "STR_COMMUNE": "Ouelle",
        "STR_DEPARTEMENT": "",
        "STR_DISTRICT": "LACS",
        "STR_REGION": "IFFOU",
        "STR_SOUSPREFECTURE": ""
      },
      {
        "STR_COMMUNE": "Oumé",
        "STR_DEPARTEMENT": "",
        "STR_DISTRICT": "GOH-DJIBOUA",
        "STR_REGION": "GOH",
        "STR_SOUSPREFECTURE": ""
      },
      {
        "STR_COMMUNE": "Ouragahio",
        "STR_DEPARTEMENT": "",
        "STR_DISTRICT": "GOH-DJIBOUA",
        "STR_REGION": "GOH",
        "STR_SOUSPREFECTURE": ""
      },
      {
        "STR_COMMUNE": "Plateau",
        "STR_DEPARTEMENT": "",
        "STR_DISTRICT": "ABIDJAN",
        "STR_REGION": "ABIDJAN",
        "STR_SOUSPREFECTURE": ""
      },
      {
        "STR_COMMUNE": "Port-Bouet",
        "STR_DEPARTEMENT": "",
        "STR_DISTRICT": "ABIDJAN",
        "STR_REGION": "ABIDJAN",
        "STR_SOUSPREFECTURE": ""
      },
      {
        "STR_COMMUNE": "Prikro",
        "STR_DEPARTEMENT": "",
        "STR_DISTRICT": "LACS",
        "STR_REGION": "IFFOU",
        "STR_SOUSPREFECTURE": ""
      },
      {
        "STR_COMMUNE": "Rubino",
        "STR_DEPARTEMENT": "",
        "STR_DISTRICT": "LAGUNES",
        "STR_REGION": "AGNEBY TIASSA",
        "STR_SOUSPREFECTURE": ""
      },
      {
        "STR_COMMUNE": "Sakassou",
        "STR_DEPARTEMENT": "",
        "STR_DISTRICT": "VALLEE DU BANDAMA",
        "STR_REGION": "GBEKE",
        "STR_SOUSPREFECTURE": ""
      },
      {
        "STR_COMMUNE": "Samatiguila",
        "STR_DEPARTEMENT": "",
        "STR_DISTRICT": "DENGUELE",
        "STR_REGION": "KABADOUGOU",
        "STR_SOUSPREFECTURE": ""
      },
      {
        "STR_COMMUNE": "San-Pédro",
        "STR_DEPARTEMENT": "",
        "STR_DISTRICT": "BAS-SASSANDRA",
        "STR_REGION": "SAN-PEDRO",
        "STR_SOUSPREFECTURE": ""
      },
      {
        "STR_COMMUNE": "Sandegue",
        "STR_DEPARTEMENT": "",
        "STR_DISTRICT": "ZANZAN",
        "STR_REGION": "GONTOUGO",
        "STR_SOUSPREFECTURE": ""
      },
      {
        "STR_COMMUNE": "Sangouiné",
        "STR_DEPARTEMENT": "",
        "STR_DISTRICT": "MONTAGNES",
        "STR_REGION": "TONKPI",
        "STR_SOUSPREFECTURE": ""
      },
      {
        "STR_COMMUNE": "Sarhala",
        "STR_DEPARTEMENT": "",
        "STR_DISTRICT": "WOROBA",
        "STR_REGION": "BERE",
        "STR_SOUSPREFECTURE": ""
      },
      {
        "STR_COMMUNE": "Sassandra",
        "STR_DEPARTEMENT": "",
        "STR_DISTRICT": "BAS-SASSANDRA",
        "STR_REGION": "GBÔKLE",
        "STR_SOUSPREFECTURE": ""
      },
      {
        "STR_COMMUNE": "Satama-sokora",
        "STR_DEPARTEMENT": "",
        "STR_DISTRICT": "VALLEE DU BANDAMA",
        "STR_REGION": "HAMBOL",
        "STR_SOUSPREFECTURE": ""
      },
      {
        "STR_COMMUNE": "Satama-sokouro",
        "STR_DEPARTEMENT": "",
        "STR_DISTRICT": "VALLEE DU BANDAMA",
        "STR_REGION": "HAMBOL",
        "STR_SOUSPREFECTURE": ""
      },
      {
        "STR_COMMUNE": "Saïoua",
        "STR_DEPARTEMENT": "",
        "STR_DISTRICT": "SASSANDRA-MARAHOUE",
        "STR_REGION": "HAUT-SASSANDRA",
        "STR_SOUSPREFECTURE": ""
      },
      {
        "STR_COMMUNE": "Seguelon",
        "STR_DEPARTEMENT": "",
        "STR_DISTRICT": "DENGUELE",
        "STR_REGION": "KABADOUGOU",
        "STR_SOUSPREFECTURE": ""
      },
      {
        "STR_COMMUNE": "Seydougou",
        "STR_DEPARTEMENT": "",
        "STR_DISTRICT": "DENGUELE",
        "STR_REGION": "KABADOUGOU",
        "STR_SOUSPREFECTURE": ""
      },
      {
        "STR_COMMUNE": "Sifie",
        "STR_DEPARTEMENT": "",
        "STR_DISTRICT": "WOROBA",
        "STR_REGION": "WORODOUGOU",
        "STR_SOUSPREFECTURE": ""
      },
      {
        "STR_COMMUNE": "Sikensi",
        "STR_DEPARTEMENT": "",
        "STR_DISTRICT": "LAGUNES",
        "STR_REGION": "LA ME",
        "STR_SOUSPREFECTURE": ""
      },
      {
        "STR_COMMUNE": "Sinematiali",
        "STR_DEPARTEMENT": "",
        "STR_DISTRICT": "SAVANES",
        "STR_REGION": "PORO",
        "STR_SOUSPREFECTURE": ""
      },
      {
        "STR_COMMUNE": "Sinfra",
        "STR_DEPARTEMENT": "",
        "STR_DISTRICT": "SASSANDRA-MARAHOUE",
        "STR_REGION": "MARAHOUE",
        "STR_SOUSPREFECTURE": ""
      },
      {
        "STR_COMMUNE": "Sipilou",
        "STR_DEPARTEMENT": "",
        "STR_DISTRICT": "MONTAGNES",
        "STR_REGION": "GUEMON",
        "STR_SOUSPREFECTURE": ""
      },
      {
        "STR_COMMUNE": "Sirasso",
        "STR_DEPARTEMENT": "",
        "STR_DISTRICT": "SAVANES",
        "STR_REGION": "PORO",
        "STR_SOUSPREFECTURE": ""
      },
      {
        "STR_COMMUNE": "Songon",
        "STR_DEPARTEMENT": "",
        "STR_DISTRICT": "ABIDJAN",
        "STR_REGION": "ABIDJAN",
        "STR_SOUSPREFECTURE": ""
      },
      {
        "STR_COMMUNE": "Soubré",
        "STR_DEPARTEMENT": "",
        "STR_DISTRICT": "BAS-SASSANDRA",
        "STR_REGION": "NAWA",
        "STR_SOUSPREFECTURE": ""
      },
      {
        "STR_COMMUNE": "Séguéla",
        "STR_DEPARTEMENT": "",
        "STR_DISTRICT": "WOROBA",
        "STR_REGION": "WORODOUGOU",
        "STR_SOUSPREFECTURE": ""
      },
      {
        "STR_COMMUNE": "Taabo",
        "STR_DEPARTEMENT": "",
        "STR_DISTRICT": "LAGUNES",
        "STR_REGION": "AGNEBY TIASSA",
        "STR_SOUSPREFECTURE": ""
      },
      {
        "STR_COMMUNE": "Tabou",
        "STR_DEPARTEMENT": "",
        "STR_DISTRICT": "BAS-SASSANDRA",
        "STR_REGION": "SAN-PEDRO",
        "STR_SOUSPREFECTURE": ""
      },
      {
        "STR_COMMUNE": "Tafire",
        "STR_DEPARTEMENT": "",
        "STR_DISTRICT": "VALLEE DU BANDAMA",
        "STR_REGION": "HAMBOL",
        "STR_SOUSPREFECTURE": ""
      },
      {
        "STR_COMMUNE": "Tanda",
        "STR_DEPARTEMENT": "",
        "STR_DISTRICT": "ZANZAN",
        "STR_REGION": "GONTOUGO",
        "STR_SOUSPREFECTURE": ""
      },
      {
        "STR_COMMUNE": "Taï",
        "STR_DEPARTEMENT": "",
        "STR_DISTRICT": "MONTAGNES",
        "STR_REGION": "CAVALY",
        "STR_SOUSPREFECTURE": ""
      },
      {
        "STR_COMMUNE": "Tengrela",
        "STR_DEPARTEMENT": "",
        "STR_DISTRICT": "SAVANES",
        "STR_REGION": "BAGOUE",
        "STR_SOUSPREFECTURE": ""
      },
      {
        "STR_COMMUNE": "Tiapoum",
        "STR_DEPARTEMENT": "",
        "STR_DISTRICT": "COMOE",
        "STR_REGION": "SUD-COMOE",
        "STR_SOUSPREFECTURE": ""
      },
      {
        "STR_COMMUNE": "Tiassalé",
        "STR_DEPARTEMENT": "",
        "STR_DISTRICT": "LAGUNES",
        "STR_REGION": "AGNEBY TIASSA",
        "STR_SOUSPREFECTURE": ""
      },
      {
        "STR_COMMUNE": "Tie-n’diekro",
        "STR_DEPARTEMENT": "",
        "STR_DISTRICT": "LACS",
        "STR_REGION": "BELIER",
        "STR_SOUSPREFECTURE": ""
      },
      {
        "STR_COMMUNE": "Tiebissou",
        "STR_DEPARTEMENT": "",
        "STR_DISTRICT": "LACS",
        "STR_REGION": "BELIER",
        "STR_SOUSPREFECTURE": ""
      },
      {
        "STR_COMMUNE": "Tieme",
        "STR_DEPARTEMENT": "",
        "STR_DISTRICT": "DENGUELE",
        "STR_REGION": "KABADOUGOU",
        "STR_SOUSPREFECTURE": ""
      },
      {
        "STR_COMMUNE": "Tiemelekro",
        "STR_DEPARTEMENT": "",
        "STR_DISTRICT": "LACS",
        "STR_REGION": "N'ZI",
        "STR_SOUSPREFECTURE": ""
      },
      {
        "STR_COMMUNE": "Tieningboue",
        "STR_DEPARTEMENT": "",
        "STR_DISTRICT": "WOROBA",
        "STR_REGION": "BERE",
        "STR_SOUSPREFECTURE": ""
      },
      {
        "STR_COMMUNE": "Tienko",
        "STR_DEPARTEMENT": "",
        "STR_DISTRICT": "DENGUELE",
        "STR_REGION": "FOLON",
        "STR_SOUSPREFECTURE": ""
      },
      {
        "STR_COMMUNE": "Tioroniaradougou",
        "STR_DEPARTEMENT": "",
        "STR_DISTRICT": "SAVANES",
        "STR_REGION": "PORO",
        "STR_SOUSPREFECTURE": ""
      },
      {
        "STR_COMMUNE": "Tortiya",
        "STR_DEPARTEMENT": "",
        "STR_DISTRICT": "VALLEE DU BANDAMA",
        "STR_REGION": "HAMBOL",
        "STR_SOUSPREFECTURE": ""
      },
      {
        "STR_COMMUNE": "Touba",
        "STR_DEPARTEMENT": "",
        "STR_DISTRICT": "WOROBA",
        "STR_REGION": "BAFFING",
        "STR_SOUSPREFECTURE": ""
      },
      {
        "STR_COMMUNE": "Toulepleu",
        "STR_DEPARTEMENT": "",
        "STR_DISTRICT": "MONTAGNES",
        "STR_REGION": "CAVALY",
        "STR_SOUSPREFECTURE": ""
      },
      {
        "STR_COMMUNE": "Toumodi",
        "STR_DEPARTEMENT": "",
        "STR_DISTRICT": "LACS",
        "STR_REGION": "BELIER",
        "STR_SOUSPREFECTURE": ""
      },
      {
        "STR_COMMUNE": "Transua",
        "STR_DEPARTEMENT": "",
        "STR_DISTRICT": "ZANZAN",
        "STR_REGION": "GONTOUGO",
        "STR_SOUSPREFECTURE": ""
      },
      {
        "STR_COMMUNE": "Treichville",
        "STR_DEPARTEMENT": "",
        "STR_DISTRICT": "ABIDJAN",
        "STR_REGION": "ABIDJAN",
        "STR_SOUSPREFECTURE": ""
      },
      {
        "STR_COMMUNE": "Téhini",
        "STR_DEPARTEMENT": "",
        "STR_DISTRICT": "ZANZAN",
        "STR_REGION": "BOUNKANI",
        "STR_SOUSPREFECTURE": ""
      },
      {
        "STR_COMMUNE": "Vavoua",
        "STR_DEPARTEMENT": "",
        "STR_DISTRICT": "SASSANDRA-MARAHOUE",
        "STR_REGION": "HAUT-SASSANDRA",
        "STR_SOUSPREFECTURE": ""
      },
      {
        "STR_COMMUNE": "Worofla",
        "STR_DEPARTEMENT": "",
        "STR_DISTRICT": "WOROBA",
        "STR_REGION": "WORODOUGOU",
        "STR_SOUSPREFECTURE": ""
      },
      {
        "STR_COMMUNE": "Yakasse-attobrou",
        "STR_DEPARTEMENT": "",
        "STR_DISTRICT": "LAGUNES",
        "STR_REGION": "LA ME",
        "STR_SOUSPREFECTURE": ""
      },
      {
        "STR_COMMUNE": "Yamoussoukro",
        "STR_DEPARTEMENT": "",
        "STR_DISTRICT": "YAMOUSSOUKRO",
        "STR_REGION": "YAMOUSSOUKRO",
        "STR_SOUSPREFECTURE": ""
      },
      {
        "STR_COMMUNE": "Yopougon",
        "STR_DEPARTEMENT": "",
        "STR_DISTRICT": "ABIDJAN",
        "STR_REGION": "ABIDJAN",
        "STR_SOUSPREFECTURE": ""
      },
      {
        "STR_COMMUNE": "Zikisso",
        "STR_DEPARTEMENT": "",
        "STR_DISTRICT": "GOH-DJIBOUA",
        "STR_REGION": "LOH-DJIBOUA",
        "STR_SOUSPREFECTURE": ""
      },
      {
        "STR_COMMUNE": "Zouan-hounien",
        "STR_DEPARTEMENT": "",
        "STR_DISTRICT": "MONTAGNES",
        "STR_REGION": "TONKPI",
        "STR_SOUSPREFECTURE": ""
      },
      {
        "STR_COMMUNE": "Zoukougbeu",
        "STR_DEPARTEMENT": "",
        "STR_DISTRICT": "SASSANDRA-MARAHOUE",
        "STR_REGION": "HAUT-SASSANDRA",
        "STR_SOUSPREFECTURE": ""
      },
      {
        "STR_COMMUNE": "Zuenoula",
        "STR_DEPARTEMENT": "",
        "STR_DISTRICT": "SASSANDRA-MARAHOUE",
        "STR_REGION": "MARAHOUE",
        "STR_SOUSPREFECTURE": ""
      }
    ];

    final collectionRef = firestore.collection('communes');

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Liste des Communes'),
      ),
      body: Column(
        children: [
          // Bouton pour importer les données
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () async {
                await importData();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Importation terminée !')),
                );
              },
              child: Text('Importer les Données'),
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('communes').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text('Erreur de chargement'));
                }
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Center(child: Text('Aucune donnée disponible'));
                }

                final communes = snapshot.data!.docs;

                return ListView.builder(
                  itemCount: communes.length,
                  itemBuilder: (context, index) {
                    final communeData = communes[index].data() as Map<String, dynamic>;

                    // Vérifiez que les champs existent et ne sont pas nuls
                    final communeName = communeData['STR_COMMUNE'] ?? 'Nom inconnu';
                    final region = communeData['STR_REGION'] ?? 'Région inconnue';
                    final district = communeData['STR_DISTRICT'] ?? 'District inconnu';

                    return ListTile(
                      title: Text(communeName),
                      subtitle: Text('Région: $region\nDistrict: $district'),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
