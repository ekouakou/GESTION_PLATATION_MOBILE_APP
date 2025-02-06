import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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

        return Scaffold(
          appBar: AppBar(
            title: Text('Dashboard'),
          ),
          drawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                DrawerHeader(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFF007D3C), Color(0xFF005F2E)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: Row(
                    children: [
                      const CircleAvatar(
                        radius: 30,
                        backgroundImage: AssetImage('assets/images/logo-e-pdci.png'),
                        backgroundColor: Color(0xFFF1F6F9),
                      ),
                      SizedBox(width: 10),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'e.PDCI-Mobile',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                            ),
                          ),
                          Text(
                            user.email ?? 'Email non disponible',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                _buildDrawerItem(
                  context,
                  icon: Icons.dashboard,
                  text: 'Dashboard',
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pushReplacementNamed('/dashboard');
                  },
                ),
                _buildDrawerItem(
                  context,
                  icon: Icons.add,
                  text: 'Nouvel électeur',
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pushReplacementNamed('/form');
                  },
                ),


                _buildDrawerItem(
                  context,
                  icon: Icons.dashboard,
                  text: 'Guide utilisateur',
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pushReplacementNamed('/guide_utilisateur');
                  },
                ),

                FutureBuilder<int>(
                  future: _getCombinedTotalRecords(userId),
                  builder: (context, snapshot) {
                    int totalRecords = snapshot.data ?? 0;
                    return _buildDrawerItem(
                      context,
                      icon: Icons.list,
                      text: 'Liste des inscrits',
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
                _buildDrawerItem(
                  context,
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
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/background.jpg'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: GridView(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          childAspectRatio: 1.5,
                        ),
                        children: [
                          FutureBuilder<int>(
                            future: _getCombinedTotalRecords(userId),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState != ConnectionState.done) {
                                return SizedBox(); // Return an empty widget
                              }
                              if (snapshot.hasError) {
                                return Text('Erreur: ${snapshot.error}');
                              }
                              int combinedTotalRecords = snapshot.data ?? 0;
                              return GestureDetector(
                                onTap: () {
                                  // Action à effectuer lorsque l'utilisateur tape sur le GestureDetector
                                },
                                child: StatCard2(
                                  title: 'Total des inscriptions',
                                  count: combinedTotalRecords,
                                  percentage: 15,
                                  change: 0.5,
                                  gradient: LinearGradient(
                                    colors: [Color(0xFF007D3C), Color(0xFF005F2E)],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  textColor: Colors.white,
                                ),
                              );
                            },
                          ),
                          FutureBuilder<int>(
                            future: _getUserTotalRecords(userId),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState != ConnectionState.done) {
                                return SizedBox(); // Return an empty widget
                              }
                              if (snapshot.hasError) {
                                return Text('Erreur: ${snapshot.error}');
                              }
                              int userTotalRecords = snapshot.data ?? 0;
                              return GestureDetector(
                                onTap: () {
                                  // Action à effectuer lorsque l'utilisateur tape sur le GestureDetector
                                },
                                child: StatCard2(
                                  title: 'Mes inscrits',
                                  count: userTotalRecords,
                                  percentage: 15,
                                  change: 0.5,
                                  gradient: LinearGradient(
                                    colors: [Color(0xFFCC9B21), Color(0xFFCC9B21)],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  textColor: Colors.white,
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              Navigator.of(context).pushNamed('/form');
            },
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            icon: Icon(Icons.add),
            label: Text("Nouvel électeur"),
          ),
        );
      },
    );
  }

  Widget _buildDrawerItem(
      BuildContext context, {
        required IconData icon,
        required String text,
        VoidCallback? onTap,
        Widget? trailing,
      }) {
    return ListTile(
      leading: Icon(icon),
      title: Text(text),
      trailing: trailing,
      onTap: onTap,
    );
  }
}


class StatCard2 extends StatelessWidget {
  final String title;
  final int count;
  final double percentage;
  final double change;
  final Gradient gradient;
  final Color textColor;

  StatCard2({
    required this.title,
    required this.count,
    required this.percentage,
    required this.change,
    required this.gradient,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: textColor,
                  fontSize: 16,
                ),
              ),
              Spacer(),
              Text(
                '$count',
                style: TextStyle(
                  color: textColor,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
