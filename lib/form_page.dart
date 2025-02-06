// lib/form_page.dart
// lib/form_page.dart
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'choix_inscrption.dart';
import 'package:url_launcher/url_launcher.dart';


class FormPage extends StatefulWidget {

  final String? itemId; // ID de l'item à modifier, null si création

  FormPage({this.itemId});

  @override
  _FormPageState createState() => _FormPageState();

}

class _FormPageState extends State<FormPage> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for the form fields
  final TextEditingController STR_DISTRICTController = TextEditingController();
  final TextEditingController STR_REGIONController = TextEditingController();
  final TextEditingController STR_DEPARTEMENTController = TextEditingController();
  final TextEditingController STR_SOUSPREFECTUREController = TextEditingController();
  //final TextEditingController STR_COMMUNEController = TextEditingController();
  final TextEditingController STR_VILLAGEController = TextEditingController();
  final TextEditingController STR_CAMPEMENTController = TextEditingController();
  final TextEditingController STR_REF_NATURALISATIONController = TextEditingController();
  final TextEditingController STR_ANNEE_NATURALISATIONController = TextEditingController();

  final TextEditingController STR_NOM_ASSOCIATIONController = TextEditingController();
  final TextEditingController STR_FONCTION_ASSOCIATIONController = TextEditingController();

  final TextEditingController dateController = TextEditingController();

  // New controllers
  final TextEditingController STR_PRENOMController = TextEditingController();
  final TextEditingController STR_NOMController = TextEditingController();
  final TextEditingController STR_LIEU_NAISSANCEController = TextEditingController();
  final TextEditingController STR_DATENAISSANCEController = TextEditingController();
  final TextEditingController STR_PHONE_PRINCIPALController = TextEditingController();
  final TextEditingController STR_PHONE_SECONDAIREController = TextEditingController();
  final TextEditingController STR_MAILController = TextEditingController();
  final TextEditingController STR_SECTEUR_ACTIVITEController = TextEditingController();
  final TextEditingController STR_FONCTION_OCCUPATIONController = TextEditingController();
  final TextEditingController STR_LIEU_TRAVAILController = TextEditingController();
  final TextEditingController fatherNameController = TextEditingController();
  final TextEditingController motherNameController = TextEditingController();
  final TextEditingController STR_LIEU_RESIDENCEController = TextEditingController();
  final TextEditingController STR_PERSONNE_A_CONTACTERController = TextEditingController();
  final TextEditingController STR_PHONE_PERSONNE_A_CONTACTERController = TextEditingController();



  final TextEditingController STR_NUMERO_PASSPORTController = TextEditingController();
  final TextEditingController STR_NUMERO_CNIController = TextEditingController();

  final TextEditingController participeScrutinController = TextEditingController();
  final TextEditingController inAssociationController = TextEditingController();
  final TextEditingController notInterestedReasonController = TextEditingController();
  final TextEditingController STR_RAISON_NE_PAS_DEVENIR_MEMBRE_PDCIController = TextEditingController();

  final TextEditingController lieuDeVoteController = TextEditingController();
  final TextEditingController bureauDeVoteController = TextEditingController();
  final TextEditingController reasonController = TextEditingController();
  final TextEditingController documentSupletifController = TextEditingController();
  final TextEditingController emergencyPhone2Controller = TextEditingController();
  final TextEditingController STR_PRECISION_AUTRES_SI_NON_ACTENAISSANCEController = TextEditingController();

  // Variables pour les checkboxes
  bool resterApolitique = false;
  bool neConnaitPasLeProgramme = false;
  bool nePartagePasLesIdeaux = false;
  bool STR_REQUISITION_SOUS_PREFECTUREController = false;
  bool STR_AUDIANCE_FORAINEController = false;
  bool STR_AUTRES_SI_NON_ACTENAISSANCEController = false;
  bool STR_DEVENIR_MEMBRE_PLUSTARDController = false;

  int? STR_GENREController;
  int? STR_ETES_VOUS_IVOIRIENController;
  int? STR_DISPOSEZ_VOUS_DOCUMENT_ADNINISTRATIVEController;
  int? STR_AVEZ_VOUS_UN_PASSPORTController;
  int? STR_AVEZ_VOUS_CNIController;
  int? STR_ETES_VOUS_DANS_UNE_ASSOCIATIONController;
  int? STR_PARTICIPE_ACTIVITE_POLITIQUEController;
  int? STR_ETESVOUS_MEMBRE_PARTIPOLITIQUEController;
  int? STR_DEVENIR_MEMBRE_PDCIController;

  // Controllers for new section
  final TextEditingController STR_COMITE_QUARTIERController = TextEditingController();
  final TextEditingController STR_COMITE_VILLAGEOISController = TextEditingController();

  final TextEditingController STR_DELEGATION_DEPARTE_PDCIController = TextEditingController();
  final TextEditingController STR_DELEGATION_COMMU_PDCIController = TextEditingController();
  String? STR_SECTION_PDCIController;
  String? STR_COMMUNEController;
  List<String> communeList = [];
  List<String> sectionList = [];


  //final user = FirebaseAuth.instance.currentUser;
  User? user = FirebaseAuth.instance.currentUser;

  bool _isSubmitted = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadCommuneData();
    _loadSectionPdciData();
    if (widget.itemId != null) {
      _loadData();
    }
  }


  /*Future<void> _loadCommuneData() async {
    setState(() {
      _isLoading = true;
    });
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('communes').get();
      setState(() {
        communeList = querySnapshot.docs.map((doc) {
          final data = doc.data() as Map<String, dynamic>;
          // Vérifier si le champ "name" existe et obtenir sa valeur
          if (data.containsKey('STR_COMMUNE')) {
            return data['STR_COMMUNE'] as String;
          } else {
            print('Document ${doc.id} does not contain the "name" field.');
            return 'Unknown'; // Valeur par défaut si le champ n'existe pas
          }
        }).toList();
        print("----------------communeList-----------");
        print(communeList);
      });
    } catch (e) {
      print('Error loading commune data: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }*/

  Future<void> _loadCommuneData() async {
    setState(() {
      _isLoading = true;
    });
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('communes').get();
      List<String> communes = querySnapshot.docs.map((doc) => doc['STR_COMMUNE'] as String).toList();

      // Trier la liste de communes de A à Z
      communes.sort();

      setState(() {
        communeList = communes;
      });
    } catch (e) {
      print('Error loading commune data: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }


  Future<void> _loadCommuneDetails(String commune) async {
    try {
      // Recherchez le document correspondant à la commune sélectionnée
      DocumentSnapshot docSnapshot = await FirebaseFirestore.instance
          .collection('communes')
          .where('STR_COMMUNE', isEqualTo: commune)
          .limit(1)
          .get()
          .then((snapshot) => snapshot.docs.first);

      // Mettez à jour les contrôleurs avec les données de la commune
      setState(() {
        STR_DEPARTEMENTController.text = docSnapshot['STR_DEPARTEMENT'] ?? '';
        STR_DISTRICTController.text = docSnapshot['STR_DISTRICT'] ?? '';
        STR_REGIONController.text = docSnapshot['STR_REGION'] ?? '';
        STR_SOUSPREFECTUREController.text = docSnapshot['STR_SOUSPREFECTURE'] ?? '';
      });
    } catch (e) {
      print('Error loading commune details: $e');
    }
  }


  Future<void> _loadSectionPdciData() async {
    setState(() {
      _isLoading = true;
    });
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('section_pdci').get();
      List<String> section = querySnapshot.docs.map((doc) => doc['STR_SECTION_PDCI'] as String).toList();

      setState(() {
        sectionList = section;
      });
    } catch (e) {
      print('Error loading commune data: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }


  Future<void> _loadSectionPdciDetails(String section) async {
    try {
      // Recherchez le document correspondant à la commune sélectionnée
      DocumentSnapshot docSnapshot = await FirebaseFirestore.instance
          .collection('section_pdci')
          .where('STR_SECTION_PDCI', isEqualTo: section)
          .limit(1)
          .get()
          .then((snapshot) => snapshot.docs.first);

      // Mettez à jour les contrôleurs avec les données de la commune
      setState(() {
        STR_DELEGATION_DEPARTE_PDCIController.text = docSnapshot['STR_DELEGATION_DEPARTE_PDCI'] ?? '';
        STR_DELEGATION_COMMU_PDCIController.text = docSnapshot['STR_DELEGATION_COMMU_PDCI'] ?? '';
      });
    } catch (e) {
      print('Error loading commune details: $e');
    }
  }




  Future<void> _loadData() async {
    setState(() {
      _isLoading = true;
    });
    try {
      DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user?.uid)
          .collection('form_data')
          .doc(widget.itemId)
          .get();

      if (doc.exists) {
        var data = doc.data() as Map<String, dynamic>;

        STR_VILLAGEController.text = data['STR_VILLAGE'] ?? '';
        STR_CAMPEMENTController.text = data['STR_CAMPEMENT'] ?? '';
        STR_NOMController.text = data['STR_NOM'] ?? '';
        STR_PRENOMController.text = data['STR_PRENOM'] ?? '';
        STR_LIEU_NAISSANCEController.text = data['STR_LIEU_NAISSANCE'] ?? '';
        STR_DATENAISSANCEController.text = data['STR_DATENAISSANCE'] ?? '';
        STR_PHONE_PRINCIPALController.text = data['STR_PHONE_PRINCIPAL'] ?? '';
        STR_PHONE_SECONDAIREController.text = data['STR_PHONE_SECONDAIRE'] ?? '';

        STR_MAILController.text = data['STR_MAIL'] ?? '';
        STR_SECTEUR_ACTIVITEController.text = data['STR_SECTEUR_ACTIVITE'] ?? '';
        STR_FONCTION_OCCUPATIONController.text = data['STR_FONCTION_OCCUPATION'] ?? '';
        STR_LIEU_TRAVAILController.text = data['STR_LIEU_TRAVAIL'] ?? '';

        STR_LIEU_RESIDENCEController.text = data['STR_LIEU_RESIDENCE'] ?? '';
        STR_PERSONNE_A_CONTACTERController.text = data['STR_PERSONNE_A_CONTACTER'] ?? '';
        STR_PHONE_PERSONNE_A_CONTACTERController.text = data['STR_PHONE_PERSONNE_A_CONTACTER'] ?? '';

        STR_MAILController.text = data['STR_MAIL'] ?? '';

        if(data['STR_COMMUNE'] != null){
          STR_COMMUNEController = data['STR_COMMUNE'] ?? '';
        }
        // Load other variables similarly

        STR_DISTRICTController.text = data['STR_DISTRICT'] ?? '';
        STR_REGIONController.text = data['STR_REGION'] ?? '';
        STR_DEPARTEMENTController.text = data['STR_DEPARTEMENT'] ?? '';
        STR_SOUSPREFECTUREController.text = data['STR_SOUSPREFECTURE'] ?? '';
        STR_VILLAGEController.text = data['STR_VILLAGE'] ?? '';
        STR_CAMPEMENTController.text = data['STR_CAMPEMENT'] ?? '';

        STR_NOM_ASSOCIATIONController.text = data['STR_NOM_ASSOCIATION'] ?? '';
        STR_FONCTION_ASSOCIATIONController.text = data['STR_FONCTION_IN_ASSOCIATION'] ?? '';

        STR_REF_NATURALISATIONController.text = data['STR_REF_NATURALISATION'] ?? '';
        STR_ANNEE_NATURALISATIONController.text = data['STR_ANNEENATURALISATION'] ?? '';

        STR_NUMERO_PASSPORTController.text = data['STR_NUMERO_PASSPORT'] ?? '';

        STR_NUMERO_CNIController.text = data['STR_NUMERO_CNI'] ?? '';

        /*STR_AVEZ_VOUS_UN_PASSPORTController = (data['STR_AVEZ_VOUS_UN_PASSPORT'] == 'Oui' ? 0 : 1);
        STR_GENREController = (data['STR_GENRE'] == 'Masculin' ? 0 : 1);
        STR_ETES_VOUS_IVOIRIENController = (data['STR_ETES_VOUS_IVOIRIEN'] == 'Oui' ? 0 : 1);
        STR_AVEZ_VOUS_CNIController  = (data['STR_AVEZ_VOUS_CNI'] == 'Oui' ? 0 : 1);
        STR_ETES_VOUS_DANS_UNE_ASSOCIATIONController  = (data['STR_ETES_VOUS_DANS_UNE_ASSOCIATION'] == 'Oui' ? 0 : 1);
        STR_PARTICIPE_ACTIVITE_POLITIQUEController =(data['STR_PARTICIPE_ACTIVITE_POLITIQUE'] == 'Oui' ? 0 : 1);
        STR_DEVENIR_MEMBRE_PDCIController = (data['STR_DEVENIR_MEMBRE_PDCI'] == 'Oui' ? 0 : 1);
        STR_ETESVOUS_MEMBRE_PARTIPOLITIQUEController = (data['STR_ETESVOUS_MEMBRE_PARTIPOLITIQUE'] == 'Oui' ? 0 : 1);*/

        STR_AVEZ_VOUS_UN_PASSPORTController = (data['STR_AVEZ_VOUS_UN_PASSPORT'] == null || data['STR_AVEZ_VOUS_UN_PASSPORT'].isEmpty)
            ? null
            : (data['STR_AVEZ_VOUS_UN_PASSPORT'] == 'Oui' ? 0 : 1);

        STR_GENREController = (data['STR_GENRE'] == null || data['STR_GENRE'].isEmpty)
            ? null
            : (data['STR_GENRE'] == 'Masculin' ? 0 : 1);

        STR_ETES_VOUS_IVOIRIENController = (data['STR_ETES_VOUS_IVOIRIEN'] == null || data['STR_ETES_VOUS_IVOIRIEN'].isEmpty)
            ? null
            : (data['STR_ETES_VOUS_IVOIRIEN'] == 'Oui' ? 0 : 1);

        STR_AVEZ_VOUS_CNIController = (data['STR_AVEZ_VOUS_CNI'] == null || data['STR_AVEZ_VOUS_CNI'].isEmpty)
            ? null
            : (data['STR_AVEZ_VOUS_CNI'] == 'Oui' ? 0 : 1);

        STR_ETES_VOUS_DANS_UNE_ASSOCIATIONController = (data['STR_ETES_VOUS_DANS_UNE_ASSOCIATION'] == null || data['STR_ETES_VOUS_DANS_UNE_ASSOCIATION'].isEmpty)
            ? null
            : (data['STR_ETES_VOUS_DANS_UNE_ASSOCIATION'] == 'Oui' ? 0 : 1);

        STR_PARTICIPE_ACTIVITE_POLITIQUEController = (data['STR_PARTICIPE_ACTIVITE_POLITIQUE'] == null || data['STR_PARTICIPE_ACTIVITE_POLITIQUE'].isEmpty)
            ? null
            : (data['STR_PARTICIPE_ACTIVITE_POLITIQUE'] == 'Oui' ? 0 : 1);

        STR_DEVENIR_MEMBRE_PDCIController = (data['STR_DEVENIR_MEMBRE_PDCI'] == null || data['STR_DEVENIR_MEMBRE_PDCI'].isEmpty)
            ? null
            : (data['STR_DEVENIR_MEMBRE_PDCI'] == 'Oui' ? 0 : 1);

        STR_ETESVOUS_MEMBRE_PARTIPOLITIQUEController = (data['STR_ETESVOUS_MEMBRE_PARTIPOLITIQUE'] == null || data['STR_ETESVOUS_MEMBRE_PARTIPOLITIQUE'].isEmpty)
            ? null
            : (data['STR_ETESVOUS_MEMBRE_PARTIPOLITIQUE'] == 'Oui' ? 0 : 1);

        //STR_DISPOSEZ_VOUS_DOCUMENT_ADNINISTRATIVEController  = (data['STR_DISPOSEZ_VOUS_DOCUMENT_ADNINISTRATIVE'] == 'Oui' ? 0 : 1);
        if (data['STR_DISPOSEZ_VOUS_DOCUMENT_ADNINISTRATIVE'] == null || data['STR_DISPOSEZ_VOUS_DOCUMENT_ADNINISTRATIVE'].isEmpty) {
          STR_DISPOSEZ_VOUS_DOCUMENT_ADNINISTRATIVEController = null; // Valeur vide si null ou vide
        } else {
          STR_DISPOSEZ_VOUS_DOCUMENT_ADNINISTRATIVEController = (data['STR_DISPOSEZ_VOUS_DOCUMENT_ADNINISTRATIVE'] == 'Oui' ? 0 : 1);
        }

        STR_REQUISITION_SOUS_PREFECTUREController = (data['STR_REQUISITION_SOUS_PREFECTURE']);
        STR_AUDIANCE_FORAINEController = (data['STR_AUDIANCE_FORAINE']);
        STR_DEVENIR_MEMBRE_PLUSTARDController = (data['STR_DEVENIR_MEMBRE_PLUSTARD']);
        STR_AUTRES_SI_NON_ACTENAISSANCEController = (data['STR_AUTRES_SI_NON_ACTENAISSANCE']);
        STR_PRECISION_AUTRES_SI_NON_ACTENAISSANCEController.text = data['STR_PRECISION_AUTRES_SI_NON_ACTENAISSANCE'] ?? '';

        resterApolitique = (data['STR_RESTERAPOLITIQUE']);
        neConnaitPasLeProgramme = (data['STR_NE_CONNAIT_PAS_PROGRAMME']);
        nePartagePasLesIdeaux = (data['STR_NE_PARTAGE_PAS_IDEAUX']);
        STR_RAISON_NE_PAS_DEVENIR_MEMBRE_PDCIController.text = data['STR_RAISON_NE_PAS_DEVENIR_MEMBRE_PDCI'] ?? '';

        STR_DELEGATION_DEPARTE_PDCIController.text = data['STR_DELEGATION_DEPARTE_PDCI'] ?? '';
        STR_DELEGATION_COMMU_PDCIController.text = data['STR_DELEGATION_COMMU_PDCI'] ?? '';

        if(data['STR_SECTION_PDCI'] != null){
          STR_SECTION_PDCIController = data['STR_SECTION_PDCI'] ?? '';
        }


        STR_COMITE_QUARTIERController.text = data['STR_COMITE_QUARTIER'] ?? '';
        STR_COMITE_VILLAGEOISController.text = data['STR_COMITE_VILLAGEOIS'] ?? '';







/*

    'STR_NOM': STR_NOMController.text,
    'STR_GENRE': STR_GENREGenre,
    'STR_PRENOM': STR_PRENOMController.text,
    'STR_LIEU_NAISSANCE': STR_LIEU_NAISSANCEController.text,
    'STR_DATENAISSANCE': STR_DATENAISSANCEController.text,
    'STR_PHONE_PRINCIPAL': STR_PHONE_PRINCIPALController.text,
    'STR_PHONE_SECONDAIRE': STR_PHONE_SECONDAIREController.text,
    'STR_MAIL': STR_MAILController.text,
    'STR_SECTEUR_ACTIVITE': STR_SECTEUR_ACTIVITEController.text,
    'STR_FONCTION_OCCUPATION': STR_FONCTION_OCCUPATIONController.text,
    'STR_LIEU_TRAVAIL': STR_LIEU_TRAVAILController.text,

    'STR_LIEU_RESIDENCE': STR_LIEU_RESIDENCEController.text,
    'STR_PERSONNE_A_CONTACTER': STR_PERSONNE_A_CONTACTERController.text,
    'STR_PHONE_PERSONNE_A_CONTACTER': STR_PHONE_PERSONNE_A_CONTACTERController.text,

    'STR_NOM_ASSOCIATION': STR_NOM_ASSOCIATIONController.text,
    'STR_FONCTION_IN_ASSOCIATION': STR_FONCTION_ASSOCIATIONController.text,

    'STR_ETES_VOUS_IVOIRIENController': STR_ETES_VOUS_IVOIRIENController,
    'STR_ETES_VOUS_IVOIRIEN': STR_ETES_VOUS_IVOIRIENController == 1 ? 'Oui' : 'Non',
    'STR_REF_NATURALISATION': STR_REF_NATURALISATIONController.text,
    'STR_ANNEENATURALISATION': STR_ANNEE_NATURALISATIONController.text,

    'STR_AVEZ_VOUS_UN_PASSPORT': STR_AVEZ_VOUS_UN_PASSPORTController  == 1 ? 'Oui' : 'Non',
    'STR_NUMERO_PASSPORT': STR_NUMERO_PASSPORTController.text,
    'STR_AVEZ_VOUS_CNI': STR_AVEZ_VOUS_CNIController  == 1 ? 'Oui' : 'Non',
    'STR_NUMERO_CNI': STR_NUMERO_CNIController.text,

    'STR_ETES_VOUS_DANS_UNE_ASSOCIATION': STR_ETES_VOUS_DANS_UNE_ASSOCIATIONController == 0 ? 'Oui' : 'Non',
    'STR_PARTICIPE_ACTIVITE_POLITIQUE': STR_PARTICIPE_ACTIVITE_POLITIQUEController == 0 ? 'Oui' : 'Non',
    'STR_DEVENIR_MEMBRE_PDCI': STR_DEVENIR_MEMBRE_PDCIController == 0 ? 'Oui' : 'Non',
    'STR_RESTERAPOLITIQUE': resterApolitique,
    'STR_NE_CONNAIT_PAS_PROGRAMME': neConnaitPasLeProgramme,
    'STR_NE_PARTAGE_PAS_IDEAUX': nePartagePasLesIdeaux,
    'STR_RAISON_NE_PAS_DEVENIR_MEMBRE_PDCI': STR_RAISON_NE_PAS_DEVENIR_MEMBRE_PDCIController.text,

    'STR_DELEGATION_DEPARTE_PDCI': STR_DELEGATION_DEPARTE_PDCIController,
    'STR_DELEGATION_COMMU_PDCI': STR_DELEGATION_COMMU_PDCIController,
    'STR_SECTION_PDCI': STR_SECTION_PDCIController,
    'STR_COMITE_QUARTIER': STR_COMITE_QUARTIERController.text,
    'STR_COMITE_VILLAGEOIS': STR_COMITE_VILLAGEOISController.text,*/
      }
    } catch (e) {
      // Handle errors if any
      print('Error loading data: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('inscription',
          style: TextStyle(color: Colors.white),
        ),

        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            //Navigator.pop(context);
            // Check if the user is signed in
            User? user = FirebaseAuth.instance.currentUser;

            if (user != null) {
              print("je suis connecté");
              // User is signed in, navigate to a different page
              //Navigator.pop(context);
              Navigator.of(context).pushReplacementNamed('/dashboard');
              /*Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => YourRedirectPage()),
              );*/
            } else {
              // User is not signed in, just pop the page
              print("je ne suis pas connecté");
              Navigator.of(context).pushReplacementNamed('/choixinscription');

            }
          },
        ),
        backgroundColor: Color(0xFF007D3C),

      ),

      backgroundColor: Colors.white,
      body : Stack(
        children: [
          Container(
            height: 120,
            color: const Color(0xFF007D3C),

          ),

          SingleChildScrollView(
            padding: const EdgeInsets.all(2.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (user == null)
                const Padding(
                  padding: EdgeInsets.fromLTRB(40, 20, 40, 0),
                  child: Column(
                    children: [
                      Text(
                        'Inscrivez-vous directement dans la base de donnée du Pdci-Rda, pour vous faire aider.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                        ),
                      ),

                    ],
                  ),
                ),


                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      //UTILISATEUR CONNECTE

                      if (user != null)
                        CustomCard(
                          title: 'Localité de recensement',
                          iconWidget: Image.asset(
                            'assets/images/carte-ci.png',
                            height: 16.0,
                            width: 16.0,
                          ),
                          backgroundColor: Colors.white,
                          textColor: Colors.black,
                        ),

                      if (user != null)
                      //UTILISATEUR NON CONNECTE
                      Container(
                          width: double.infinity, // This makes the card take the full width of the screen
                          margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 0.0), // Remove horizontal margin
                          child: Card(
                            elevation: 4,
                            color: Colors.white,  // Changer la couleur de fond
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16.0),  // Personnaliser l'arrondi des angles
                            ),
                            shadowColor: Colors.black.withOpacity(0.2), // Diminish the shadow opacity here
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [

                                  Row(
                                    children: [

                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(0.0),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: CustomDropdownButtonFormField(
                                                      value: STR_COMMUNEController,
                                                      items: communeList,
                                                      labelText: 'Commune *',
                                                      /*onChanged: (value) {
                                                        setState(() {
                                                          STR_COMMUNEController = value;
                                                        });
                                                      },*/

                                                      onChanged: (value) async {
                                                        setState(() {
                                                          STR_COMMUNEController = value;
                                                        });
                                                        if (value != null) {
                                                          // Chargez les détails de la commune sélectionnée
                                                          await _loadCommuneDetails(value);
                                                        }
                                                      },
                                                      validator: (value) {
                                                        if (value == null || value.isEmpty) {
                                                          return 'Ce champ est obligatoire';
                                                        }
                                                        return null;
                                                      },
                                                    ),
                                                  ),

                                                ],
                                              ),
                                              const SizedBox(height: 10),

                                              Visibility(
                                                visible: STR_COMMUNEController != null,
                                                child: Column(
                                                  children: [

                                                    Row(
                                                      children: [
                                                        Expanded(
                                                          child: CustomTextField(
                                                            labelText: 'District',
                                                            controller: STR_DISTRICTController,
                                                          ),
                                                        ),
                                                        const SizedBox(width: 10),
                                                        Expanded(
                                                          child: CustomTextField(
                                                            labelText: 'Région',
                                                            controller: STR_REGIONController,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(height: 10),

                                                    Row(
                                                      children: [
                                                        Expanded(
                                                          child: CustomTextField(
                                                            labelText: 'Département',
                                                            controller: STR_DEPARTEMENTController,
                                                          ),
                                                        ),
                                                        const SizedBox(width: 10),
                                                        Expanded(
                                                          child: CustomTextField(
                                                            labelText: 'Sous-préfecture',
                                                            controller: STR_SOUSPREFECTUREController,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(height: 10),

                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),

                                      ),
                                    ],
                                  ),


                                  Row(
                                    children: [
                                      Expanded(
                                        child: CustomTextField(
                                          labelText: 'Campement',
                                          controller: STR_CAMPEMENTController,
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        child: CustomTextField(
                                          labelText: 'Quartier',
                                          controller: STR_CAMPEMENTController,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                ],
                              ),
                            ),
                          ),
                        ),

                      CustomCard(
                        title: 'Informations personnelles',
                        iconWidget: Image.asset(
                          'assets/images/user.png',
                          height: 16.0,
                          width: 16.0,
                        ),
                        backgroundColor: Colors.white,
                        textColor: Colors.black,
                      ),


                      Container(
                        width: double.infinity,
                        margin: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
                        child: Card(
                          elevation: 4,
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          shadowColor: Colors.black.withOpacity(0.2),

                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                const Text.rich(
                                  textAlign: TextAlign.center,
                                  TextSpan(
                                    text: 'Veuillez sélectionner un genre. ',
                                    style: TextStyle(fontSize: 12.0), // Réduction de la taille du texte
                                    children: [
                                      TextSpan(
                                        text: '*',
                                        style: TextStyle(
                                          color: Colors.black, // Couleur rouge pour l'astérisque
                                          fontSize: 14.0, // Assurez-vous que l'astérisque est de la même taille que le texte
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                Row(
                                  children: [

                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [

                                          GenreQuestion(
                                            mycolor : const Color(0xFF007D3C),
                                            options: ['Masculin', 'Feminin'],
                                            selectedOption: STR_GENREController,
                                            onChanged: (int? value) {
                                              setState(() {
                                                STR_GENREController = value;
                                              });
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                if (_isSubmitted && STR_GENREController == null)
                                  const Text(
                                    'Veuillez sélectionner un genre.',
                                    style: TextStyle(color: Colors.red),
                                  ),

                                const SizedBox(height: 10),

                                Row(
                                  children: [
                                    Expanded(
                                      child: CustomTextField(
                                        labelText: 'Nom',
                                        controller: STR_NOMController,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Veuillez renseigner votre nom';
                                          }
                                          return null;
                                        },
                                        requiredIndicator: true,
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: CustomTextField(
                                        labelText: 'Prénom(s)',
                                        controller: STR_PRENOMController,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Veuillez renseigner votre prénom';
                                          }
                                          return null;
                                        },
                                        requiredIndicator: true,
                                      ),
                                    ),
                                  ],
                                ),

                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    Expanded(
                                      child: CustomTextField(
                                        labelText: 'Lieu de naissance',
                                        controller: STR_LIEU_NAISSANCEController,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Veuillez renseigner votre lieu de naissance';
                                          }
                                          return null;
                                        },
                                        requiredIndicator: true,
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    SizedBox(height: 16),

                                    Expanded(
                                      child: CustomDatePicker(
                                        controller: STR_DATENAISSANCEController,
                                        labelText: 'Date naissance',
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Veuillez renseigner votre date de naissance';
                                          }
                                          return null;
                                        },
                                        requiredIndicator: true,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  children: [

                                    Expanded(
                                      child: CustomPhoneNumberField(
                                        controller: STR_PHONE_PRINCIPALController,
                                        labelText: 'N° téléphone principale',
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Veuillez entrer votre numéro de téléphone';
                                          }
                                          return null;
                                        },
                                        requiredIndicator: true,
                                      ),
                                    ),


                                    const SizedBox(width: 10),

                                    Expanded(
                                      child: CustomPhoneNumberField(
                                        controller: STR_PHONE_SECONDAIREController,
                                        labelText: 'N°Téléphone secondaire',

                                      ),
                                    ),
                                    /*Expanded(
                                      child: CustomTextField(
                                        labelText: 'N°Téléphone secondaire',
                                        controller: STR_PHONE_SECONDAIREController,
                                      ),
                                    ),*/
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    Expanded(
                                      child: CustomTextField(
                                        labelText: 'E-mail',
                                        controller: STR_MAILController,
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: CustomTextField(
                                        labelText: 'Secteur d\'activité',
                                        controller: STR_SECTEUR_ACTIVITEController,
                                      ),
                                    ),
                                  ],
                                ),

                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    Expanded(
                                      child: CustomTextField(
                                        labelText: 'Fonction/occupation',
                                        controller: STR_FONCTION_OCCUPATIONController,
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: CustomTextField(
                                        labelText: 'Lieu de travail',
                                        controller: STR_LIEU_TRAVAILController,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    Expanded(
                                      child: CustomTextField(
                                        labelText: 'Lieu de résidence habituelle',
                                        controller: STR_LIEU_RESIDENCEController,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Veuillez entrer votre lieu de résidence habituelle';
                                          }
                                          return null;
                                        },
                                        requiredIndicator: true,
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: CustomTextField(
                                        labelText: 'Personne à contacter en cas d’urgence',
                                        controller: STR_PERSONNE_A_CONTACTERController,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    Expanded(
                                      child: CustomPhoneNumberField(
                                        controller: STR_PHONE_PERSONNE_A_CONTACTERController,
                                        labelText: 'Téléphone personne à contacter',
                                      ),
                                    ),
                                    /*Expanded(
                                      child: CustomTextField(
                                        labelText: 'Téléphone personne à contacter',
                                        controller: STR_PHONE_PERSONNE_A_CONTACTERController,
                                      ),
                                    ),*/

                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),


                      CustomCard(
                        title: 'Documentations et inscription sur la liste electorale',
                        iconWidget: Image.asset(
                          'assets/images/document.png',
                          height: 16.0,
                          width: 16.0,
                        ),
                        backgroundColor: Color(0xFF007D3C),
                        textColor: Colors.white,
                      ),

                      Container(
                        width: double.infinity,
                        margin: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
                        child: Card(
                          elevation: 4,
                          color: const Color(0xFFE7F2E9),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          shadowColor: Colors.black.withOpacity(0.2),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                buildQuestion(
                                  questionNumber: 1,
                                  mycolor: const Color(0xFF007D3C),
                                  questionText: 'Etes-vous ivoirien d\'adoption?',
                                  options: ['Oui', 'Non'],
                                  selectedOption: STR_ETES_VOUS_IVOIRIENController,
                                  onChanged: (int? value) {
                                    setState(() {
                                      STR_ETES_VOUS_IVOIRIENController = value;
                                    });
                                  },

                                ),

                                if (STR_ETES_VOUS_IVOIRIENController == 0) ...[
                                  const SizedBox(height: 10),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: CustomTextField(
                                          labelText: 'Ref. acte de naturalisation',
                                          controller: STR_REF_NATURALISATIONController,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: CustomTextField(
                                          labelText: 'Année de naturalisation',
                                          controller: STR_ANNEE_NATURALISATIONController,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],

                                const SizedBox(height: 10),

                                buildQuestion(
                                  questionNumber: 2,
                                  mycolor: const Color(0xFF007D3C),
                                  questionText: 'Disposez-vous une pièce d\’identité valide ? ',
                                  options: ['Oui', 'Non'],
                                  selectedOption: STR_DISPOSEZ_VOUS_DOCUMENT_ADNINISTRATIVEController,
                                  onChanged: (int? value) {
                                    setState(() {
                                      STR_DISPOSEZ_VOUS_DOCUMENT_ADNINISTRATIVEController = value;
                                    });
                                  },

                                ),


                              if (STR_DISPOSEZ_VOUS_DOCUMENT_ADNINISTRATIVEController == 1) ...[

                                  const Padding(
                                    padding: EdgeInsets.symmetric(vertical: 8.0),
                                    child: Text(
                                      'De quel(s) document(s) administratif(s) disposez-vous ?',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontStyle: FontStyle.italic),
                                    ),
                                  ),

                                Row(
                                  children: [
                                    Checkbox(
                                      value: STR_AUDIANCE_FORAINEController,
                                      onChanged: (bool? value) {
                                        setState(() {
                                          STR_AUDIANCE_FORAINEController = value!;
                                        });
                                      },
                                      activeColor: Colors.green,
                                      checkColor: Colors.white,
                                    ),
                                    Text('Aux audiciences foraines'),

                                    Spacer(),
                                  ],
                                ),

                                Row(
                                  children: [
                                    Checkbox(
                                      value: STR_REQUISITION_SOUS_PREFECTUREController,
                                      onChanged: (bool? value) {
                                        setState(() {
                                          STR_REQUISITION_SOUS_PREFECTUREController = value!;
                                        });
                                      },
                                      activeColor: Colors.green,
                                      checkColor: Colors.white,
                                    ),
                                    Text('Extrait d’acte de naissance'),
                                    Spacer(),

                                  ],
                                ),
                                Row(
                                  children: [
                                    Checkbox(
                                      value: STR_AUTRES_SI_NON_ACTENAISSANCEController,
                                      onChanged: (bool? value) {
                                        setState(() {
                                          STR_AUTRES_SI_NON_ACTENAISSANCEController = value!;
                                        });
                                      },
                                      activeColor: Colors.green,
                                      checkColor: Colors.white,
                                    ),
                                    Text('Autres'),
                                    Spacer(),

                                  ],
                                ),

                                if (STR_AUTRES_SI_NON_ACTENAISSANCEController == true) ...[

                                  const SizedBox(height: 10),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: CustomTextField(
                                          labelText: 'Préciser le nom',
                                          controller: STR_PRECISION_AUTRES_SI_NON_ACTENAISSANCEController,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],


                                  const SizedBox(height: 10),

                                ],


                              if (STR_DISPOSEZ_VOUS_DOCUMENT_ADNINISTRATIVEController == 0) ...[

                                const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 8.0),
                                  child: Text(
                                    'De quel(s) document(s) administratif(s) disposez-vous ?',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontStyle: FontStyle.italic),
                                  ),
                                ),


                                const SizedBox(height: 10),
                                buildQuestion(
                                  questionNumber: 3,
                                  mycolor: const Color(0xFF007D3C),
                                  questionText: 'Un Passeport ?',
                                  options: ['Oui', 'Non'],
                                  selectedOption: STR_AVEZ_VOUS_UN_PASSPORTController,
                                  onChanged: (int? value) {
                                    setState(() {
                                      STR_AVEZ_VOUS_UN_PASSPORTController = value;
                                    });
                                  },
                                ),

                                if (STR_AVEZ_VOUS_UN_PASSPORTController == 0) ...[
                                  const SizedBox(height: 10),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: CustomTextField(
                                          labelText: 'Préciser le numéro',
                                          controller: STR_NUMERO_PASSPORTController,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],

                                const SizedBox(height: 10),
                                buildQuestion(
                                  questionNumber: 4,
                                  mycolor: const Color(0xFF007D3C),
                                  questionText: 'Une CNI ou d\'un Récépissé de CNI ?',
                                  options: ['Oui', 'Non'],
                                  selectedOption: STR_AVEZ_VOUS_CNIController,
                                  onChanged: (int? value) {
                                    setState(() {
                                      STR_AVEZ_VOUS_CNIController = value;
                                    });
                                  },
                                ),

                                if (STR_AVEZ_VOUS_CNIController == 0) ...[
                                  const SizedBox(height: 10),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: CustomTextField(
                                          labelText: 'Renseigner le numéro',
                                          controller: STR_NUMERO_CNIController,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                                const SizedBox(height: 10),
                              ],
                              ],
                            ),

                          ),
                        ),
                      ),


                      CustomCard(
                        title: 'Activites sociales et politiques',
                        iconWidget: Image.asset(
                          'assets/images/activite-sociale.png',
                          height: 16.0,
                          width: 16.0,
                        ),
                        backgroundColor:  Color(0xFFe4fb7c), //Color(0xFFCC9B21),
                        textColor: Colors.black,
                      ),



                      // Second additional form section
                      Container(
                        width: double.infinity,
                        margin: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
                        child: Card(
                          elevation: 4,
                          color: const Color(0xFFfaffdc),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          shadowColor: Colors.black.withOpacity(0.2),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 10),
                                buildQuestion(
                                  questionNumber: 1,
                                  mycolor : const Color(0xFF99af17),
                                  questionText: 'Etes-vous dans une Association ?',
                                  options: ['Oui', 'Non'],
                                  selectedOption: STR_ETES_VOUS_DANS_UNE_ASSOCIATIONController,
                                  onChanged: (int? value) {
                                    setState(() {
                                      STR_ETES_VOUS_DANS_UNE_ASSOCIATIONController = value;
                                    });
                                  },
                                ),

                                if (STR_ETES_VOUS_DANS_UNE_ASSOCIATIONController == 0) ...[

                                  const SizedBox(height: 10),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: CustomTextField(
                                          labelText: 'Préciser le nom',
                                          controller: STR_NOM_ASSOCIATIONController,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],


                                if (STR_ETES_VOUS_DANS_UNE_ASSOCIATIONController == 0) ...[
                                  const SizedBox(height: 10),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: CustomTextField(
                                          labelText: 'Fonction occupée',
                                          controller: STR_FONCTION_ASSOCIATIONController,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                                const SizedBox(height: 10),
                                buildQuestion(
                                  questionNumber: 2,
                                  mycolor : const Color(0xFF99af17),
                                  questionText: 'Participez-vous à des activités politiques?',
                                  options: ['Oui', 'Non'],
                                  selectedOption: STR_PARTICIPE_ACTIVITE_POLITIQUEController,
                                  onChanged: (int? value) {
                                    setState(() {
                                      STR_PARTICIPE_ACTIVITE_POLITIQUEController = value;
                                    });
                                  },
                                ),
                                const SizedBox(height: 10),
                                buildQuestion(
                                  questionNumber: 3,
                                  mycolor : const Color(0xFF99af17),
                                  questionText: 'Etes-vous un membre d’un parti politique?',
                                  options: ['Oui', 'Non'],
                                  selectedOption: STR_ETESVOUS_MEMBRE_PARTIPOLITIQUEController,
                                  onChanged: (int? value) {
                                    setState(() {
                                      STR_ETESVOUS_MEMBRE_PARTIPOLITIQUEController = value;
                                    });
                                  },
                                ),
                                const SizedBox(height: 10),
                                buildQuestion(
                                  questionNumber: 4,
                                  mycolor : const Color(0xFF99af17),
                                  questionText: 'Souhaitez-vous devenir membre du PDCI RDA?',
                                  options: ['Oui', 'Non'],
                                  selectedOption: STR_DEVENIR_MEMBRE_PDCIController,
                                  onChanged: (int? value) {
                                    setState(() {
                                      STR_DEVENIR_MEMBRE_PDCIController = value;
                                    });
                                  },
                                ),

                                if (STR_DEVENIR_MEMBRE_PDCIController == 0) ...[

                                  Row(
                                    children: [
                                      Checkbox(
                                        value: STR_DEVENIR_MEMBRE_PLUSTARDController,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            STR_DEVENIR_MEMBRE_PLUSTARDController = value!;
                                          });
                                        },
                                        activeColor: Colors.green,
                                        checkColor: Colors.white,
                                      ),
                                      Text('Mais plutard'),

                                      Spacer(),

                                      Row(
                                        children: [
                                          const Text(
                                            "Je m'inscris ",
                                            style: TextStyle(
                                              fontSize: 13.0,
                                              color: Colors.black,
                                            ),
                                          ),
                                          ElevatedButton(
                                            onPressed: () async {
                                              const url = 'https://adhesion.pdcirda.ci/bienvenue'; // Remplacez par l'URL de votre site
                                              if (await canLaunch(url)) {
                                                await launch(url);
                                              } else {
                                                throw 'Could not launch $url';
                                              }
                                            },
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: const Color(0xFF007D3C),
                                              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(8),
                                              ),
                                              minimumSize: Size(30, 30),
                                              elevation: 0,
                                            ),
                                            child: const Text(
                                              "Maintenant ",
                                              style: TextStyle(
                                                fontSize: 13.0,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),

                                  // Checkbox pour "Ne connait pas le programme de société du Parti"

                                  /*Row(
                                    children: [

                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(0.0),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              const Padding(
                                                padding: EdgeInsets.symmetric(vertical: 0.0),
                                                child: Text(
                                                  'A quelle section souhaitez-vous appartenir?',
                                                  //style: TextStyle(fontStyle: FontStyle.italic),
                                                ),
                                              ),
                                              const SizedBox(height: 10),
                                              Row(
                                                children: [

                                                  Expanded(
                                                    child: Padding(
                                                      padding: const EdgeInsets.all(0.0),
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,

                                                        children: [
                                                          Row(
                                                            children: [
                                                              Expanded(
                                                                child: CustomDropdownButtonFormField(
                                                                  value: STR_SECTION_PDCIController,
                                                                  items: sectionList,
                                                                  labelText: 'Section pdci',
                                                                  onChanged: (value) async {
                                                                    setState(() {
                                                                      STR_SECTION_PDCIController = value;
                                                                    });
                                                                    if (value != null) {
                                                                      // Chargez les détails de la commune sélectionnée
                                                                      await _loadSectionPdciDetails(value);
                                                                    }
                                                                  },

                                                                ),
                                                              ),

                                                            ],
                                                          ),
                                                          const SizedBox(height: 10),

                                                          Visibility(
                                                            visible: STR_SECTION_PDCIController != null,
                                                            child: Column(
                                                              children: [

                                                                Row(
                                                                  children: [
                                                                    Expanded(
                                                                      child: CustomTextField(
                                                                        labelText: 'Délégation départementale',
                                                                        controller: STR_DELEGATION_DEPARTE_PDCIController,
                                                                      ),
                                                                    ),
                                                                    const SizedBox(width: 10),
                                                                    Expanded(
                                                                      child: CustomTextField(
                                                                        labelText: 'Délégation régionale',
                                                                        controller: STR_DELEGATION_COMMU_PDCIController,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),

                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 10),
                                            ],
                                          ),
                                        ),

                                      ),
                                    ],
                                  ),



                                  Row(
                                    children: [
                                      Expanded(
                                        child: CustomTextField(
                                          labelText: 'Comité de quartier',
                                          controller: STR_COMITE_QUARTIERController,
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      SizedBox(height: 16),

                                      Expanded(
                                        child: CustomTextField(
                                          labelText: 'Comité de vilage',
                                          controller: STR_COMITE_VILLAGEOISController,
                                        ),
                                      ),
                                    ],
                                  ),*/



                                ],
                                if (STR_DEVENIR_MEMBRE_PDCIController == 1) ...[
                                  const Padding(
                                    padding: EdgeInsets.symmetric(vertical: 0.0),
                                    child: Text(
                                      'Si NON,pourquoi?',
                                      style: TextStyle(fontStyle: FontStyle.italic),
                                    ),
                                  ),


                                  // Checkbox pour "Ne connait pas le programme de société du Parti"
                                  Row(
                                    children: [
                                      Checkbox(
                                        value: resterApolitique,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            resterApolitique = value!;
                                          });
                                        },
                                        activeColor: Colors.green, // Couleur de la case à cocher lorsqu'elle est sélectionnée
                                        checkColor: Colors.white,
                                      ),
                                      Text('Souhaite rester apolitique ?'),
                                    ],
                                  ),
                                  // Checkbox pour "Ne connait pas le programme de société du Parti"
                                  Row(
                                    children: [
                                      Checkbox(
                                        value: neConnaitPasLeProgramme,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            neConnaitPasLeProgramme = value!;
                                          });
                                        },
                                        activeColor: Colors.green, // Couleur de la case à cocher lorsqu'elle est sélectionnée
                                        checkColor: Colors.white, // Couleur de la coche à l'intérieur de la case à cocher
                                      ),
                                      Text('Ne connait pas le programme de société \ndu Parti'),
                                    ],
                                  ),

                                  // Checkbox pour "Ne partage pas les idéaux du Parti"
                                  Row(
                                    children: [
                                      Checkbox(
                                        value: nePartagePasLesIdeaux,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            nePartagePasLesIdeaux = value!;
                                          });
                                        },
                                        activeColor: Colors.green, // Couleur de la case à cocher lorsqu'elle est sélectionnée
                                        checkColor: Colors.white,
                                      ),
                                      Text('Ne partage pas les idéaux du Parti'),
                                    ],
                                  ),

                                  const SizedBox(height: 10),

                                  Row(
                                    children: [
                                      Expanded(
                                        child: CustomTextField(
                                          labelText: 'Autres raisons, préciser',
                                          controller: STR_RAISON_NE_PAS_DEVENIR_MEMBRE_PDCIController,
                                        ),
                                      ),
                                    ],
                                  ),

                                ],

                                const SizedBox(height: 10),


                              ],
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      Align(
                        alignment: Alignment.center,
                        child: ElevatedButton(

                          onPressed: () async {
                            if (_formKey.currentState?.validate() ?? false) {
                              setState(() {
                                _isSubmitted = true;
                              });
                              if (STR_GENREController != null) {
                                // Soumettre le formulaire
                                await saveFormData();
                                //print("Formulaire soumis avec genre : $STR_GENREGenre");
                              }else {
                                showErrorDialog();
                              }
                            } else {
                              showErrorDialog();
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            backgroundColor: Color(0xFFe4fb7c),
                            foregroundColor: Colors.black,
                            padding: EdgeInsets.symmetric(horizontal: 100, vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          child: const Text(
                            'Soumettre',
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 50),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> saveFormData() async {
    setState(() {
      _isLoading = true;
    });
    try {
      // Collecte des données à enregistrer
      final formData = {

        //'lieuDeVote': lieuDeVoteController.text,
        //'bureauDeVote': bureauDeVoteController.text,

        'STR_DISTRICT': STR_DISTRICTController.text,
        'STR_REGION': STR_REGIONController.text,
        'STR_DEPARTEMENT': STR_DEPARTEMENTController.text,
        'STR_SOUSPREFECTURE': STR_SOUSPREFECTUREController.text,
        'STR_COMMUNE': STR_COMMUNEController,
        'STR_VILLAGE': STR_VILLAGEController.text,
        'STR_CAMPEMENT': STR_CAMPEMENTController.text,

        'STR_NOM': STR_NOMController.text,
        'STR_GENRE': STR_GENREController == 0 ? 'Masculin' : 'Féminin',
        'STR_PRENOM': STR_PRENOMController.text,
        'STR_LIEU_NAISSANCE': STR_LIEU_NAISSANCEController.text,
        'STR_DATENAISSANCE': STR_DATENAISSANCEController.text,
        'STR_PHONE_PRINCIPAL': STR_PHONE_PRINCIPALController.text,
        'STR_PHONE_SECONDAIRE': STR_PHONE_SECONDAIREController.text,
        'STR_MAIL': STR_MAILController.text,
        'STR_SECTEUR_ACTIVITE': STR_SECTEUR_ACTIVITEController.text,
        'STR_FONCTION_OCCUPATION': STR_FONCTION_OCCUPATIONController.text,
        'STR_LIEU_TRAVAIL': STR_LIEU_TRAVAILController.text,

        'STR_LIEU_RESIDENCE': STR_LIEU_RESIDENCEController.text,
        'STR_PERSONNE_A_CONTACTER': STR_PERSONNE_A_CONTACTERController.text,
        'STR_PHONE_PERSONNE_A_CONTACTER': STR_PHONE_PERSONNE_A_CONTACTERController.text,

        'STR_NOM_ASSOCIATION': STR_NOM_ASSOCIATIONController.text,
        'STR_FONCTION_IN_ASSOCIATION': STR_FONCTION_ASSOCIATIONController.text,

        'STR_DEVENIR_MEMBRE_PLUSTARD':STR_DEVENIR_MEMBRE_PLUSTARDController ,

        'STR_REQUISITION_SOUS_PREFECTURE':STR_REQUISITION_SOUS_PREFECTUREController ,
        'STR_AUDIANCE_FORAINE':STR_AUDIANCE_FORAINEController ,
        'STR_AUTRES_SI_NON_ACTENAISSANCE':STR_AUTRES_SI_NON_ACTENAISSANCEController ,
        'STR_PRECISION_AUTRES_SI_NON_ACTENAISSANCE':STR_PRECISION_AUTRES_SI_NON_ACTENAISSANCEController.text ,

        //'STR_ETES_VOUS_IVOIRIEN': STR_ETES_VOUS_IVOIRIENController == 0 ? 'Oui' : 'Non',
        'STR_ETES_VOUS_IVOIRIEN':STR_ETES_VOUS_IVOIRIENController == null || STR_ETES_VOUS_IVOIRIENController == '' ? '' : (STR_ETES_VOUS_IVOIRIENController == 0 ? 'Oui' : 'Non'),

        'STR_REF_NATURALISATION': STR_REF_NATURALISATIONController.text,
        'STR_ANNEENATURALISATION': STR_ANNEE_NATURALISATIONController.text,

        'STR_DISPOSEZ_VOUS_DOCUMENT_ADNINISTRATIVE':STR_DISPOSEZ_VOUS_DOCUMENT_ADNINISTRATIVEController == null || STR_DISPOSEZ_VOUS_DOCUMENT_ADNINISTRATIVEController == '' ? '' : (STR_DISPOSEZ_VOUS_DOCUMENT_ADNINISTRATIVEController == 0 ? 'Oui' : 'Non'),

        //'STR_AVEZ_VOUS_UN_PASSPORT': STR_AVEZ_VOUS_UN_PASSPORTController  == 0 ? 'Oui' : 'Non',
        'STR_AVEZ_VOUS_UN_PASSPORT':STR_AVEZ_VOUS_UN_PASSPORTController == null || STR_AVEZ_VOUS_UN_PASSPORTController == '' ? '' : (STR_AVEZ_VOUS_UN_PASSPORTController == 0 ? 'Oui' : 'Non'),

        'STR_NUMERO_PASSPORT': STR_NUMERO_PASSPORTController.text,
        //'STR_AVEZ_VOUS_CNI': STR_AVEZ_VOUS_CNIController  == 0 ? 'Oui' : 'Non',
        'STR_AVEZ_VOUS_CNI':STR_AVEZ_VOUS_CNIController == null || STR_AVEZ_VOUS_CNIController == '' ? '' : (STR_AVEZ_VOUS_CNIController == 0 ? 'Oui' : 'Non'),

        'STR_NUMERO_CNI': STR_NUMERO_CNIController.text,

        //'STR_ETES_VOUS_DANS_UNE_ASSOCIATION': STR_ETES_VOUS_DANS_UNE_ASSOCIATIONController == 0 ? 'Oui' : 'Non',
        'STR_ETES_VOUS_DANS_UNE_ASSOCIATION':STR_AVEZ_VOUS_CNIController == null || STR_AVEZ_VOUS_CNIController == '' ? '' : (STR_AVEZ_VOUS_CNIController == 0 ? 'Oui' : 'Non'),

        //'STR_PARTICIPE_ACTIVITE_POLITIQUE': STR_PARTICIPE_ACTIVITE_POLITIQUEController == 0 ? 'Oui' : 'Non',
        'STR_PARTICIPE_ACTIVITE_POLITIQUE':STR_PARTICIPE_ACTIVITE_POLITIQUEController == null || STR_PARTICIPE_ACTIVITE_POLITIQUEController == '' ? '' : (STR_PARTICIPE_ACTIVITE_POLITIQUEController == 0 ? 'Oui' : 'Non'),

        //'STR_DEVENIR_MEMBRE_PDCI': STR_DEVENIR_MEMBRE_PDCIController == 0 ? 'Oui' : 'Non',
        'STR_DEVENIR_MEMBRE_PDCI':STR_DEVENIR_MEMBRE_PDCIController == null || STR_DEVENIR_MEMBRE_PDCIController == '' ? '' : (STR_DEVENIR_MEMBRE_PDCIController == 0 ? 'Oui' : 'Non'),

        //'STR_ETESVOUS_MEMBRE_PARTIPOLITIQUE': STR_ETESVOUS_MEMBRE_PARTIPOLITIQUEController == 0 ? 'Oui' : 'Non',
        'STR_ETESVOUS_MEMBRE_PARTIPOLITIQUE':STR_ETESVOUS_MEMBRE_PARTIPOLITIQUEController == null || STR_ETESVOUS_MEMBRE_PARTIPOLITIQUEController == '' ? '' : (STR_ETESVOUS_MEMBRE_PARTIPOLITIQUEController == 0 ? 'Oui' : 'Non'),

        'STR_RESTERAPOLITIQUE': resterApolitique,
        'STR_NE_CONNAIT_PAS_PROGRAMME': neConnaitPasLeProgramme,
        'STR_NE_PARTAGE_PAS_IDEAUX': nePartagePasLesIdeaux,
        'STR_RAISON_NE_PAS_DEVENIR_MEMBRE_PDCI': STR_RAISON_NE_PAS_DEVENIR_MEMBRE_PDCIController.text,

        'STR_DELEGATION_DEPARTE_PDCI': STR_DELEGATION_DEPARTE_PDCIController.text,
        'STR_DELEGATION_COMMU_PDCI': STR_DELEGATION_COMMU_PDCIController.text,
        'STR_SECTION_PDCI': STR_SECTION_PDCIController,
        'STR_COMITE_QUARTIER': STR_COMITE_QUARTIERController.text,
        'STR_COMITE_VILLAGEOIS': STR_COMITE_VILLAGEOISController.text,
      };

      // Vérifier si les numéros de téléphone existent déjà
      final existingPhonesQuery = await FirebaseFirestore.instance
          .collection('form_data')
          .where('STR_PHONE_PRINCIPAL', isEqualTo: STR_PHONE_PRINCIPALController.text)
          .where('STR_PHONE_SECONDAIRE', isEqualTo: STR_PHONE_SECONDAIREController.text)
          .get();

      if (existingPhonesQuery.docs.isNotEmpty) {
        // Extraire les numéros de téléphone pour le message d'erreur
        String STR_PHONE_PRINCIPAL = STR_PHONE_PRINCIPALController.text;
        String STR_PHONE_SECONDAIRE = STR_PHONE_SECONDAIREController.text;

        // Afficher un message d'erreur si les numéros de téléphone existent déjà
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Erreur'),
              content: Text('Les numéros de téléphone suivants sont déjà utilisés :\nPhone 1: $STR_PHONE_PRINCIPAL\nPhone 2: $STR_PHONE_SECONDAIRE'),
              actions: <Widget>[
                TextButton(
                  child: const Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }  else {
        final user = FirebaseAuth.instance.currentUser;

        if (user != null) {
          // Utilisateur connecté
          //final userId = user.uid;
          //final userDoc = FirebaseFirestore.instance.collection('users').doc(userId);

          // Enregistrer les données pour l'utilisateur connecté
          //await userDoc.collection('form_data').add(formData);

          try {
            if (widget.itemId != null) {
              // Update existing item
              await FirebaseFirestore.instance
                  .collection('users')
                  .doc(user?.uid)
                  .collection('form_data')
                  .doc(widget.itemId)
                  .update(formData);
            } else {
              // Create new item
              await FirebaseFirestore.instance
                  .collection('users')
                  .doc(user?.uid)
                  .collection('form_data')
                  .add(formData);
            }
          } catch (e) {
            print('Error saving data: $e');
          }

        } else {
          // Utilisateur non connecté
          // Enregistrer les données dans une autre collection

          await FirebaseFirestore.instance.collection('form_data').add(formData);
        }
        /*setState(() {
          _isLoading = false;
        });*/
        // Afficher un message de succès
        if (user != null)
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Succès'),
                content: const Text('Les données ont été enregistrées avec succès.'),
                actions: <Widget>[
                  TextButton(
                    child: const Text('OK'),
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );

        if (user == null) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Succès'),
                content: const Text('Les données ont été enregistrées avec succès.'),
                actions: <Widget>[
                  TextButton(
                    child: const Text('OK'),
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => ChoixInscriptionPage(), // Remplacez AnotherScreen par l'écran cible
                        ),
                      );
                    },
                  ),
                ],
              );
            },
          );
        }
      }
    } catch (e) {
      print('Error saving form data: $e');
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Erreur'),
            content: const Text('Échec de l\'enregistrement des données.'),
            actions: <Widget>[
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  void showErrorDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Erreur'),
          content: Text('Veuillez remplir tous les champs obligatoires.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }


  Widget buildQuestion({
    required int questionNumber,
    required String questionText,
    required List<String> options,
    required int? selectedOption,
    required ValueChanged<int?> onChanged,
    bool showTextField = false,
    TextEditingController? controller,
    String? labelText,
    required Color mycolor,
  }) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
                decoration: BoxDecoration(
                  color: mycolor,
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Text(
                  '$questionNumber',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  questionText,
                  style: const TextStyle(
                    //fontWeight: FontWeight.bold,
                    fontSize: 13.0, // Ajustez la taille du texte ici
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(right: 10.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: options.asMap().entries.map((entry) {
                    int index = entry.key;
                    String option = entry.value;
                    return GestureDetector(
                      onTap: () {
                        onChanged(index);
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min, // Pour rapprocher les éléments
                        children: [
                          Container(
                            margin: const EdgeInsets.all(0.0), // Ajuste la marge autour du bouton radio
                            child: Theme(
                              data: Theme.of(context).copyWith(
                                visualDensity: VisualDensity.compact, // Ajuste la densité visuelle pour les widgets
                                unselectedWidgetColor: mycolor, // Couleur du bouton radio non sélectionné
                                radioTheme: const RadioThemeData(),
                              ),
                              child: Transform.scale(
                                scale: 0.6, // Ajustez cette valeur pour changer la taille du bouton radio
                                child: Radio<int>(
                                  value: index,
                                  groupValue: selectedOption,
                                  onChanged: onChanged,
                                  activeColor: mycolor, // Couleur du bouton radio sélectionné
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width:0.0), // Ajustez la marge à gauche du texte du bouton radio
                          Text(
                            option,
                            style: TextStyle(
                              fontSize: 14.0, // Ajustez la taille du texte ici
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          if (showTextField) ...[
            const SizedBox(height: 10),
            CustomTextField(
              labelText: labelText ?? '',
              controller: controller ?? TextEditingController(),
            ),
          ],
        ],
      ),
    );

  }


  Widget buildDocumentQuestion({
    required int questionNumber,
    required String questionText,
    required TextEditingController controller,
    required String labelText,
    required Color mycolor,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: mycolor,
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: Text(
                '$questionNumber',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(width: 8.0),
            Expanded(
              child: Text(
                questionText,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),

          ],
        ),
        const SizedBox(height: 10),
        CustomTextField(
          labelText: labelText,
          controller: controller,
        ),
      ],
    );
  }

}


class CustomCard extends StatelessWidget {
  final String title;
  final Widget iconWidget; // Remplace IconData par Widget
  final Color backgroundColor;
  final Color textColor;

  const CustomCard({
    Key? key,
    required this.title,
    required this.iconWidget,
    this.backgroundColor = Colors.white,
    this.textColor = Colors.black, // Ajouter un paramètre pour la couleur du texte
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 0.0),
      child: Card(
        elevation: 4,
        color: backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        shadowColor: Colors.black.withOpacity(0.2),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 9.0, horizontal: 12.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              iconWidget, // Utilise le widget pour l'icône ou l'image
              const SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: textColor, // Utilise la couleur du texte paramétrée
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;
  final FormFieldValidator<String>? validator;
  final bool obscureText;
  final TextInputType keyboardType;
  final Color? fillColor;
  final EdgeInsetsGeometry contentPadding;
  final TextStyle? labelStyle;
  final bool requiredIndicator;

  const CustomTextField({
    Key? key,
    required this.labelText,
    required this.controller,
    this.validator,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.fillColor = Colors.white,
    this.contentPadding = const EdgeInsets.symmetric(vertical: 0.0, horizontal: 12.0),
    this.labelStyle,
    this.requiredIndicator = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      validator: validator,
      decoration: InputDecoration(
        labelText: null, // Nous n'utilisons plus labelText directement
        label: RichText(
          text: TextSpan(
            text: labelText,
            style: labelStyle ?? TextStyle(fontSize: 12.0, color: Colors.black),
            children: requiredIndicator
                ? [
              TextSpan(
                text: ' *',
                style: TextStyle(color: Colors.black, fontSize: 14.0),
              ),
            ]
                : [],
          ),
        ),
        filled: true,
        fillColor: fillColor,
        contentPadding: contentPadding,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(color: Color(0xFFcecece), width: 0.50),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(color: Color(0xFFcecece), width: 0.50),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(color: Colors.green, width: 2.0),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(color: Colors.red, width: 2.0),
        ),
      ),
    );
  }
}

class CustomDropdownFormField extends StatefulWidget {
  final String labelText;
  final List<String> items;
  final String? value;
  final ValueChanged<String?>? onChanged;
  final FormFieldValidator<String>? validator;
  final EdgeInsetsGeometry contentPadding;
  final TextStyle? labelStyle;
  final bool isRequired;
  final Color? backgroundColor;

  const CustomDropdownFormField({
    Key? key,
    required this.labelText,
    required this.items,
    this.value,
    this.onChanged,
    this.validator,
    this.contentPadding = const EdgeInsets.symmetric(vertical: 0.0, horizontal: 12.0),
    this.labelStyle,
    this.isRequired = false,
    this.backgroundColor = const Color(0xFFFFFFFF),
  }) : super(key: key);

  @override
  _CustomDropdownFormFieldState createState() => _CustomDropdownFormFieldState();
}

class _CustomDropdownFormFieldState extends State<CustomDropdownFormField> {
  late String? _selectedValue;

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: _selectedValue,
      items: widget.items.map((String item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Text(item),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          _selectedValue = value;
        });
        widget.onChanged?.call(value);
      },
      decoration: InputDecoration(
        filled: true,
        fillColor: widget.backgroundColor,
        labelText: widget.isRequired
            ? widget.labelText + ' *'
            : widget.labelText,
        labelStyle: widget.labelStyle?.copyWith(
          //color: widget.isRequired ? Colors.black : null,
        ),
        contentPadding: widget.contentPadding,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(color: Color(0xFFcecece), width: 0.50),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(color: Color(0xFFcecece), width: 0.50),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(color: Colors.green, width: 2.0),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(color: Colors.red, width: 2.0),
        ),
      ),
      validator: widget.validator ?? (value) {
        if (widget.isRequired && (value == null || value.isEmpty)) {
          return 'Ce champ est obligatoire';
        }
        return null;
      },
      isExpanded: true,
    );
  }
}

class CustomDatePicker extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final FormFieldValidator<String>? validator;
  final bool requiredIndicator;
  final int initialYear; // Ajouter le paramètre pour l'année de départ

  const CustomDatePicker({
    Key? key,
    required this.controller,
    required this.labelText,
    this.validator,
    this.requiredIndicator = false,
    this.initialYear = 1900, // Valeur par défaut si aucune valeur n'est fournie
  }) : super(key: key);

  @override
  _CustomDatePickerState createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      readOnly: true,
      validator: widget.validator,
      decoration: InputDecoration(
        labelText: null,
        label: RichText(
          text: TextSpan(
            text: widget.labelText,
            style: TextStyle(fontSize: 12.0, color: Colors.black),
            children: widget.requiredIndicator
                ? [
              const TextSpan(
                text: ' *',
                style: TextStyle(color: Colors.black),
              ),
            ]
                : [],
          ),
        ),
        prefixIcon: const Icon(
          Icons.calendar_today,
          size: 20.0,
          color: Colors.grey,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        isDense: true,
        contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(color: Colors.green, width: 2.0),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(color: Colors.red, width: 2.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(color: Color(0xFFcecece), width: 0.50),
        ),
      ),
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(widget.initialYear), // Utiliser initialYear
          lastDate: DateTime(2101),
          builder: (BuildContext context, Widget? child) {
            return Theme(
              data: ThemeData.light().copyWith(
                primaryColor: Colors.green, // Couleur principale du calendrier
                colorScheme: ColorScheme.light(
                  primary: Colors.green, // Couleur de l'en-tête du calendrier
                  onSurface: Colors.black, // Couleur du texte
                ),
                buttonTheme: ButtonThemeData(
                  textTheme: ButtonTextTheme.primary,
                ),
              ),
              child: child!,
            );
          },
        );

        if (pickedDate != null) {
          String formattedDate = DateFormat('dd/MM/yyyy').format(pickedDate);
          setState(() {
            widget.controller.text = formattedDate;
          });
        }
      },
    );
  }
}


class CustomPhoneNumberField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final FormFieldValidator<String>? validator;
  final bool requiredIndicator;

  const CustomPhoneNumberField({
    Key? key,
    required this.controller,
    required this.labelText,
    this.validator,
    this.requiredIndicator = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      readOnly: true,
      decoration: InputDecoration(
        labelText: null,
        label: RichText(
          text: TextSpan(
            text: labelText,
            style: TextStyle(fontSize: 12.0, color: Colors.black),
            children: requiredIndicator
                ? [
              const TextSpan(
                text: ' *',
                style: TextStyle(color: Colors.black),
              ),
            ]
                : [],
          ),
        ),
        prefixIcon: const Icon(
          Icons.phone,
          size: 20.0, // Taille de l'icône
          color: Colors.grey,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        isDense: true, // Réduit la hauteur du champ
        contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0), // Ajustez le padding pour réduire la hauteur
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(color: Colors.green, width: 2.0),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(color: Colors.red, width: 2.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(color: Color(0xFFcecece), width: 0.50),
        ),
      ),
      onTap: () async {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              backgroundColor: Colors.blueGrey[50], // Changer la couleur de fond du modal
              child: Container(
                padding: const EdgeInsets.all(16.0),
                child: IntlPhoneField(
                  controller: controller,
                  decoration: InputDecoration(
                    labelText: labelText,
                    fillColor: Colors.white, // Couleur de fond de IntlPhoneField
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.0), // Arrondir les angles
                      borderSide: BorderSide(
                        color: Colors.green, // Changer la couleur de la bordure
                        width: 2.0,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0), // Arrondir les angles
                      borderSide: const BorderSide(color: Colors.green, width: 2.0)
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0), // Arrondir les angles
                      borderSide: BorderSide(
                        color: Colors.green, // Changer la couleur de la bordure lors de la mise au point
                        width: 2.0,
                      ),
                    ),
                  ),
                  initialCountryCode: 'CI',
                  onChanged: (phone) {
                    // Actions à effectuer lors du changement du numéro de téléphone
                  },
                ),
              ),
            );
          },
        );
      },
    );
  }
}


class CustomDropdownButtonFormField extends StatelessWidget {
  final String? value;
  final List<String> items;
  final String? labelText;
  final void Function(String?)? onChanged;
  final String? Function(String?)? validator;

  const CustomDropdownButtonFormField({
    Key? key,
    required this.value,
    required this.items,
    this.labelText,
    this.onChanged,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: value,
      items: items.map((item) => DropdownMenuItem<String>(
        value: item,
        child: Text(item),
      )).toList(),
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: labelText,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide(
            color: Colors.green,
            width: 2.0,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: const BorderSide(color: Colors.green, width: 2.0)
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide(
            color: Color(0xFFcecece),
            width: 0.50,
          ),
        ),
      ),
      dropdownColor: Colors.white,
      validator: validator,
    );
  }
}

Widget GenreQuestion({
  required List<String> options,
  required int? selectedOption,
  required ValueChanged<int?> onChanged,
  bool showTextField = false,
  TextEditingController? controller,
  String? labelText,
  required Color mycolor,
}) {
  return Container(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [

            const SizedBox(width: 8.0),
            Container(
              padding: const EdgeInsets.only(right: 10.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: options.asMap().entries.map((entry) {
                  int index = entry.key;
                  String option = entry.value;
                  return GestureDetector(
                    onTap: () {
                      onChanged(index);
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          margin: const EdgeInsets.all(0.0),
                          child: Transform.scale(
                            scale: 0.6, // Ajustez cette valeur pour changer la taille du bouton radio
                            child: Radio<int>(
                              value: index,
                              groupValue: selectedOption,
                              onChanged: onChanged,
                              activeColor: mycolor, // Couleur du bouton radio sélectionné
                            ),
                          ),
                        ),
                        const SizedBox(width: 0.0),
                        Text(
                          option,
                          style: TextStyle(
                            fontSize: 15.0, // Ajustez la taille du texte ici
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        if (showTextField) ...[
          const SizedBox(height: 10),
          CustomTextField(
            labelText: labelText ?? '',
            controller: controller ?? TextEditingController(),
          ),
        ],
      ],
    ),
  );
}

