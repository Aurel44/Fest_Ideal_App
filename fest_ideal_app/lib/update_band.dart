import 'package:flutter/material.dart';

class UpdateBand extends StatefulWidget {
  const UpdateBand({ Key? key }) : super(key: key);

  @override
  _UpdateBandState createState() => _UpdateBandState();
}

class _UpdateBandState extends State<UpdateBand> {
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
    return Center(
      child: Form(
        key: _addFormKey,
        child: Column(
          children: <Widget>[
            TextField(
              controller: tecName,
              decoration: const InputDecoration(
                label: Text('Email'),
                prefixIcon: Icon(Icons.group),
              ),
            ),
            TextField(
              controller: tecMusicStyle,
              textInputAction: TextInputAction.done,
              obscureText: true,
              decoration: const InputDecoration(
                  label: Text('Mot de Passe'), prefixIcon: Icon(Icons.audiotrack)),
            ),
            const Spacer(),
            ElevatedButton(
                onPressed: () {},
                child: const Text('Ajouter'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.green[800],
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                )),
          ],
        ),
      ),
    );
  }
}