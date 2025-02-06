import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'form_page.dart';

class DetailPage extends StatefulWidget {
  final String documentId;

  DetailPage({required this.documentId});

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  Future<Map<String, dynamic>?>? _dataFuture;

  @override
  void initState() {
    super.initState();
    _refreshData();
  }

  void _refreshData() {
    setState(() {
      _dataFuture = _fetchData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Détails de l\'inscription',  style: TextStyle(color: Colors.white)),
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
      body: FutureBuilder<Map<String, dynamic>?>(
        future: _dataFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erreur lors du chargement des données: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data == null) {
            return Center(child: Text('Aucune donnée trouvée.'));
          }

          final data = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              children: [
                Center(
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(data['profileImageUrl'] ?? 'https://via.placeholder.com/100'), // Placeholder or actual image
                  ),
                ),
                SizedBox(height: 16),
                Center(
                  child: Text(
                    data['STR_PRENOM'] + data['STR_NOM'] ?? 'Nom non disponible',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
                Center(
                  child: Text(
                    'Email: ${data['STR_MAIL'] ?? 'Date non disponible'}',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FormPage(itemId: widget.documentId),
                      ),
                    ).then((_) {
                      // Refresh the data when returning to this screen
                      _refreshData();
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFe4fb7c),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                  ),
                  child: Text('Mettre à jour les données'),

                ),
                SizedBox(height: 16),
                // Other UI elements remain the same
                SizedBox(height: 16),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('LIBELLE', style: TextStyle(color: Colors.grey)),
                        //Text(data['projectsCount'].toString(), style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('VALEUR', style: TextStyle(color: Colors.grey)),
                        //Text('\$${data['earned'].toString()}', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ],
                ),

                SizedBox(height: 16),
                Text('Localité de récensement'.toUpperCase(), style: TextStyle(color:  Color(0xFFCC9B21), fontWeight: FontWeight.bold)),
                SizedBox(height: 16),
                //_buildDetailRow('Deadline rate', '${data['deadlineRate'] ?? 0}%'),
                _buildDetailRow('Commune', data['STR_COMMUNE'] ?? ''),
                _buildDetailRow('Département', data['STR_DEPARTEMENT'] ?? ''),
                _buildDetailRow('District', data['STR_DISTRICT'] ?? ''),
                _buildDetailRow('Région', data['STR_REGION'] ?? ''),
                _buildDetailRow('Sous-préfecture', data['STR_SOUSPREFECTURTE'] ?? ''),
                _buildDetailRow('Village', data['STR_VILLAGE'] ?? ''),
                _buildDetailRow('Campement', data['STR_CAMPEMENT'] ?? ''),

                SizedBox(height: 16),
                Text('Informations personnelles'.toUpperCase(), style: TextStyle(color:  Color(0xFFCC9B21), fontWeight: FontWeight.bold)),
                SizedBox(height: 16),
                _buildDetailRow('Genre', data['STR_GENRE'] ?? ''),
                _buildDetailRow('Nom', data['STR_NOM'] ?? ''),
                _buildDetailRow('Prénom', data['STR_PRENOM'] ?? ''),
                _buildDetailRow('Date de Naissance', data['STR_DATENAISSANCE'] ?? ''),
                _buildDetailRow('Lieu de Naissance', data['STR_LIEU_NAISSANCE'] ?? ''),
                _buildDetailRow('Lieu de Résidence', data['STR_LIEU_RESIDENCE'] ?? ''),
                _buildDetailRow('Lieu de Travail', data['STR_LIEU_TRAVAIL'] ?? ''),
                _buildDetailRow('Fonction Occupation', data['STR_FONCTION_OCCUPATION'] ?? ''),
                _buildDetailRow('Secteur d\'activité', data['STR_SECTEUR_ACTIVITE'] ?? ''),
                _buildDetailRow('Téléphone Principal', data['STR_PHONE_PRINCIPAL'] ?? ''),
                _buildDetailRow('Téléphone Secondaire', data['STR_PHONE_SECONDAIRE'] ?? ''),
                _buildDetailRow('Email', data['STR_MAIL'] ?? ''),
                _buildDetailRow('Personne à Contacter', data['STR_PERSONNE_A_CONTACTER'] ?? ''),
                _buildDetailRow('Téléphone de la Personne à Contacter', data['STR_PHONE_PERSONNE_A_CONTACTER'] ?? ''),

                SizedBox(height: 16),
                Text('Documentations et inscription sur la liste électorale'.toUpperCase(), style: TextStyle(color:  Color(0xFFCC9B21), fontWeight: FontWeight.bold)),
                SizedBox(height: 16),

                _buildDetailRow('Disposé-vous des doccument administrative ?', data['STR_DISPOSEZ_VOUS_DOCUMENT_ADNINISTRATIVE'] ?? ''),
                _buildDetailRow('Avez-vous la CNI ?', data['STR_DISPOSEZ_VOUS_DOCUMENT_ADNINISTRATIVE'] ?? ''),
                _buildDetailRow('Numéro de CNI', data['STR_NUMERO_CNI'] ?? ''),
                _buildDetailRow('Avez-vous un Passport ?', data['STR_AVEZ_VOUS_UN_PASSPORT'] ?? ''),

                _buildDetailRow('Aux audiciences foraines', data['STR_AUDIANCE_FORAINE']  ? 'Oui' : 'Non'),
                _buildDetailRow('Requisition à la Sous-Préfecture', data['STR_AUTRES_SI_NON_ACTENAISSANCE']  ? 'Oui' : 'Non'),
                _buildDetailRow('Autres', data['STR_REQUISITION_SOUS_PREFECTURE']  ? 'Oui' : 'Non'),
                _buildDetailRow('Préciser', data['STR_PRECISION_AUTRES_SI_NON_ACTENAISSANCE'] ?? ''),

                _buildDetailRow('Numéro de Passport', data['STR_NUMERO_PASSPORT'] ?? ''),
                _buildDetailRow('Année de Naturalisation', data['STR_ANNEENATURALISATION'] ?? ''),
                _buildDetailRow('Référence de Naturalisation', data['STR_REF_NATURALISATION'] ?? ''),


                SizedBox(height: 16),
                Text('Activité sociales et politiques'.toUpperCase(), style: TextStyle(color: Color(0xFFCC9B21), fontWeight: FontWeight.bold)),
                SizedBox(height: 16),
                _buildDetailRow('Êtes-vous Ivoirien ?', data['STR_ETES_VOUS_IVOIRIEN'] ?? ''),
                _buildDetailRow('Êtes-vous dans une association ?', data['STR_ETES_VOUS_DANS_UNE_ASSOCIATION'] ?? ''),
                _buildDetailRow('Nom de l\'Association', data['STR_NOM_ASSOCIATION'] ?? ''),
                _buildDetailRow('Fonction dans l\'Association', data['STR_FONCTION_IN_ASSOCIATION'] ?? ''),
                _buildDetailRow('Êtes-vous membre d\'un parti politique ?', data['STR_ETESVOUS_MEMBRE_PARTIPOLITIQUE'] ?? ''),
                _buildDetailRow('Participez-vous aux activités politiques ?', data['STR_PARTICIPE_ACTIVITE_POLITIQUE'] ?? ''),
                _buildDetailRow('Restez apolitique ?', data['STR_RESTERAPOLITIQUE'] ? 'Oui' : 'Non'),
                _buildDetailRow('Partagez-vous les idéaux ?', data['STR_NE_PARTAGE_PAS_IDEAUX'] ? 'Oui' : 'Non'),
                _buildDetailRow('Connaissez-vous le programme ?', data['STR_NE_CONNAIT_PAS_PROGRAMME'] ? 'Oui' : 'Non'),
                _buildDetailRow('Souhaitez-vous devenir membre du PDCI ?', data['STR_DEVENIR_MEMBRE_PDCI'] ?? ''),

                _buildDetailRow('Devenire membre mainteant ?', data['STR_DEVENIR_MEMBRE_PLUSTARD'] ? 'Oui' : 'Non'),

                _buildDetailRow('Si non, les raisons', data['STR_RAISON_NE_PAS_DEVENIR_MEMBRE_PDCI'] ?? ''),
                _buildDetailRow('Section PDCI', data['STR_SECTION_PDCI'] ?? ''),
                _buildDetailRow('Délegation Communale PDCI', data['STR_DELEGATION_COMMU_PDCI'] ?? ''),
                _buildDetailRow('Délegation Départementale PDCI', data['STR_DELEGATION_DEPARTE_PDCI'] ?? ''),
                _buildDetailRow('Comité de Quartier', data['STR_COMITE_QUARTIER'] ?? ''),
                _buildDetailRow('Comité Villageois', data['STR_COMITE_VILLAGEOIS'] ?? ''),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
          Text(value, style: TextStyle(color: Colors.black54)),
        ],
      ),
    );
  }

  Future<Map<String, dynamic>?> _fetchData() async {
    try {
      // Obtenir l'utilisateur actuellement connecté
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        // Construire le chemin en fonction de l'ID utilisateur et de l'ID du document
        final userId = user.uid;
        DocumentSnapshot snapshot = await FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .collection('form_data')
            .doc(widget.documentId)
            .get();

        // Retourner les données si elles existent
        return snapshot.data() as Map<String, dynamic>?;
      }
      return null;
    } catch (e) {
      print('Error fetching details: $e');
      return null;
    }
  }
}
