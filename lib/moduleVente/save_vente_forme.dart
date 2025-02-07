// lib/form_page.dart
// lib/form_page.dart
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import '../choix_inscrption.dart';
import 'package:url_launcher/url_launcher.dart';

import '/widgets/custom_text_field.dart';
import '/widgets/custom_date_picker.dart';
import '/widgets/custom_phone_number_field.dart';
import '/widgets/custom_dropdown.dart';
import '/widgets/custom_dropdown_button_form_field.dart';
import '/widgets/genre_question.dart';
import '/widgets/custom_card.dart';
import '/widgets/document_question.dart';

import '../utils/colors.dart';



class SaveVenteForm extends StatefulWidget {

  final String? itemId; // ID de l'item à modifier, null si création

  SaveVenteForm({this.itemId});

  @override
  _FormPageState createState() => _FormPageState();

}

class _FormPageState extends State<SaveVenteForm> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for the form fields
  final TextEditingController STR_DISTRICTController = TextEditingController();
  final TextEditingController STR_REGIONController = TextEditingController();
  final TextEditingController STR_DEPARTEMENTController = TextEditingController();
  final TextEditingController STR_SOUSPREFECTUREController = TextEditingController();
  //final TextEditingController STR_COMMUNEController = TextEditingController();
  final TextEditingController STR_VILLAGEController = TextEditingController();
  final TextEditingController STR_CAMPEMENTController = TextEditingController();

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
  final TextEditingController STR_LIEU_RESIDENCEController = TextEditingController();
  final TextEditingController STR_PERSONNE_A_CONTACTERController = TextEditingController();
  final TextEditingController STR_PHONE_PERSONNE_A_CONTACTERController = TextEditingController();
  final TextEditingController STR_NUMERO_CNIController = TextEditingController();

  // Variables pour les checkboxes

  int? STR_GENREController;

  // Controllers for new section
  //final TextEditingController STR_COMITE_QUARTIERController = TextEditingController();
  //final TextEditingController STR_COMITE_VILLAGEOISController = TextEditingController();
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

        //STR_NOM_ASSOCIATIONController.text = data['STR_NOM_ASSOCIATION'] ?? '';
        STR_NUMERO_CNIController.text = data['STR_NUMERO_CNI'] ?? '';
        STR_GENREController = (data['STR_GENRE'] == null || data['STR_GENRE'].isEmpty)
            ? null
            : (data['STR_GENRE'] == 'Masculin' ? 0 : 1);


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
    final theme = Theme.of(context);

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

      backgroundColor: AppColors.getBackgroundColor(context),
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

                      Container(
                        width: double.infinity,
                        margin: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
                        child: Card(
                          elevation: 4,
                          color: theme.colorScheme.background,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          shadowColor: Colors.black.withOpacity(0),

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

                                const SizedBox(height: 10),

                                Row(
                                  children: [
                                    const SizedBox(width: 10),
                                    SizedBox(height: 16),

                                    Expanded(
                                      child: CustomDatePicker(
                                        controller: STR_DATENAISSANCEController,
                                        labelText: 'Date',
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Veuillez renseigner la date';
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
                                        labelText: 'Poids',
                                        controller: STR_LIEU_NAISSANCEController,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Veuillez renseigner la masse en Kg';
                                          }
                                          return null;
                                        },
                                        requiredIndicator: true,
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    SizedBox(height: 16),


                                  ],
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    Expanded(
                                      child: CustomTextField(
                                        labelText: 'Prix de vente',
                                        controller: STR_MAILController,
                                      ),
                                    ),
                                    const SizedBox(width: 10),

                                  ],
                                ),
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
        'STR_NUMERO_CNI': STR_NUMERO_CNIController.text,
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
}

