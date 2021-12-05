import 'package:flutter/material.dart';
import 'admin_homepage.dart';
import 'bands_page.dart';
import 'logout.dart';
import 'scene_page.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({Key? key}) : super(key: key);

  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  int _selectedIndex = 0;
  PageController adminPageController = PageController();

  void onTappedAdmin(int index) {
    setState(() {
      _selectedIndex = index;
    });
    adminPageController.animateToPage(index,
        duration: const Duration(milliseconds: 1000), curve: Curves.easeIn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ze Fest'Ideal"),
        backgroundColor: Colors.green[800],
      ),
      body: PageView(controller: adminPageController, children: const [
        AdminHomepage(),
        BandsPage(),
        ScenePage(),
        LogOut(),
      ]),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.group), label: 'Group'),
          BottomNavigationBarItem(icon: Icon(Icons.place), label: 'Scene'),
          BottomNavigationBarItem(icon: Icon(Icons.logout), label: 'Logout')
        ],
        currentIndex: _selectedIndex,
        backgroundColor: Colors.green[700],
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        onTap: onTappedAdmin,
      ),
    );
  }
}
