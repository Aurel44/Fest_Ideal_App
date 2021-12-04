// ignore_for_file: prefer_const_constructors, unused_catch_clause

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController tecEmail = TextEditingController();
  TextEditingController tecPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildColumnFields(),
    );
  }

  Widget _buildColumnFields() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 60.0),
      child: Column(
        children: [
          const Spacer(),
          TextField(
            controller: tecEmail,
            decoration: const InputDecoration(
              label: Text('Email'),
              prefixIcon: Icon(Icons.mail),
            ),
          ),
          TextField(
            controller: tecPassword,
            textInputAction: TextInputAction.done,
            obscureText: true,
            decoration: const InputDecoration(
                label: Text('Mot de Passe'), prefixIcon: Icon(Icons.password)),
          ),
          const Spacer(),
          ElevatedButton(
              onPressed: _onLogin,
              child: const Text('SE CONNECTER'),
              style: ElevatedButton.styleFrom(
                primary: Colors.green[800],
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
              )),
          const Spacer()
        ],
      ),
    );
  }

  void _onLogin() async {
    //Récupération des champs
    String email = tecEmail.text;
    String password = tecPassword.text;

    //Préparation de la requête à énvoyer au serveur
    try {
      var responseRegister = await http.post(
          Uri.parse((dotenv.env['API_URL']).toString() + 'user/login'),
          body: {
            "email": email,
            "password": password,
          });
      print(email);
      print(password);
      if (responseRegister.statusCode == 200) {
        //Informer l'utilisateur du succès de la requête

        SnackBar snackBarSuccess =
            const SnackBar(content: Text("Connexion réussie"));
        ScaffoldMessenger.of(context).showSnackBar(snackBarSuccess);

        //Clear TextField
        tecEmail.clear();
        tecPassword.clear();
        _onLoginSuccess(jsonDecode(responseRegister.body)["auth-token"]);
      } else if (responseRegister.statusCode > 0) {
        //Si le serveur répond autre chose que 200 alors on affiche le status
        // ignore: unnecessary_new
        SnackBar snackBarFailure = new SnackBar(
            content:
                Text("erreur : " + responseRegister.statusCode.toString()));
        ScaffoldMessenger.of(context).showSnackBar(snackBarFailure);
      }
    } on SocketException catch (socketException) {
      //On affiche un message lorsque le serveur est inatteignable (erreur de connexion
      // ignore: unnecessary_new
      SnackBar snackBarFailure = new SnackBar(
          content: Text("Nous avons des difficultés à joindre le serveur"));
      ScaffoldMessenger.of(context).showSnackBar(snackBarFailure);
    }
  }

  void _onLoginSuccess(String jwt) {
    var storage = const FlutterSecureStorage();
    storage.write(key: "jwt", value: jwt);
    Navigator.pushNamed(context, '/admin');
  }
}
