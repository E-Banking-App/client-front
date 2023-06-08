
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'main.dart';

class SoldePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SoldeState();
}

class SoldeState extends State<SoldePage> {
  double _solde = 0.0;
  bool _isLoading = true;
  bool _hasError = false;
  String? email = GlobalData.email;

  @override
  void initState() {
    super.initState();
    _fetchSolde(); // Appel de la méthode pour récupérer le solde via une requête HTTP
  }

  void _fetchSolde() async {
    try {
      var headers = {
  'Authorization': 'Bearer ${GlobalData.authToken}',
};    
      var url = Uri.parse('http://localhost:8082/client/clients/{email}/solde'); // Remplacez l'URL par celle de votre backend
      var response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        var solde = double.parse(response.body);

        setState(() {
          _solde = solde;
          _isLoading = false;
        });
      } else {
        setState(() {
          _isLoading = false;
          _hasError = true;
        });
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
        _hasError = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget contentWidget;

    if (_isLoading) {
      contentWidget = CircularProgressIndicator(); // Afficher un indicateur de chargement
    } else if (_hasError) {
      contentWidget = Text('Erreur de connexion au backend'); // Afficher un message d'erreur
    } else {
      contentWidget = Text(
        'Solde: $_solde',
        style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
      ); // Afficher le solde
    }

    return Center(child: contentWidget);
  }
}

