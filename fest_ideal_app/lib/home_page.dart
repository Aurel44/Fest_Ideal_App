import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'Models/band.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController tecMessage = TextEditingController();

  List<Band> listeBands = List.empty();

  @override
  void initState() {
    super.initState();
    _getBands();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Demo Liste")),
      body: Column(
        children: [_buildListView()],
      ),
    );
  }

  Expanded _buildListView() {
    return Expanded(
      child: ListView.separated(
        itemCount: listeBands.length,
        separatorBuilder: (context, index) => const Divider(),
        itemBuilder: (context, index) {
          return ListTile(
            title: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(listeBands[index].name),
              ],
            ),
            subtitle: Text(
              listeBands[index].musicstyle,
            ),
          );
        },
      ),
    );
  }

  _getBands() async {
    var url = 'http://10.0.2.2:3000/api/bands';
    var jwt = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2MTliZjQ3MzAzZGU4ZWEwYTkwNzk3MjEiLCJpYXQiOjE2Mzc2MTMyMTV9.qa8TxbyrgFWM6W48av0VTHItW5kGcPBjaG_jAGNW5iI";
    var responseBands =
        await http.get(Uri.parse(url), headers: <String, String>{"auth-token": "" + jwt});
    if (responseBands.statusCode == 200) {
      print("hello World");
      Iterable mapBands = jsonDecode(responseBands.body);
      listeBands = mapBands.map((i) => Band.fromJson(i)).toList();
      _reloadListView(listeBands);
    } else {
      print("Pas bon..");
      print(responseBands.statusCode);
    }
  }

  _reloadListView(List<Band> bands) {
    setState(() {
      listeBands = bands;
    });
  }
}
