// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:therhappy/pages/home_page.dart';
import 'package:therhappy/pages/journal.dart';
import 'package:therhappy/pages/profile.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int _currentIndex = 0;
  List<Widget> pages = [
    HomePage(),
    Text(
      "Progress",
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
    ),
    Text(
      "Chat",
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
    ),
    Journal(),
    Profile(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: pages[_currentIndex],
      ),
      bottomNavigationBar: NavigationBar(
        backgroundColor: Colors.transparent,
        animationDuration: Duration(seconds: 1),
        labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
        selectedIndex: _currentIndex,
        onDestinationSelected: (int newIndex) {
          setState(() {
            _currentIndex = newIndex;
          });
        },
        destinations: [
          NavigationDestination(
              selectedIcon: Icon(Icons.home),
              icon: Icon(Icons.home_filled),
              label: "Home"),
          NavigationDestination(
              selectedIcon: Icon(
                CupertinoIcons.graph_circle,
              ),
              icon: Icon(
                CupertinoIcons.graph_circle,
              ),
              label: "Progress"),
          NavigationDestination(
              selectedIcon: Icon(
                CupertinoIcons.chat_bubble,
              ),
              icon: Icon(
                CupertinoIcons.chat_bubble,
              ),
              label: "Chat"),
          NavigationDestination(
              selectedIcon: Image.asset('assets/images/scroll-text.png'),
              icon: Image.asset(
                'assets/images/scroll-text.png',
                color: Colors.white,
              ),
              label: "Journal"),
          NavigationDestination(
              selectedIcon: Icon(CupertinoIcons.profile_circled),
              icon: Icon(CupertinoIcons.profile_circled),
              label: "Profile"),
        ],
      ),
    );
  }
}
