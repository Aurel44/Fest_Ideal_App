import 'package:fest_ideal_app/update_band.dart';
import 'package:flutter/material.dart';

import 'add_band.dart';
import 'delete_band.dart';

class BandsPage extends StatefulWidget {
  const BandsPage({Key? key}) : super(key: key);

  @override
  _BandsPageState createState() => _BandsPageState();
}

class _BandsPageState extends State<BandsPage> {
  int _selectedIndex = 0;
  PageController adminPageController = PageController();

  void onTappedAdmin(int index) {
    setState(() {
      _selectedIndex = index;
    });
    adminPageController.animateToPage(index,
        duration: const Duration(milliseconds: 100), curve: Curves.easeIn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(controller: adminPageController, children: const [
        AddBand(),
        UpdateBand(),
        Deleteband(),
      ]),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.plus_one), label: 'Add'),
          BottomNavigationBarItem(icon: Icon(Icons.update), label: 'Update'),
          BottomNavigationBarItem(icon: Icon(Icons.delete), label: 'Delete')
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        onTap: onTappedAdmin,
      ),
    );
  }
}
