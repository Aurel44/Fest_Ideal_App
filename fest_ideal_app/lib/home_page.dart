// ignore_for_file: avoid_print

import 'package:fest_ideal_app/programme_page.dart';
import 'package:flutter/material.dart';
import 'login_page.dart';
import 'map_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  PageController pageController = PageController();

  void onTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    pageController.animateToPage(index,
        duration: const Duration(milliseconds: 1000), curve: Curves.easeIn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ze Fest'Ideal"),
        backgroundColor: Colors.green[800],
      ),
      body: PageView(controller: pageController, children: const [
        ProgrammePage(),
        MapPage(),
        LoginPage(),
      ]),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'home'),
          BottomNavigationBarItem(icon: Icon(Icons.map), label: 'map'),
          BottomNavigationBarItem(icon: Icon(Icons.login), label: 'login')
        ],
        currentIndex: _selectedIndex,
        backgroundColor: Colors.green[800],
        selectedItemColor: Colors.yellow[800],
        unselectedItemColor: Colors.white,
        onTap: onTapped,
      ),
    );
  }
}
