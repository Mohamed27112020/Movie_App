import 'package:flutter/material.dart';
import 'package:movie_app/Views/Home.dart';
import 'package:movie_app/Views/Settings.dart';
import 'package:movie_app/Views/searchscreen.dart';

import 'package:movie_app/Views/watchlistscreen.dart';

class Mainscreen extends StatefulWidget {
  @override
  State<Mainscreen> createState() => _MainAppWithWatchlistState();
}

class _MainAppWithWatchlistState extends State<Mainscreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    MovieScreen(),
    SearchScreen(),
    WatchlistScreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Color(0xFF2E2E3F),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(0),
            topRight: Radius.circular(0),
          ),
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          backgroundColor: Colors.transparent,
          selectedItemColor: Color(0xFF12CDD9),
          unselectedItemColor: Colors.grey[600],
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
            BottomNavigationBarItem(
              icon: Icon(Icons.bookmark),
              label: 'Watch list',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Settings',
            ),
          ],
        ),
      ),
    );
  }
}
