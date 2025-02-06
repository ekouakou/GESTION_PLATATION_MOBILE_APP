import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'choix_inscrption.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WelcomePage(),
      routes: {
        '/choixinscription': (context) => ChoixInscriptionPage(),
        // Ajoutez d'autres routes ici si nécessaire
      },
    );
  }
}

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Partie fixe du haut
          Container(
            height: 250,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/background.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 50),
                  const CircleAvatar(
                    radius: 35,
                    backgroundImage: AssetImage('assets/images/logo-e-pdci.png'),
                    backgroundColor: Color(0xFFF1F6F9),
                  ),
                  SizedBox(height: 10),
                  const Text(
                    'Bienvenue sur votre plateforme',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  const Text(
                    'e.PDCI-Mobile',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    "L'information officielle du PDCI-RDA, \n au creux de votre main.",
                    textAlign: TextAlign.center,
                    //'Le portail Digital mobile du PDCI-RDA',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Partie scrollable pour la liste des cartes
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Wrap(
                    spacing: 20,
                    runSpacing: 20,
                    children: [
                      const CustomAppCard(
                        icon: Icons.groups,
                        title: 'Recensement nouveaux électeurs',
                        subtitle: 'Apprends l\'anglais et plus',
                        btn: 'S\'inscrire',
                        description:
                        'Rejoignez le mouvement pour la reconquête du pouvoir en 2025 ! La route vers 2025 passe par des élections démocratiques, libres et transparentes, conformes aux standards internationaux. Pour garantir une participation massive, le PDCI-RDA s\'est fixé pour objectif de mobiliser 4 millions de nouveaux électeurs sur les listes électorales. Vous êtes en âge de voter mais pas encore inscrit ? Le PDCI-RDA est là pour vous aider.',
                        link: '/choixinscription',
                        exnternlink:false,
                        gradientColors: [Colors.blue, Colors.green],
                        buttonColor: Colors.orange,
                        buttonBorderRadius: 5,
                        //onTap: () => Navigator.pushNamed(context, '/choixinscription'), // Redirection
                      ),

                      const CustomAppCard(
                        icon: Icons.person_add,
                        title: 'Adhérer au parti',
                        subtitle: 'Actualités',
                        btn: 'Adhérer',
                        description:
                        'Déjà inscrit et prêt pour 2025 ? Engagez-vous activement avec le PDCI-RDA !',
                        link: 'https://adhesion.pdcirda.ci/bienvenue',
                        exnternlink:true,
                        gradientColors: [Colors.pink, Colors.purple],
                        buttonColor: Colors.blue,
                        buttonBorderRadius: 5,
                      ),

                      const CustomAppCard(
                        icon: Icons.redeem,
                        title: 'Faire un don',
                        subtitle: 'Actualités',
                        btn: 'Donner',
                        description:
                        'Faites un don pour soutenir les personnes dans le besoin en cliquant ici.',
                        link: 'https://pdcirda.ci/toussurlalisteelectorale.html',
                        exnternlink:true,
                        gradientColors: [Colors.red, Colors.orange],
                        buttonColor: Colors.green,
                        buttonBorderRadius: 5,
                      ),
                      const CustomAppCard(
                        icon: Icons.language,
                        title: 'Site internet',
                        subtitle: 'Sports',
                        btn: 'Visiter',
                        description:
                        'Pour plus d\'informations sur le PDCI-RDA, visitez le site du parti.',
                        link: 'https://pdcirda.ci/',
                        exnternlink:true,
                        gradientColors: [Colors.teal, Colors.cyan],
                        buttonColor: Colors.purple,
                        buttonBorderRadius: 5,
                      ),

                      SizedBox(height: 00),
                      Center(
                        child: Column(
                          children: [
                            const Text(
                              'Développé par',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                            SizedBox(height: 5),
                            Image.asset('assets/images/logo.png', height: 20), // Assurez-vous d'ajouter le logo du développeur dans ce chemin
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomAppCard extends StatefulWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final String btn;
  final String description;
  final String link;
  final bool exnternlink;
  final VoidCallback? onTap;
  final List<Color> gradientColors; // Couleurs du dégradé pour l'icône
  final Color buttonColor; // Couleur de fond du bouton
  final double buttonBorderRadius; // Rayon d'arrondi du bouton

  const CustomAppCard({
    Key? key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.btn,
    required this.description,
    required this.link,
    this.onTap,
    required this.exnternlink,
    required this.gradientColors,
    required this.buttonColor,
    required this.buttonBorderRadius,
  }) : super(key: key);

  @override
  _CustomAppCardState createState() => _CustomAppCardState();
}

class _CustomAppCardState extends State<CustomAppCard> {
  bool _isExpanded = false;
  final int _descriptionLimit = 50;

  void _toggleExpand() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  void _launchURL() async {
    final Uri uri = Uri.parse(widget.link);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch ${widget.link}';
    }
  }

  @override
  Widget build(BuildContext context) {
    bool _showExpandButton = widget.description.length > _descriptionLimit;
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: widget.gradientColors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(18), // Bordure arrondie
      ),
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 1, horizontal: 1),
        elevation: 0, // Retirer l'ombre
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18), // Angles arrondis
        ),
        color: Colors.white, // Couleur de fond de la carte
        child: InkWell(
          onTap: widget.onTap, // Ajouter la fonctionnalité de redirection
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ShaderMask(
                  shaderCallback: (bounds) => LinearGradient(
                    colors: widget.gradientColors,
                    tileMode: TileMode.mirror,
                  ).createShader(bounds),
                  child: Icon(widget.icon, size: 40, color: Colors.white),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.title.toUpperCase(),
                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 2),
                      /*Text(
                        widget.subtitle,
                        style: TextStyle(color: Colors.grey[600]),
                      ),*/
                      Text(
                        _isExpanded || ! _showExpandButton
                            ? widget.description
                            : widget.description.length > _descriptionLimit
                            ? widget.description.substring(0, _descriptionLimit) + '...'
                            : widget.description,
                      ),
                      /*SizedBox(height: 10),
                      _isExpanded
                          ? Text(widget.description)
                          : Text(
                        widget.description.length > 50
                            ? widget.description.substring(0, 50) + '...'
                            : widget.description,
                      ),*/

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          if (_showExpandButton)
                          TextButton(
                            onPressed: _toggleExpand,
                            child: Text(_isExpanded ? 'Voir moins' : 'Voir plus'),
                          ),
                          if (!_showExpandButton)
                            TextButton(
                              onPressed: _toggleExpand,
                              child: Text(_isExpanded ? '' : ''),
                            ),

                          if(!widget.exnternlink)

                            ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pushReplacementNamed('/choixinscription');
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.grey[200],
                                padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0), // Réduire l'espace interne du bouton
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(widget.buttonBorderRadius), // Rayon d'arrondi du bouton
                                ),
                                minimumSize: Size(25, 25), // Taille minimale du bouton
                                elevation: 0, // Retirer l'ombre
                              ),
                              child: Text(widget.btn,
                                style: TextStyle(
                                  fontSize: 11.0,
                                  color: Colors.black,
                                ),),
                            ),
                          if(widget.exnternlink)
                            ElevatedButton(
                              onPressed: widget.onTap ?? _launchURL,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.grey[200],
                                padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0), // Réduire l'espace interne du bouton
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(widget.buttonBorderRadius), // Rayon d'arrondi du bouton
                                ),
                                minimumSize: Size(25, 25), // Taille minimale du bouton
                                elevation: 0, // Retirer l'ombre
                              ),
                              child: Text(
                                widget.btn,
                                style: TextStyle(
                                  fontSize: 11.0,
                                  color: Colors.black,
                                ),
                              ),
                            )

                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
