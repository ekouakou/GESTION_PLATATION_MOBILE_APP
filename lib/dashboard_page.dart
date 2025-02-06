import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fl_chart/fl_chart.dart';

import 'widgets/drawer_item.dart';
import 'widgets/stat_card.dart';
import 'widgets/game_category.dart';

class DashboardPage extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> _getCurrentUser() async {
    return _auth.currentUser;
  }

  void _signOut(BuildContext context) async {
    try {
      await _auth.signOut();
      Navigator.of(context).pushReplacementNamed('/welcome');
    } catch (e) {
      print('Erreur de déconnexion : $e');
    }
  }

  Future<int> _getUserTotalRecords(String userId) async {
    QuerySnapshot query = await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('form_data')
        .get();
    return query.docs.length;
  }

  Future<int> _getTotalRecords() async {
    QuerySnapshot query = await FirebaseFirestore.instance.collection('form_data').get();
    return query.docs.length;
  }

  Future<int> _getCombinedTotalRecords(String userId) async {
    int totalRecords = await _getTotalRecords();
    int userTotalRecords = await _getUserTotalRecords(userId);
    return totalRecords + userTotalRecords;
  }


  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User?>(
      future: _getCurrentUser(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        User user = snapshot.data!;
        String userId = user.uid;
        String district = "SomeDistrict"; // Remplacez "SomeDistrict" par la valeur souhaitée ou par une variable dynamique


        return Scaffold(
          appBar: AppBar(
            //title: Text('Dashboard'),
          ),
          drawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                DrawerHeader(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFF007D3C), Color(0xFF005F2E)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundImage: AssetImage('assets/images/logo-e-pdci.png'),
                        backgroundColor: Color(0xFFF1F6F9),
                      ),
                      SizedBox(width: 10),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'e-Pdci Rda',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                            ),
                          ),
                          Text(
                            user.email ?? 'Email non disponible',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                DrawerItem(
                  icon: Icons.dashboard,
                  text: 'Dashboard',
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pushReplacementNamed('/dashboard');
                  },
                ),
                FutureBuilder<int>(
                  future: _getCombinedTotalRecords(userId),
                  builder: (context, snapshot) {
                    int totalRecords = snapshot.data ?? 0;
                    return DrawerItem(
                      icon: Icons.list,
                      text: 'Liste inscrit',
                      trailing: CircleAvatar(
                        radius: 10,
                        child: Text('$totalRecords', style: TextStyle(fontSize: 12)),
                      ),
                      onTap: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).pushNamed('/liste');
                      },
                    );
                  },
                ),

                ExpansionTile(
                  leading: Icon(Icons.book),
                  title: Text('Ventes'),
                  children: <Widget>[
                    DrawerItem(
                      icon: Icons.dashboard,
                      text: 'Enregistrer une vente',
                      onTap: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).pushNamed('/saveVente');
                      },
                    ),
                    DrawerItem(
                      icon: Icons.dashboard,
                      text: 'Liste des ventes',
                      onTap: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).pushNamed('/listevente');
                      },
                    ),
                  ],
                ),

                ExpansionTile(
                  leading: Icon(Icons.book),
                  title: Text('Membres'),
                  children: <Widget>[
                    DrawerItem(
                      icon: Icons.dashboard,
                      text: 'Enregistrer un membre',
                      onTap: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).pushNamed('/saveVente');
                      },
                    ),
                    DrawerItem(
                      icon: Icons.dashboard,
                      text: 'Enregistrer une cotisation',
                      onTap: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).pushNamed('/listevente');
                      },
                    ),

                    DrawerItem(
                      icon: Icons.dashboard,
                      text: 'Liste des membres',
                      onTap: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).pushNamed('/listevente');
                      },
                    ),
                  ],
                ),


                DrawerItem(
                  icon: Icons.flag,
                  text: 'Challenges',
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pushNamed('/challenges');
                  },
                ),
                ExpansionTile(
                  leading: Icon(Icons.book),
                  title: Text('Classes'),
                  children: <Widget>[
                    DrawerItem(
                      icon: Icons.dashboard,
                      text: 'Maths',
                      onTap: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).pushNamed('/classes/maths');
                      },
                    ),
                    DrawerItem(
                      icon: Icons.dashboard,
                      text: 'English',
                      onTap: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).pushNamed('/classes/english');
                      },
                    ),
                    DrawerItem(
                      icon: Icons.dashboard,
                      text: 'Economics',
                      onTap: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).pushNamed('/classes/economics');
                      },
                    ),
                    DrawerItem(
                      icon: Icons.dashboard,
                      text: 'Accounts',
                      onTap: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).pushNamed('/classes/accounts');
                      },
                    ),
                  ],
                ),
                DrawerItem(
                  icon: Icons.schedule,
                  text: 'Timetable',
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pushNamed('/timetable');
                  },
                ),
                DrawerItem(
                  icon: Icons.notifications,
                  text: 'Notifications',
                  trailing: CircleAvatar(
                    radius: 10,
                    child: Text('8', style: TextStyle(fontSize: 12)),
                  ),
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pushNamed('/notifications');
                  },
                ),
                DrawerItem(
                  icon: Icons.upload_file,
                  text: 'Upload new class',
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pushNamed('/welcome');
                  },
                ),
                DrawerItem(
                  icon: Icons.logout,
                  text: 'Déconnexion',
                  onTap: () {
                    Navigator.of(context).pop();
                    _signOut(context);
                  },
                ),
              ],
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Stack(
                  children: [
                    Container(
                      height: 250,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/background.jpg'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 50, 16, 16),
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 50,
                            backgroundImage: AssetImage('assets/images/logo-e-pdci.png'),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'E-PDCI',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Le portail Digital',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),

                          ),
                          Text(
                            'du PDCI-RDA ',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),

                          ),
                          SizedBox(height: 20),
                          Card(
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Icon(Icons.monetization_on, color: Colors.blue, size: 24),
                                      SizedBox(width: 10),
                                      Text(
                                        '1.500',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    'How to earn coins?',
                                    style: TextStyle(
                                      color: Colors.blue,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          Wrap(
                            spacing: 20,
                            runSpacing: 20,
                            children: [
                              FutureBuilder<int>(
                                future: _getCombinedTotalRecords(userId),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState == ConnectionState.waiting) {
                                    return CircularProgressIndicator();
                                  }
                                  if (snapshot.hasError) {
                                    return Text('Erreur: ${snapshot.error}');
                                  }
                                  int combinedTotalRecords = snapshot.data ?? 0;
                                  return GestureDetector(
                                    onTap: () {
                                      // Action à effectuer lorsque l'utilisateur tape sur le GestureDetector
                                    },
                                    child: StatCard(
                                      title: 'Total inscrit',
                                      value: '$combinedTotalRecords',
                                      icon: Icons.add_chart,
                                      color: Colors.purple[100]!,
                                    ),
                                  );
                                },
                              ),
                              FutureBuilder<int>(
                                future: _getUserTotalRecords(userId),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState == ConnectionState.waiting) {
                                    return CircularProgressIndicator();
                                  }
                                  if (snapshot.hasError) {
                                    return Text('Erreur: ${snapshot.error}');
                                  }
                                  int userTotalRecords = snapshot.data ?? 0;
                                  return GestureDetector(
                                    onTap: () {
                                      // Action à effectuer lorsque l'utilisateur tape sur le GestureDetector
                                    },
                                    child: StatCard(
                                      title: 'Mes inscrits',
                                      value: '$userTotalRecords',
                                      icon: Icons.person,
                                      color: Colors.green[100]!,
                                    ),
                                  );
                                },
                              ),
                              GestureDetector(
                                onTap: () => Navigator.pushNamed(context, '/time'),
                                child: StatCard(
                                  title: 'Time',
                                  value: '1h 23m',
                                  icon: Icons.access_time,
                                  color: Colors.blue[100]!,
                                ),
                              ),
                              GestureDetector(
                                onTap: () => Navigator.pushNamed(context, '/skills'),
                                child: StatCard(
                                  title: 'Skills',
                                  value: '1.500',
                                  icon: Icons.military_tech,
                                  color: Colors.pink[100]!,
                                ),
                              ),
                             GestureDetector(
                                onTap: () => Navigator.pushNamed(context, '/games'),
                                child: StatCard(
                                  title: 'Games',
                                  value: '28',
                                  icon: Icons.videogame_asset,
                                  color: Colors.yellow[100]!,
                                ),
                              ),

                              SizedBox(height: 20),

                              FutureBuilder<int>(
                                future: _getTotalRecords(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState == ConnectionState.waiting) {
                                    return CircularProgressIndicator();
                                  }
                                  if (snapshot.hasError) {
                                    return Text('Erreur: ${snapshot.error}');
                                  }
                                  int totalRecords = snapshot.data ?? 0;
                                  return GestureDetector(
                                    onTap: () {
                                      // Action à effectuer lorsque l'utilisateur tape sur le GestureDetector
                                    },
                                    child: StatCard(
                                      title: 'Total Records',
                                      value: '$totalRecords',
                                      icon: Icons.insert_chart,
                                      color: Colors.blue[100]!,
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Recommended games',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GameCategory(
                            title: 'Survival',
                            color: Colors.red[100]!,
                            icon: FontAwesomeIcons.star,
                          ),
                          GameCategory(
                            title: 'Action',
                            color: Colors.orange[100]!,
                            icon: FontAwesomeIcons.chartPie,
                          ),
                          GameCategory(
                            title: 'Collector',
                            color: Colors.blue[100]!,
                            icon: FontAwesomeIcons.medal,
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Text(
                        'More popular above',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.of(context).pushNamed('/form');
            },
            child: Icon(Icons.add),
          ),
        );
      },
    );
  }
}



