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

