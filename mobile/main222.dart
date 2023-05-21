import 'package:flutter/material.dart';
//import 'package:dio/dio.dart';
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
      home: MediaQuery(
        data: MediaQueryData(),
        child: AuthentificationPage(),
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
  final TextEditingController _nomController = TextEditingController();
  final TextEditingController _prenomController = TextEditingController();
  final TextEditingController _telephoneController = TextEditingController();
  final TextEditingController _passeController = TextEditingController();

  final RegExp _phoneRegex = RegExp(r"^(?:\+212|0)(\d{9})$");
  final RegExp _nameRegex = RegExp(r"^[a-zA-ZÀ-ÿ\-]+$");

  final _formKey = GlobalKey<FormState>(); // GlobalKey for the form


@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('\n Authentification'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Les champs de texte pour les informations du client
            Text(' '),
            Text('Formulaire client  : '),
            const SizedBox(height: 8.0),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _nomController,
                    decoration: const InputDecoration(
                      labelText: 'Nom',
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
                  const SizedBox(height: 8.0),
                  TextFormField(
                    controller: _prenomController,
                    decoration: const InputDecoration(
                      labelText: 'Prénom',
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
                  const SizedBox(height: 8.0),
                  TextFormField(
                    controller: _telephoneController,
                    decoration: const InputDecoration(
                      labelText: 'Téléphone',
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
                  const SizedBox(height: 8.0),
                  TextFormField(
                    controller: _passeController,
                    decoration: const InputDecoration(
                      labelText: 'Email (facultatif)',
                    ),
                  ),
                  const SizedBox(height: 32.0),
                  // Le bouton pour soumettre le formulaire
                  ElevatedButton(
                    onPressed: () {
                      // Vérifier la validité du formulaire
                      if (_formKey.currentState!.validate()) {
                        // Traitement des données saisies
                        String nom = _nomController.text;
                        String prenom = _prenomController.text;
                        String telephone = _telephoneController.text;
                        String passe = _passeController.text;
                        

                        // Envoyer les données à un service d'ouverture de compte
                        //try {
                        // Créer une instance de Dio
                        //Dio dio = Dio();

                        // Définir les données à envoyer dans la requête
                        Map<String, dynamic> data = {
                          'nom': nom,
                          'prenom': prenom,
                          'telephone': telephone,
                          'passe': passe,
                        };

                        // Envoyer la requête POST avec les données
                        //Response response = await dio.post('https://mon-service.com/authentification', data: data);

                        // Vérifier le code de réponse HTTP
                        //if (response.statusCode == 200) {
                        // Si la réponse est OK, afficher un message de succès
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Bienvenue'),
                          ),
                        );
                        // Naviguer vers la page "Hello"
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Home()),
                        );
                        //} else {
                        // Sinon, afficher un message d'erreur avec le code de réponse HTTP
                        //  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('compte non existant '),),);
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
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}