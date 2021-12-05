// ignore_for_file: avoid_print, unused_catch_clause

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Deleteband extends StatefulWidget {
  const Deleteband({Key? key}) : super(key: key);

  @override
  _DeletebandState createState() => _DeletebandState();
}

class _DeletebandState extends State<Deleteband> {
  late String selectedValue = listBands[0];
  List<String> listBands = [];

  @override
  void initState() {
    super.initState();
    getBands();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: <Widget>[
        Center(
          child: DropdownButton(
              value: selectedValue,
              items: listBands.map((value) {
                return DropdownMenuItem(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (dynamic value) {
                setState(() {
                  selectedValue = value;
                });
              }),
        ),
        Center(
          child: ElevatedButton(
              onPressed: () => {deleteBand(selectedValue)},
              child: const Text('Suprimer'),
              style: ElevatedButton.styleFrom(
                  primary: Colors.green[800],
                  padding: const EdgeInsets.all(8.0))),
        ),
      ],
    ));
  }

  Future getBands() async {
    var url = (dotenv.env['API_URL']).toString() + 'bands/';
    try {
      var responseRegister = await http.get(Uri.parse(url),
          headers: {"auth-token": (dotenv.env['JWT_TOKEN_USER']).toString()});
      if (responseRegister.statusCode == 200) {
        var response = json.decode(responseRegister.body);
        setState(() {
          for (var i = 0; i < response.length; i++) {
            listBands.add(response[i]["name"].toString());
          }
        });
        print(listBands);
      } else if (responseRegister.statusCode > 0) {
        //Si le serveur répond autre chose que 200 alors on affiche le status
        print(responseRegister.body);
        SnackBar snackBarFailure = SnackBar(
            content:
                Text("erreur : " + responseRegister.statusCode.toString()));
        ScaffoldMessenger.of(context).showSnackBar(snackBarFailure);
      }
    } on SocketException catch (socketException) {
      //On affiche un message lorsque le serveur est inatteignable (erreur de connexion
      // ignore: unnecessary_new
      SnackBar snackBarFailure = const SnackBar(
          content: Text("Nous avons des difficultés à joindre le serveur"));
      ScaffoldMessenger.of(context).showSnackBar(snackBarFailure);
    }
  }

  deleteBand(name) async {
    var url = (dotenv.env['API_URL']).toString() + 'bands/:'+name;
    try {
      var responseRegister = await http.delete(Uri.parse(url),
          headers: {"auth-token": (dotenv.env['JWT_TOKEN_USER']).toString()},
          body: {"name ": name});
      if (responseRegister.statusCode == 200) {
        SnackBar snackBarSuccess =
            const SnackBar(content: Text("Groupe supprimé"));
        ScaffoldMessenger.of(context).showSnackBar(snackBarSuccess);
        print(listBands);
      } else if (responseRegister.statusCode > 0) {
        //Si le serveur répond autre chose que 200 alors on affiche le status
        print(responseRegister.body);
        SnackBar snackBarFailure = SnackBar(
            content:
                Text("erreur : " + responseRegister.statusCode.toString()));
        ScaffoldMessenger.of(context).showSnackBar(snackBarFailure);
      }
    } on SocketException catch (socketException) {
      //On affiche un message lorsque le serveur est inatteignable (erreur de connexion
      // ignore: unnecessary_new
      SnackBar snackBarFailure = const SnackBar(
          content: Text("Nous avons des difficultés à joindre le serveur"));
      ScaffoldMessenger.of(context).showSnackBar(snackBarFailure);
    }
  }
}
