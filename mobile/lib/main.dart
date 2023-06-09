import 'package:flutter/material.dart';
import 'package:jabakallah/Home.dart';
import 'dart:core';
import 'dart:convert';
import 'package:http/http.dart' as http;


import 'ChangePassword.dart';

import 'Home.dart';

class GlobalData {
  static String? email;
  static String? id;
  static String? authToken; // token received from back end 
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      home: MediaQuery(
        data: MediaQueryData(),
        child: Scaffold(
          appBar: AppBar(
            title: const Text('\n Authentification'),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: AuthentificationPage(),
          ),
        ),
      ),
    );
  }
}

class AuthentificationPage extends StatefulWidget {
  const AuthentificationPage({Key? key}) : super(key: key);

  @override
  AuthentificationPageState createState() => AuthentificationPageState();
}

class AuthentificationPageState extends State<AuthentificationPage> {
  // Les contrôleurs pour les champs de texte
  // final TextEditingController _nomController = TextEditingController();
  // final TextEditingController _prenomController = TextEditingController();
  //final TextEditingController _telephoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passeController = TextEditingController();

  //final TextEditingController _nouveauPasseController = TextEditingController();
  //final TextEditingController _confirmerNouveauPasseController = TextEditingController();

  final RegExp _phoneRegex = RegExp(r"^(?:\+212|0)(\d{9})$");
  final RegExp _nameRegex = RegExp(r"^[a-zA-ZÀ-ÿ\-]+$");
  final RegExp _emailRegex = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$");

  final _formKey = GlobalKey<FormState>(); // GlobalKey for the form

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Les champs de texte pour les informations du client
        Text(' ', style: TextStyle(fontSize: 20)),
        Text('Formulaire client :',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16.0),
        Form(
          key: _formKey,
          child: Column(
            children: [
              // TextFormField(
              //   controller: _nomController,
              //   decoration: const InputDecoration(
              //     labelText: 'Nom',
              //     border: OutlineInputBorder(),
              //   ),
              //   validator: (value) {
              //     if (value == null || value.isEmpty) {
              //       return 'Veuillez saisir un nom';
              //     }
              //     if (!_nameRegex.hasMatch(value)) {
              //       return 'Veuillez saisir un nom valide';
              //     }
              //     return null;
              //   },
              // ),
              // const SizedBox(height: 16.0),
              // TextFormField(
              //   controller: _prenomController,
              //   decoration: const InputDecoration(
              //     labelText: 'Prénom',
              //     border: OutlineInputBorder(),
              //   ),
              //   validator: (value) {
              //     if (value == null || value.isEmpty) {
              //       return 'Veuillez saisir un prénom';
              //     }
              //     if (!_nameRegex.hasMatch(value)) {
              //       return 'Veuillez saisir un prénom valide';
              //     }
              //     return null;
              //   },
              // ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez saisir une adresse e-mail';
                  }
                  if (!_emailRegex.hasMatch(value)) {
                    return 'Veuillez saisir une adresse e-mail valide';
                  }
                  return null;
                },
              ),
              // const SizedBox(height: 16.0),
              // TextFormField(
              //   controller: _passeController,
              //   decoration: const InputDecoration(
              //     labelText: 'Email (facultatif)',
              //     border: OutlineInputBorder(),
              //   ),
              // ),
              const SizedBox(height: 32.0),
              TextFormField(
                controller: _passeController,
                decoration: const InputDecoration(
                  labelText: 'Mot de passe',
                  border: OutlineInputBorder(),
                ),
              ),
              // const SizedBox(height: 16.0),
              // TextFormField(
              //   controller: _nouveauPasseController,
              //   decoration: const InputDecoration(
              //     labelText: 'Nouveau mot de passe',
              //     border: OutlineInputBorder(),
              //   ),
              // ),
              // const SizedBox(height: 16.0),
              // TextFormField(
              //   controller: _confirmerNouveauPasseController,
              //   decoration: const InputDecoration(
              //     labelText: 'Confirmer nouveau mot de passe',
              //     border: OutlineInputBorder(),
              //   ),
              //   validator: (value) {
              //     if (value == null || value.isEmpty) {
              //       return 'Veuillez confirmer le nouveau mot de passe';
              //     }
              //     if (value != _nouveauPasseController.text) {
              //       return 'Les mots de passe ne correspondent pas';
              //     }
              //     return null;
              //   },
              // ),
              const SizedBox(height: 16.0),
              // Le bouton pour soumettre le formulaire
              ElevatedButton(
                onPressed: () async {
                  // Vérifier la validité du formulaire
                  if (_formKey.currentState!.validate()) {
                    // Traitement des données saisies
                    // String nom = _nomController.text;
                    // String prenom = _prenomController.text;
                    //String telephone = _telephoneController.text;
                    String email = _emailController.text;
                    String passe = _passeController.text;

                    // Envoyer les données à un service d'ouverture de compte
                    //try {
                    // Créer une instance de Dio

                    // Définir les données à envoyer dans la requête
                    Map<String, dynamic> data = {
                      // 'nom': nom,
                      // 'prenom': prenom,
                      //'telephone': telephone,
                      'username': email,
                      'passe': passe,
                    };

                    // Envoyer la requête POST avec les données 
                    String url = 'http://localhost:8082/auth/authenticate/client';
                    
                    try { 
                    http.Response response = await http.post(Uri.parse(url),headers: {'Content-Type': 'application/json'},  body: json.encode(data),);
                    // Envoyer la requête POST avec les données
                    //String url = 'https://mon-service.com/authentification';


                    Map<String, dynamic> responseData = json.decode(response.body);
                    bool isFirstLogin = responseData['isFirstLogin'];
                    String authToken = responseData['token'];
                    String id = responseData['id'];

                    
                     GlobalData.authToken = authToken;
                    // Vérifier le code de réponse HTTP
                    if (response.statusCode == 200) {
                    // Si la réponse est OK, afficher un message de succès
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Bienvenue'),
                      ),
                    );
                    // Naviguer vers la page "Hello"
                    bool isFirstLogin = false; // pour tester si ca marche
                    GlobalData.email =
                        email; // Stocker la variable email dans GlobalData

                   if (isFirstLogin) {
                   // Si c'est la première connexion, naviguer vers la page ChangePassword
                            Navigator.push(context,MaterialPageRoute(builder: (context) => ChangePassword()),);}
                    else {
                     // Sinon, naviguer vers la page Home
                          Navigator.push(context,MaterialPageRoute(builder: (context) => Home()),);
                         }
                    } else {
                    //Sinon, afficher un message d'erreur avec le code de réponse HTTP
                     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Compte non existant '),),);
                    }
                    
                    } catch (e) {
                    //Afficher un message d'erreur s'il y a une exception
                    ScaffoldMessenger.of(context).showSnackBar(
                     SnackBar(
                      content: Text('Erreur inattendue : $e'),
                    ),
                    );
                    }
                    if (isFirstLogin) {
                      // Si c'est la première connexion, naviguer vers la page ChangePassword
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ChangePassword()),
                      );
                    } else {
                      // Sinon, naviguer vers la page Home
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Home()),
                      );
                    }
                    //} else {
                    // Sinon, afficher un message d'erreur avec le code de réponse HTTP
                    //  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Compte non existant '),),);
                    //}

                    //} catch (e) {
                    // Afficher un message d'erreur s'il y a une exception
                    // ScaffoldMessenger.of(context).showSnackBar(
                    //  SnackBar(
                    //   content: Text('Erreur inattendue : $e'),
                    // ),
                    //);
                    //}
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
        ),
      ],
    );
  }
}
