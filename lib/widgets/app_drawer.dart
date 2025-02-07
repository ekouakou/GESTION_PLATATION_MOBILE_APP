import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/menu_config.dart';
import '../utils/theme_provider.dart';
import '../models/menu_item.dart';
import 'drawer_item.dart';

class AppDrawer extends StatelessWidget {
  final String userEmail;
  final Function(BuildContext) signOut;
  final String userId;
  final Future<int> Function(String) getCombinedTotalRecords;

  const AppDrawer({
    Key? key,
    required this.userEmail,
    required this.signOut,
    required this.userId,
    required this.getCombinedTotalRecords,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          _buildDrawerHeader(context),
          _buildMenuItems(context),
        ],
      ),
    );
  }

  Widget _buildDrawerHeader(BuildContext context) {
    return DrawerHeader(
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
                userEmail,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItems(BuildContext context) {
    return FutureBuilder<List<MenuItem>>(
      future: loadMenuItems(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }

        return Column(
          children: snapshot.data!.map((item) => _buildMenuItem(context, item)).toList(),
        );
      },
    );
  }

  Widget _buildMenuItem(BuildContext context, MenuItem item) {
    if (item.children != null && item.children!.isNotEmpty) {
      return ExpansionTile(
        leading: Icon(item.icon),
        title: Text(item.title),
        children: item.children!
            .map((child) => DrawerItem(
          icon: child.icon,
          text: child.title,
          onTap: () {
            Navigator.of(context).pop();
            Navigator.of(context).pushNamed(child.route ?? '/');
          },
        ))
            .toList(),
      );
    }

    if (item.id == 'theme_toggle') {
      return DrawerItem(
        icon: item.icon,
        text: context.watch<ThemeProvider>().isDarkMode ? 'Mode clair' : 'Mode sombre',
        onTap: () => context.read<ThemeProvider>().toggleTheme(),
      );
    }

    if (item.id == 'logout') {
      return DrawerItem(
        icon: item.icon,
        text: item.title,
        onTap: () => signOut(context),
      );
    }

    if (item.id == 'liste_inscrit') {
      return FutureBuilder<int>(
        future: getCombinedTotalRecords(userId),
        builder: (context, snapshot) {
          return DrawerItem(
            icon: item.icon,
            text: item.title,
            trailing: CircleAvatar(
              radius: 10,
              child: Text('${snapshot.data ?? 0}', style: TextStyle(fontSize: 12)),
            ),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushNamed(item.route ?? '/');
            },
          );
        },
      );
    }

    return DrawerItem(
      icon: item.icon,
      text: item.title,
      onTap: () {
        Navigator.of(context).pop();
        Navigator.of(context).pushNamed(item.route ?? '/');
      },
    );
  }
}