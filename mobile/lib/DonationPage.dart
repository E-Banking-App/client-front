
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'main.dart';



class DonationPage extends StatelessWidget {
  final String creancier;
  
  

  DonationPage({required this.creancier});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(creancier),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Donation details for $creancier',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20.0),
            DonationForm(creancier: creancier),
          ],
        ),
      ),
    );
  }
}

class DonationForm extends StatefulWidget {
  final String creancier;

  

  DonationForm({required this.creancier});

  @override
  _DonationFormState createState() => _DonationFormState();
}

class _DonationFormState extends State<DonationForm> {
  final _formKey = GlobalKey<FormState>();
  double donationAmount = 0;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Enter donation amount:'),
          TextFormField(
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a valid amount';
              }
              // Check if the entered value can be parsed as a double
              if (double.tryParse(value) == null) {
                return 'Please enter a valid number';
              }
              
            },
            onSaved: (value) {
              donationAmount = double.parse(value!);
            },
          ),
          SizedBox(height: 16.0),
          ElevatedButton(
  onPressed: () async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      try {
        String? id = GlobalData.id;
        // Send the donation request to the backend
        final requestData = {
                  'creancier': widget.creancier,
                  'amount': donationAmount.toString(),
                    'id': id,
               };

              final jsonData = jsonEncode(requestData);

          final response = await http.post(Uri.parse('BACKEND_URL'),
                               headers: {
                                   'Content-Type': 'application/json',
                                    'Authorization': 'Bearer ${GlobalData.authToken}',
                                   },
                                   body: jsonData,
                                 );

        if (response.statusCode == 200) {
          // Donation successful
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('Thank You!'),
                content: Text('You have donated $donationAmount'),
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
        } else {
          // Error in donation
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('Error'),
                content: Text('An error occurred during the donation process.'),
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
        // Network error
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Error'),
              content: Text('An error occurred while connecting to the server.'),
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
    }
  },
  child: Text('Submit Donation'),
),

        ],
      ),
    );
  }
}
