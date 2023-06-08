import 'dart:convert';

import 'package:flutter/material.dart'; 
import 'package:http/http.dart' as http;

class SoldePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SoldeState();
}

class SoldeState extends State<SoldePage> {
  double _solde = 0.0;

  @override
  void initState() {
    super.initState();
    _fetchSolde(); // Appel de la méthode pour récupérer le solde via une requête HTTP
  }

  void _fetchSolde() async {
    // Effectuez votre requête HTTP pour récupérer le solde
    // Par exemple, vous pouvez utiliser la librairie http et l'URL du back end
    var url = Uri.parse('https://mon-service.com/solde');
    var response = await http.get(url);
  
    if (response.statusCode == 200) {
      // Analysez la réponse et extrayez le solde
      var jsonData = json.decode(response.body);
      var solde = jsonData['solde'];

      setState(() {
        _solde = double.parse(solde);
      });
    } else {
      throw Exception('Failed to fetch solde');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Solde: $_solde',
        style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
      ),
    );
  }
}
