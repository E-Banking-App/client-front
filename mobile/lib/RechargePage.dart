import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'main.dart';

// class RechargePage extends StatelessWidget {
//   final String creancier;

//   RechargePage({required this.creancier});

//   @override
//   Widget build(BuildContext context) {
//     // Implement the UI for the DonationPage here
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Recharge  Page'),
//       ),
//       body: Center(
//         child: Text('recharge de $creancier'),
//       ),
//     );
//   }
// }

class RechargePage extends StatefulWidget {
  final String creancier;

 

  RechargePage({required this.creancier});

  @override
  _RechargePageState createState() => _RechargePageState();
}

class _RechargePageState extends State<RechargePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
   String? email = GlobalData.email;
  String? selectedOption;
  double? amount;
  String beneficiaryNumber = '';
  String password = '';
  bool isLoading = false;
  bool hasError = false;
  String? id = GlobalData.id;

  String? validatePhoneNumber(String? value) {
    // Numéro de téléphone marocain: 10 chiffres commençant par 06, 07 ou 05
    if (value == null || value.isEmpty) {
      return 'Veuillez saisir un numéro de téléphone';
    } else if (!RegExp(r'^(05|06|07)[0-9]{8}$').hasMatch(value)) {
      return 'Veuillez saisir un numéro de téléphone marocain valide';
    }
    return null;
  }

  String? validateAmount(String? value) {
    if (value == null || value.isEmpty) {
      return 'Veuillez saisir un montant';
    } else {
      try {
        double.parse(value);
      } catch (e) {
        return 'Veuillez saisir un montant valide';
      }
    }
    return null;
  }

  Future<void> recharge() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    // Start the loading state
    setState(() {
      isLoading = true;
      hasError = false;
    });

    // Prepare the request body
    
    Map<String, dynamic> requestBody = {
      'email': email,
      'creancier': widget.creancier,
      'option': selectedOption,
      'amount': amount,
      'beneficiaryNumber': beneficiaryNumber,
      'password': password,
    };
  final jsonData = jsonEncode(requestBody);

    // Make the API request
    try {
      http.Response response = await http.post(
  Uri.parse('http://localhost:8082/recharge/internetsim'),
  headers: {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer ${GlobalData.authToken}',
  },
  body: jsonData,
);

      // Check if the request was successful
      if (response.statusCode == 200) {
        // Recharge successful, display success message
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Recharge Successful'),
              content: Text(
                  'Your recharge in ${widget.creancier} has been successfully processed.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );

        // Clear the form fields
        setState(() {
          selectedOption = null;
          amount = null;
          beneficiaryNumber = '';
          password = '';
        });
      } else {
        // Recharge failed, display error message
        setState(() {
          hasError = true;
        });

        String errorMessage = response.body; // Extract the error message from the response body

        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Recharge Failed'),
              content: Text(
                  'There was an error processing your recharge: $errorMessage'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      }
    } catch (error) {
      // Error handling in case of network issues or other exceptions
      setState(() {
        hasError = true;
      });

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Recharge Failed'),
            content: Text(
                'An error occurred while processing your recharge. Please try again later.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }

    // End the loading state
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recharge Page'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Text('Recharge de ${widget.creancier}'),
              SizedBox(height: 16.0),
              DropdownButtonFormField<String>(
                value: selectedOption,
                decoration: InputDecoration(
                  labelText: 'Choisir une option',
                ),
                items: [
                  DropdownMenuItem(
                    value: 'Sim',
                    child: Text('Sim'),
                  ),
                  DropdownMenuItem(
                    value: 'Internet',
                    child: Text('Internet'),
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    selectedOption = value;
                  });
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Montant en DH',
                ),
                validator: validateAmount,
                onChanged: (value) {
                  setState(() {
                    amount = double.tryParse(value);
                  });
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Numéro du bénéficiaire',
                ),
                validator: validatePhoneNumber,
                onChanged: (value) {
                  setState(() {
                    beneficiaryNumber = value;
                  });
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Mot de passe',
                ),
                onChanged: (value) {
                  setState(() {
                    password = value;
                  });
                },
              ),
              SizedBox(height: 16.0),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: isLoading ? null : recharge,
                child: isLoading
                    ? CircularProgressIndicator()
                    : Text('Recharger'),
              ),
              // if (hasError)
              //   Text(
              //     'Erreur: Mot de passe incorrect ou solde insuffisant.',
              //     style: TextStyle(
              //       color: Colors.red,
              //     ),
              //   ),
            ],
          ),
        ),
      ),
      resizeToAvoidBottomInset: false 
    );
  }
}
