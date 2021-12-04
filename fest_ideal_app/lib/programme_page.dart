// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'Models/band.dart';

class ProgrammePage extends StatefulWidget {
  const ProgrammePage({Key? key}) : super(key: key);

  @override
  _ProgrammePageState createState() => _ProgrammePageState();
}

class _ProgrammePageState extends State<ProgrammePage> {
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
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Column(
            children: [_buildListView()],
          ),
        ),
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
            title: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(listeBands[index].name),
                ],
              ),
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
    print(dotenv.env['API_URL']);
    var url = (dotenv.env['API_URL']).toString() + 'bands';
    print("hello World1");
    var jwt = dotenv.env['JWT_TOKEN_USER'];
    if (jwt != null) {
      print("hello World2");
      var responseBands = await http.get(Uri.parse(url),
          headers: <String, String>{"auth-token": "" + jwt});
      if (responseBands.statusCode == 200) {
        print("hello World");
        Iterable mapBands = jsonDecode(responseBands.body);
        listeBands = mapBands.map((i) => Band.fromJson(i)).toList();
        _reloadListView(listeBands);
      } else {
        print("Pas bon..");
        print(responseBands.statusCode);
      }
    } else {
      print("pas de jwt");
    }
  }

  _reloadListView(List<Band> bands) {
    setState(() {
      listeBands = bands;
    });
  }
}
