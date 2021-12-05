// ignore_for_file: avoid_print, unused_catch_clause

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AddBand extends StatefulWidget {
  const AddBand({Key? key}) : super(key: key);

  @override
  _AddBandState createState() => _AddBandState();
}

class _AddBandState extends State<AddBand> {
  TextEditingController tecName = TextEditingController();
  TextEditingController tecMusicStyle = TextEditingController();

  final _addFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _addBand(),
    );
  }

  Widget _addBand() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        key: _addFormKey,
        child: Column(
          children: <Widget>[
            TextField(
              controller: tecName,
              decoration: const InputDecoration(
                label: Text('Nom du Groupe'),
                prefixIcon: Icon(Icons.group),
              ),
            ),
            TextField(
              controller: tecMusicStyle,
              decoration: const InputDecoration(
                  label: Text('Style de Musique'),
                  prefixIcon: Icon(Icons.audiotrack)),
            ),
            ElevatedButton(
                onPressed: _addBandToDB,
                child: const Text('Ajouter'),
                style: ElevatedButton.styleFrom(
                    primary: Colors.green[800],
                    padding: const EdgeInsets.all(8.0))),
          ],
        ),
      ),
    );
  }

  void _addBandToDB() async {
    //Récupération des champs
    String name = tecName.text;
    String musicstyle = tecMusicStyle.text;

    print(name + " " + musicstyle);

    //Appel de la variable d'envirronnement
    var url = (dotenv.env['API_URL']).toString() + 'bands/';

    //Préparation de la requête à énvoyer au serveur
    try {
      var responseRegister = await http.post(Uri.parse(url),
          body: {"name": name, "music_style": musicstyle});
      if (responseRegister.statusCode == 200) {
        //Informer l'utilisateur du succès de la requête

        SnackBar snackBarSuccess =
            const SnackBar(content: Text("Groupe ajouté"));
        ScaffoldMessenger.of(context).showSnackBar(snackBarSuccess);

        //Clear TextField
        tecName.clear();
        tecMusicStyle.clear();
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
