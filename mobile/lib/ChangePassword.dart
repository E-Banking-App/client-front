import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'Home.dart';
import 'main.dart';



class ChangePassword extends StatefulWidget {
  @override
  _PasswordChangePageState createState() => _PasswordChangePageState();
}

class _PasswordChangePageState extends State<ChangePassword> {
  final _formKey = GlobalKey<FormState>();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isLoading = false;
  String _errorMessage = '';

   

  @override
  void dispose() {
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _changePassword() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
        _errorMessage = '';
      });

      final newPassword = _newPasswordController.text;
      
      String? email = GlobalData.email;

      try {


        final Map<String, dynamic> requestData = {
          'newPassword': newPassword,
          'email': email,
             };

        final String jsonData = json.encode(requestData);
        // Make the HTTP request to change the password
       final response = await http.post(
           Uri.parse('http://localhost:8082/client/ChangePassword'),
               headers: {
                          'Content-Type': 'application/json',
                           'Authorization': 'Bearer ${GlobalData.authToken}',
                         },
               body: jsonData,
                 );


        if (response.statusCode == 200) {
          // Password change success
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Home()),
          );
        } else {
          // Password change failed, display error message
          setState(() {
            _errorMessage = 'Erreur lors du changement de mot de passe.';
          });
        }
      } catch (e) {
        // Handle exceptions or show an error message
        setState(() {
          _errorMessage =
              'Une erreur s\'est produite lors du changement de mot de passe.';
        });
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Changement de mot de passe'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _newPasswordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Nouveau mot de passe',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer un nouveau mot de passe.';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _confirmPasswordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Confirmer le mot de passe',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez confirmer le mot de passe.';
                  }
                  if (value != _newPasswordController.text) {
                    return 'Les mots de passe ne correspondent pas.';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              if (_errorMessage.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    _errorMessage,
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _isLoading ? null : _changePassword,
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue, // Customize the button color here
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                child: _isLoading
                    ? CircularProgressIndicator()
                    : Text(
                        'Enregistrer',
                        style: TextStyle(fontSize: 16.0),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

