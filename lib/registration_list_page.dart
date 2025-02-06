import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'DetailPage.dart';
import 'form_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Registration List',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: RegistrationList(),
    );
  }
}

class RegistrationList extends StatefulWidget {
  @override
  _RegistrationListState createState() => _RegistrationListState();
}

class _RegistrationListState extends State<RegistrationList> {
  String searchQuery = '';
  List<DocumentSnapshot> allDocuments = [];
  List<DocumentSnapshot> filteredDocuments = [];

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final userId = user.uid;
        final snapshot = await FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .collection('form_data')
            .get();

        setState(() {
          allDocuments = snapshot.docs;
          filteredDocuments = allDocuments;
        });
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  void _filterData(String query) {
    setState(() {
      searchQuery = query;
      filteredDocuments = allDocuments.where((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return data.values.any((value) => value.toString().toLowerCase().contains(query.toLowerCase()));
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Liste des inscriptions',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xFF007D3C),
        iconTheme: IconThemeData(color: Colors.white),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(60.0),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 16.0, 8.0, 0),
            child: Material(
              elevation: 4,
              shadowColor: Colors.black.withOpacity(0.2),
              borderRadius: BorderRadius.circular(16.0),
              child: TextField(
                onChanged: _filterData,
                decoration: InputDecoration(
                  hintText: 'Rechercher',
                  prefixIcon: Icon(Icons.search, color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          Container(
            height: 50,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF007D3C), Color(0xFF005F2E)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 16.0, 8.0, 0),
            child: Material(
              elevation: 4,
              shadowColor: Colors.black.withOpacity(0.2),
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.0),
              child: ListView.builder(
                padding: EdgeInsets.all(16.0),
                itemCount: filteredDocuments.length,
                itemBuilder: (context, index) {
                  final doc = filteredDocuments[index];
                  final data = doc.data() as Map<String, dynamic>;

                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 8.0),
                    elevation: 4,
                    shadowColor: Colors.black.withOpacity(0.2),
                    color: Colors.white,
                    child: ListTile(
                      leading: CircleAvatar(
                        child: Icon(Icons.person),
                      ),
                      title: Text('${data['STR_NOM'] ?? 'N/A'} ${data['STR_PRENOM'] ?? 'N/A'}'),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(data['STR_PHONE_PRINCIPAL'] ?? 'N/A'),
                          Text(data['STR_LIEU_RESIDENCE'] ?? 'N/A'),
                        ],
                      ),
                      trailing: PopupMenuButton<String>(
                        color: Colors.grey[200], // Change background color
                        onSelected: (String value) {
                          if (value == 'details') {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailPage(documentId: doc.id),
                              ),
                            );
                          } else if (value == 'modifier') {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FormPage(itemId: doc.id),
                              ),
                            );
                          }
                        },
                        itemBuilder: (BuildContext context) {
                          return [
                            PopupMenuItem(
                              value: 'details',
                              child: Row(
                                children: [
                                  Icon(Icons.remove_red_eye, color: Colors.black),
                                  SizedBox(width: 8),
                                  Text('Voir les détails'),
                                ],
                              ),
                            ),
                            PopupMenuItem(
                              value: 'modifier',
                              child: Row(
                                children: [
                                  Icon(Icons.edit, color: Colors.black),
                                  SizedBox(width: 8),
                                  Text('Modifier les informations'),
                                ],
                              ),
                            ),
                          ];
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
