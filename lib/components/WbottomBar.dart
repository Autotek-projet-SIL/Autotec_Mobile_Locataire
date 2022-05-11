//import 'package:autoteck/DemandeVehicule/historique.dart';
//import 'package:autoteck/DemandeVehicule/profile.dart';
// ignore_for_file: unused_field
// ignore_for_file: file_names

import 'package:flutter/material.dart';




class WidgetBottomBar extends StatefulWidget {
  const WidgetBottomBar({Key? key}) : super(key: key);

  @override
  State<WidgetBottomBar> createState() => _WidgetBottomBarState();
}

class _WidgetBottomBarState extends State<WidgetBottomBar> {

  int _selectedIndex = 0;
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    // Home(),
    // Historique(),
    // Aide(),
    // Profile(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BottomNavigationBar Sample'),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          boxShadow: [
               BoxShadow(
                color: Colors.black12,
                blurRadius: 15,
              ),
          ],
        ),
        child: BottomNavigationBar(

          items:  <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Image.asset('assets/BottomBar/home.png'),
              activeIcon:Image.asset('assets/BottomBar/active-home.png') ,
              label: 'Accueil',

            ),
            BottomNavigationBarItem(
              icon: Image.asset('assets/BottomBar/histo.png'),
              activeIcon:Image.asset('assets/BottomBar/active-histo.png') ,
              label: 'Historique',

            ),
            BottomNavigationBarItem(
              icon: Image.asset('assets/BottomBar/aide.png'),
              activeIcon:Image.asset('assets/BottomBar/active-aide.png') ,
              label: 'Aide',

            ),
            BottomNavigationBarItem(
              icon: Image.asset('assets/BottomBar/profile.png'),
              activeIcon:Image.asset('assets/BottomBar/active-profile.png'),
              label: 'Profile',

            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor:const Color.fromRGBO(27, 146, 164, 0.7),
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
