import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EditPage extends StatefulWidget {
  final String documentId;
  final Map<String, dynamic> data;

  EditPage({required this.documentId, required this.data});

  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  late TextEditingController _anneeNaturalisationController;
  late TextEditingController _avezVousCniController;
  late TextEditingController _avezVousPassportController;
  late TextEditingController _campementController;
  late TextEditingController _comiteQuartierController;
  late TextEditingController _comiteVillageoisController;
  late TextEditingController _communeController;
  late TextEditingController _dateNaissanceController;
  late TextEditingController _delegationCommuPdcController;
  late TextEditingController _delegationDepartPdcController;
  late TextEditingController _departementController;
  late TextEditingController _devenirMembrePdcController;
  late TextEditingController _districtController;
  late TextEditingController _etesVousDansAssociationController;
  late TextEditingController _etesVousIvoirienController;
  late TextEditingController _fonctionInAssociationController;
  late TextEditingController _fonctionOccupationController;
  late TextEditingController _genreController;
  late TextEditingController _lieuNaissanceController;
  late TextEditingController _lieuResidenceController;
  late TextEditingController _lieuTravailController;
  late TextEditingController _mailController;
  late TextEditingController _raisonNePasDevenirMembrePdcController;
  late TextEditingController _refNaturalisationController;
  late TextEditingController _regionController;
  late TextEditingController _secteurActiviteController;
  late TextEditingController _sousprefectureController;
  late TextEditingController _villageController;

  late bool _neConnaitPasProgramme;
  late bool _nePartagePasIdeaux;
  late bool _resterAPolitique;

  @override
  void initState() {
    super.initState();
    _anneeNaturalisationController = TextEditingController(text: widget.data['STR_ANNEENATURALISATION'] ?? '');
    _avezVousCniController = TextEditingController(text: widget.data['STR_AVEZ_VOUS_CNI'] ?? '');
    _avezVousPassportController = TextEditingController(text: widget.data['STR_AVEZ_VOUS_UN_PASSPORT'] ?? '');
    _campementController = TextEditingController(text: widget.data['STR_CAMPEMENT'] ?? '');
    _comiteQuartierController = TextEditingController(text: widget.data['STR_COMITE_QUARTIER'] ?? '');
    _comiteVillageoisController = TextEditingController(text: widget.data['STR_COMITE_VILLAGEOIS'] ?? '');
    _communeController = TextEditingController(text: widget.data['STR_COMMUNE'] ?? '');
    _dateNaissanceController = TextEditingController(text: widget.data['STR_DATENAISSANCE'] ?? '');
    _delegationCommuPdcController = TextEditingController(text: widget.data['STR_DELEGATION_COMMU_PDCI'] ?? '');
    _delegationDepartPdcController = TextEditingController(text: widget.data['STR_DELEGATION_DEPARTE_PDCI'] ?? '');
    _departementController = TextEditingController(text: widget.data['STR_DEPARTEMENT'] ?? '');
    _devenirMembrePdcController = TextEditingController(text: widget.data['STR_DEVENIR_MEMBRE_PDCI'] ?? '');
    _districtController = TextEditingController(text: widget.data['STR_DISTRICT'] ?? '');
    _etesVousDansAssociationController = TextEditingController(text: widget.data['STR_ETES_VOUS_DANS_UNE_ASSOCIATION'] ?? '');
    _etesVousIvoirienController = TextEditingController(text: widget.data['STR_ETES_VOUS_IVOIRIEN'] ?? '');
    _fonctionInAssociationController = TextEditingController(text: widget.data['STR_FONCTION_IN_ASSOCIATION'] ?? '');
    _fonctionOccupationController = TextEditingController(text: widget.data['STR_FONCTION_OCCUPATION'] ?? '');
    _genreController = TextEditingController(text: widget.data['STR_GENRE'] ?? '');
    _lieuNaissanceController = TextEditingController(text: widget.data['STR_LIEU_NAISSANCE'] ?? '');
    _lieuResidenceController = TextEditingController(text: widget.data['STR_LIEU_RESIDENCE'] ?? '');
    _lieuTravailController = TextEditingController(text: widget.data['STR_LIEU_TRAVAIL'] ?? '');
    _mailController = TextEditingController(text: widget.data['STR_MAIL'] ?? '');
    _raisonNePasDevenirMembrePdcController = TextEditingController(text: widget.data['STR_RAISON_NE_PAS_DEVENIR_MEMBRE_PDCI'] ?? '');
    _refNaturalisationController = TextEditingController(text: widget.data['STR_REF_NATURALISATION'] ?? '');
    _regionController = TextEditingController(text: widget.data['STR_REGION'] ?? '');
    _secteurActiviteController = TextEditingController(text: widget.data['STR_SECTEUR_ACTIVITE'] ?? '');
    _sousprefectureController = TextEditingController(text: widget.data['STR_SOUSPREFECTURTE'] ?? '');
    _villageController = TextEditingController(text: widget.data['STR_VILLAGE'] ?? '');

    _neConnaitPasProgramme = widget.data['STR_NE_CONNAIT_PAS_PROGRAMME'] ?? false;
    _nePartagePasIdeaux = widget.data['STR_NE_PARTAGE_PAS_IDEAUX'] ?? false;
    _resterAPolitique = widget.data['STR_RESTERAPOLITIQUE'] ?? false;
  }

  Future<void> _updateData() async {
    try {
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('User not logged in')),
        );
        return;
      }

      await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser.uid)
          .collection('form_data')
          .doc(widget.documentId)
          .update({
        'STR_ANNEENATURALISATION': _anneeNaturalisationController.text,
        'STR_AVEZ_VOUS_CNI': _avezVousCniController.text,
        'STR_AVEZ_VOUS_UN_PASSPORT': _avezVousPassportController.text,
        'STR_CAMPEMENT': _campementController.text,
        'STR_COMITE_QUARTIER': _comiteQuartierController.text,
        'STR_COMITE_VILLAGEOIS': _comiteVillageoisController.text,
        'STR_COMMUNE': _communeController.text,
        'STR_DATENAISSANCE': _dateNaissanceController.text,
        'STR_DELEGATION_COMMU_PDCI': _delegationCommuPdcController.text,
        'STR_DELEGATION_DEPARTE_PDCI': _delegationDepartPdcController.text,
        'STR_DEPARTEMENT': _departementController.text,
        'STR_DEVENIR_MEMBRE_PDCI': _devenirMembrePdcController.text,
        'STR_DISTRICT': _districtController.text,
        'STR_ETES_VOUS_DANS_UNE_ASSOCIATION': _etesVousDansAssociationController.text,
        'STR_ETES_VOUS_IVOIRIEN': _etesVousIvoirienController.text,
        'STR_FONCTION_IN_ASSOCIATION': _fonctionInAssociationController.text,
        'STR_FONCTION_OCCUPATION': _fonctionOccupationController.text,
        'STR_GENRE': _genreController.text,
        'STR_LIEU_NAISSANCE': _lieuNaissanceController.text,
        'STR_LIEU_RESIDENCE': _lieuResidenceController.text,
        'STR_LIEU_TRAVAIL': _lieuTravailController.text,
        'STR_MAIL': _mailController.text,
        'STR_RAISON_NE_PAS_DEVENIR_MEMBRE_PDCI': _raisonNePasDevenirMembrePdcController.text,
        'STR_REF_NATURALISATION': _refNaturalisationController.text,
        'STR_REGION': _regionController.text,
        'STR_SECTEUR_ACTIVITE': _secteurActiviteController.text,
        'STR_SOUSPREFECTURTE': _sousprefectureController.text,
        'STR_VILLAGE': _villageController.text,
        'STR_NE_CONNAIT_PAS_PROGRAMME': _neConnaitPasProgramme,
        'STR_NE_PARTAGE_PAS_IDEAUX': _nePartagePasIdeaux,
        'STR_RESTERAPOLITIQUE': _resterAPolitique,
      });
      Navigator.pop(context);
    } catch (e) {
      print('Error updating data: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error updating data')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Modifier les informations'),
        backgroundColor: Color(0xFF007D3C),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            TextField(
              controller: _anneeNaturalisationController,
              decoration: InputDecoration(labelText: 'Année de naturalisation'),
            ),
            TextField(
              controller: _avezVousCniController,
              decoration: InputDecoration(labelText: 'Avez-vous CNI'),
            ),
            TextField(
              controller: _avezVousPassportController,
              decoration: InputDecoration(labelText: 'Avez-vous Passport'),
            ),
            TextField(
              controller: _campementController,
              decoration: InputDecoration(labelText: 'Campement'),
            ),
            TextField(
              controller: _comiteQuartierController,
              decoration: InputDecoration(labelText: 'Comité Quartier'),
            ),
            TextField(
              controller: _comiteVillageoisController,
              decoration: InputDecoration(labelText: 'Comité Villageois'),
            ),
            TextField(
              controller: _communeController,
              decoration: InputDecoration(labelText: 'Commune'),
            ),
            TextField(
              controller: _dateNaissanceController,
              decoration: InputDecoration(labelText: 'Date de naissance'),
            ),
            TextField(
              controller: _delegationCommuPdcController,
              decoration: InputDecoration(labelText: 'Délégation Commune PDCI'),
            ),
            TextField(
              controller: _delegationDepartPdcController,
              decoration: InputDecoration(labelText: 'Délégation Département PDCI'),
            ),
            TextField(
              controller: _departementController,
              decoration: InputDecoration(labelText: 'Département'),
            ),
            TextField(
              controller: _devenirMembrePdcController,
              decoration: InputDecoration(labelText: 'Devenir membre PDCI'),
            ),
            TextField(
              controller: _districtController,
              decoration: InputDecoration(labelText: 'District'),
            ),
            TextField(
              controller: _etesVousDansAssociationController,
              decoration: InputDecoration(labelText: 'Êtes-vous dans une association'),
            ),
            TextField(
              controller: _etesVousIvoirienController,
              decoration: InputDecoration(labelText: 'Êtes-vous Ivoirien'),
            ),
            TextField(
              controller: _fonctionInAssociationController,
              decoration: InputDecoration(labelText: 'Fonction dans association'),
            ),
            TextField(
              controller: _fonctionOccupationController,
              decoration: InputDecoration(labelText: 'Fonction/Occupation'),
            ),
            TextField(
              controller: _genreController,
              decoration: InputDecoration(labelText: 'Genre'),
            ),
            TextField(
              controller: _lieuNaissanceController,
              decoration: InputDecoration(labelText: 'Lieu de naissance'),
            ),
            TextField(
              controller: _lieuResidenceController,
              decoration: InputDecoration(labelText: 'Lieu de résidence'),
            ),
            TextField(
              controller: _lieuTravailController,
              decoration: InputDecoration(labelText: 'Lieu de travail'),
            ),
            TextField(
              controller: _mailController,
              decoration: InputDecoration(labelText: 'Mail'),
            ),
            TextField(
              controller: _raisonNePasDevenirMembrePdcController,
              decoration: InputDecoration(labelText: 'Raison ne pas devenir membre PDCI'),
            ),
            TextField(
              controller: _refNaturalisationController,
              decoration: InputDecoration(labelText: 'Réf. Naturalisation'),
            ),
            TextField(
              controller: _regionController,
              decoration: InputDecoration(labelText: 'Région'),
            ),
            TextField(
              controller: _secteurActiviteController,
              decoration: InputDecoration(labelText: 'Secteur d\'activité'),
            ),
            TextField(
              controller: _sousprefectureController,
              decoration: InputDecoration(labelText: 'Sous-préfecture'),
            ),
            TextField(
              controller: _villageController,
              decoration: InputDecoration(labelText: 'Village'),
            ),
            SwitchListTile(
              title: Text('Ne connaît pas le programme'),
              value: _neConnaitPasProgramme,
              onChanged: (bool value) {
                setState(() {
                  _neConnaitPasProgramme = value;
                });
              },
            ),
            SwitchListTile(
              title: Text('Ne partage pas les idéaux'),
              value: _nePartagePasIdeaux,
              onChanged: (bool value) {
                setState(() {
                  _nePartagePasIdeaux = value;
                });
              },
            ),
            SwitchListTile(
              title: Text('Rester apolitique'),
              value: _resterAPolitique,
              onChanged: (bool value) {
                setState(() {
                  _resterAPolitique = value;
                });
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _updateData,
              child: Text('Enregistrer'),
            ),
          ],
        ),
      ),
    );
  }
}
