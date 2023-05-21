import 'package:flutter/material.dart';

import 'package:jabakallah/Home.dart';
import 'dart:core';



void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('\n Authentification'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(' ', style: TextStyle(fontSize: 20)),
                Text('Formulaire client :',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 16.0),
                AuthentificationForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AuthentificationForm extends StatefulWidget {
  const AuthentificationForm({Key? key}) : super(key: key);

  @override
  AuthentificationFormState createState() => AuthentificationFormState();
}

class AuthentificationFormState extends State<AuthentificationForm> {
  // Les contrôleurs pour les champs de texte
  final TextEditingController _nomController = TextEditingController();
  final TextEditingController _prenomController = TextEditingController();
  final TextEditingController _telephoneController = TextEditingController();
  final TextEditingController _passeController = TextEditingController();

  final RegExp _phoneRegex = RegExp(r"^(?:\+212|0)(\d{9})$");
  final RegExp _nameRegex = RegExp(r"^[a-zA-ZÀ-ÿ\-]+$");

  final _formKey = GlobalKey<FormState>(); // GlobalKey for the form

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _nomController,
            decoration: const InputDecoration(
              labelText: 'Nom',
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Veuillez saisir un nom';
              }
              if (!_nameRegex.hasMatch(value)) {
                return 'Veuillez saisir un nom valide';
              }
              return null;
            },
          ),
          const SizedBox(height: 16.0),
          TextFormField(
            controller: _prenomController,
            decoration: const InputDecoration(
              labelText: 'Prénom',
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Veuillez saisir un prénom';
              }
              if (!_nameRegex.hasMatch(value)) {
                return 'Veuillez saisir un prénom valide';
              }
              return null;
            },
          ),
          const SizedBox(height: 16.0),
          TextFormField(
            controller: _telephoneController,
            decoration: const InputDecoration(
              labelText: 'Téléphone',
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Veuillez saisir un numéro de téléphone';
              }
              if (!_phoneRegex.hasMatch(value)) {
                return 'Veuillez saisir un numéro de téléphone marocain valide';
              }
              return null;
            },
          ),
          const SizedBox(height: 16.0),
          TextFormField(
            controller: _passeController,
            decoration: const InputDecoration(
              labelText: 'Email (facultatif)',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 32.0),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                String nom = _nomController.text;
                String prenom = _prenomController.text;
                String telephone = _telephoneController.text;
                String passe = _passeController.text;

                Map<String, dynamic> data = {
                  'nom': nom,
                  'prenom': prenom,
                  'telephone': telephone,
                  'passe': passe,
                };

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Bienvenue'),
                  ),
                );

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Home()),
                );
              }
            },
            child: const Text('Se connecter'),
            style: ElevatedButton.styleFrom(
              primary: Colors.blue,
              textStyle: TextStyle(fontSize: 16),
              padding: EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
