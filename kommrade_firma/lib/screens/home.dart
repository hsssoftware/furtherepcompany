import 'package:flutter/material.dart';
import 'package:kommrade_firma/screens/anasayfa_screen.dart';
import 'package:kommrade_firma/screens/favoriler_screen.dart';
import 'package:kommrade_firma/screens/profil_screen.dart';
import 'package:kommrade_firma/screens/talep_ekle_screen.dart';
import 'package:kommrade_firma/screens/talep_screen.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeState();
}

class _HomeState extends State with SingleTickerProviderStateMixin {
  int selectedPage = 0;
  final _pageOptions = [
    AnasayfaScreen(),
    TalepScreen(),
    TalepEkleScreen(),
    FavorilerScreen(),
    ProfilScreen()
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: 
      ConvexAppBar(
        backgroundColor: Color.fromRGBO(10, 39, 97, 1),
        height: 90.0,

        items: [
          TabItem(icon: Icons.home, title: 'Anasayfa',activeIcon: Icons.home),
          TabItem(icon: Icons.business_center, title: 'Taleplerim'),
          TabItem(
            icon: Icons.add_circle,
            title: 'Talep Ekle'
          ),
          TabItem(icon: Icons.local_activity, title: 'Favoriler'),
          TabItem(icon: Icons.person, title: 'Profil'),
        ],
        initialActiveIndex: 0,
        onTap: (int i) {
          setState(() {
            selectedPage = i;
          });
        },
      ),
      body: _pageOptions[selectedPage],
    );
  }
}
