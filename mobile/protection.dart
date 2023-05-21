import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomeState();
}

class HomeState extends State<Home> {
  int _selectedIndex = 0;

  List<String> _creanciers = [];
  Map<String, List<String>> _creances = {};

  Map<String, String> _images = {}; // Ajoutez cette ligne ici

  @override
  void initState() {
    super.initState();
    _fetchCreanciers();
  }

void _fetchCreanciers() async {
  // Ajouter manuellement Lydec avec ses créances et son image pour tester
  _creanciers.add('Lydec');
  _creances['Lydec'] = ['Eau', 'Electricité'];
  
 
  
  _images['Lydec'] = 'https://upload.wikimedia.org/wikipedia/commons/3/37/Logo_Lydec_2010.png';
  
  //_images['Lydec'] = '/Users/nouhaed-daoui/Desktop/Lydec.png';
  
  var url = Uri.parse('https://mon-service.com/creanciers');
  var response = await http.get(url);
  
  if (response.statusCode == 200) {
    Map<String, dynamic> jsonData = json.decode(response.body);
    jsonData.forEach((key, value) {
      if (key != 'Lydec') {
        _creanciers.add(key);
        _creances[key] = List<String>.from(value['creances']);
        _images[key] = value['image'];
      }
    });
    setState(() {});
  } else {
    throw Exception('Failed to load creanciers');
  }
}


  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }




  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bienvenue',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Bienvenue'),
        ),
        body: Center(
          child: _selectedIndex == 0 ? _buildCreanciers() : _buildHistorique(),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>
          [
            BottomNavigationBarItem(
              icon: Icon(Icons.list),
              label: ' Facturation ',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.history),
              label: 'Historique',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.list),
              label: ' Donation',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.blue,
          onTap: _onItemTapped,
        ),
      ),
    );
  }


Widget _buildCreanciers() {
  if (_creanciers.isEmpty) {
    return Center(child: CircularProgressIndicator());
  } else {
    return ListView.builder(
      itemCount: _creanciers.length,
      itemBuilder: (context, index) {
        String creancier = _creanciers[index];
        String imageUrl = _images[creancier] ?? '';

        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CreancierPage(
                  creancier: creancier,
                  creances: _creances[creancier] ?? [],
                ),
              ),
            );
          },
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0), //16 , 8  haut -   20 , 20 bas
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 4.0,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                if (imageUrl.isNotEmpty)
                  Image.network(
                    imageUrl,
                    width: 70.0, //50
                    height: 70.0, //50
                    fit: BoxFit.cover,
                  ),
                SizedBox(width: 30.0), //16
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        creancier,
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: _creances[creancier]!.length,
                        itemBuilder: (context, index) {
                          // return Text(
                          //   _creances[creancier]![index],
                          //   style: TextStyle(fontSize: 16.0),
                          // );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}





  Widget _buildHistorique() {
    return Text('Historique');
  }
}
class CreancierPage extends StatelessWidget {
  final String creancier;
  final List<String> creances;

  CreancierPage({required this.creancier, required this.creances});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(creancier),
        backgroundColor: Colors.blue,
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Créances de $creancier',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Colors.blue[900],
              ),
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            itemCount: creances.length,
            itemBuilder: (context, index) {
              String creance = creances[index];
              return Card(
                elevation: 4.0,
                margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                child: ListTile(
                  title: Text(
                    creance,
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Choix de paiement'),
                          content: Text('Choisissez un mode de paiement'),
                          actions: [
                            TextButton(
                              child: Text('Paiement par numéro de facture'),
                              onPressed: () {
                                Navigator.pop(context);
                                _showFacturePaymentDialog(context, creancier, creance);
                              },
                            ),
                            TextButton(
                              child: Text('Paiement par référence'),
                              onPressed: () {
                                Navigator.pop(context);
                                _showReferencePaymentDialog(context, creancier, creance);
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  



  void _showFacturePaymentDialog(BuildContext context, String creancier, String creance) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String factureNumber = '';
        return AlertDialog(
          title: Text('Paiement par numéro de facture'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                onChanged: (value) {
                  factureNumber = value;
                },
                decoration: InputDecoration(
                  labelText: 'Numéro de facture',
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              child: Text('Annuler'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: Text('Payer'),
              onPressed: () {
                Navigator.pop(context);
                _performFacturePayment(context, creancier, creance, factureNumber);
              },
            ),
          ],
        );
      },
    );
  }

  void _showReferencePaymentDialog(BuildContext context, String creancier, String creance) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      String referenceId = '';
      return SingleChildScrollView(
        child: AlertDialog(
          title: Text('Paiement par référence'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                onChanged: (value) {
                  referenceId = value;
                },
                decoration: InputDecoration(
                  labelText: 'Référence',
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              child: Text('Annuler'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: Text('Payer'),
              onPressed: () {
                Navigator.pop(context);
                _performReferencePayment(context, creancier, creance, referenceId);

              },
            ),
          ],
        ),
      );
    },
  );
}


  void _performFacturePayment(BuildContext context, String creancier, String creance, String factureNumber) async {
  double billAmount;

  if (creancier == "Lydec") {
    billAmount = 150.0;
    _showPaymentForm(context, creancier, creance, billAmount, factureNumber);
  } else {
    try {
      // Make the HTTP request to fetch the bill amount
      var response = await http.get(
        Uri.parse('https://your-backend-url.com/facture?creancier=$creancier&creance=$creance&factureNumber=$factureNumber'),
      );

      if (response.statusCode == 200) {
        // Parse the response body to get the bill amount
        billAmount = double.parse(response.body);

        _showPaymentForm(context, creancier, creance, billAmount, factureNumber);
      } else {
        // Handle errors or show an error message
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Erreur'),
              content: Text('Une erreur s\'est produite lors de la récupération du montant de la facture.'),
              actions: [
                TextButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            );
          },
        );
      }
    } catch (e) {
      // Handle exceptions or show an error message
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Erreur'),
            content: Text('Une erreur s\'est produite lors de la récupération du montant de la facture.'),
            actions: [
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        },
      );
    }
  }
}

  void _performReferencePayment(BuildContext context, String creancier, String creance, String referenceId) async {
  if (creancier == "Lydec") {
    // Simulated list of unpaid invoices for Lydec
    List<Map<String, dynamic>> unpaidInvoices = [
      {
        "numero": "F0001",
        "mois": "Janvier",
        "montant": 100.0,
      },
      {
        "numero": "F0002",
        "mois": "Février",
        "montant": 150.0,
      },
      {
        "numero": "F0003",
        "mois": "Mars",
        "montant": 200.0,
      },
    ];

    _showUnpaidInvoices(context, creancier, creance, unpaidInvoices, referenceId);
  } else {
    try {
      // Make the HTTP request to fetch the unpaid invoices based on the reference ID
      var response = await http.get(
        Uri.parse('https://your-backend-url.com/unpaid-invoices?creancier=$creancier&creance=$creance&referenceId=$referenceId'),
      );

      if (response.statusCode == 200) {
        // Parse the response body to get the list of unpaid invoices
        var jsonData = json.decode(response.body);
        List<Map<String, dynamic>> unpaidInvoices = List<Map<String, dynamic>>.from(jsonData);

        _showUnpaidInvoices(context, creancier, creance, unpaidInvoices, referenceId);
      } else {
        // Handle errors or show an error message
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Erreur'),
              content: Text('Une erreur s\'est produite lors de la récupération des factures impayées.'),
              actions: [
                TextButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            );
          },
        );
      }
    } catch (e) {
      // Handle exceptions or show an error message
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Erreur'),
            content: Text('Une erreur s\'est produite lors de la récupération des factures impayées.'),
            actions: [
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        },
      );
    }
  }
}

void _showUnpaidInvoices(BuildContext context, String creancier, String creance, List<Map<String, dynamic>> unpaidInvoices, String referenceId) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Factures impayées'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Liste des factures impayées :'),
              SizedBox(height: 10),
              Container(
                width: 300,
                height: 300,
                child: ListView(
                  shrinkWrap: true,
                  children: unpaidInvoices.map((invoice) {
                    var invoiceNumber = invoice['numero'];
                    var invoiceMonth = invoice['mois'];
                    var invoiceAmount = invoice['montant'];

                    return ListTile(
                      title: Text('Facture : $invoiceNumber'),
                      subtitle: Text('Mois : $invoiceMonth'),
                      trailing: Text('Montant : $invoiceAmount'),
                      onTap: () {
                        _showPaymentForm(context, creancier, creance, invoiceAmount,invoiceNumber);
                      },
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            child: Text('Fermer'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      );
    },
  );
}



  void _showPaymentForm(BuildContext context, String creancier, String creance, double billAmount, String referenceOrFactureNumber) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String password = '';
        return AlertDialog(
          title: Text('Formulaire de paiement'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Créancier: $creancier'),
              Text('Créance: $creance'),
              Text('Montant: $billAmount'),
              SizedBox(height: 16.0),
              TextField(
                onChanged: (value) {
                  password = value;
                },
                obscureText: true, // Hide password input
                decoration: InputDecoration(
                  labelText: 'Mot de passe',
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              child: Text('Annuler'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: Text('Payer'),
              onPressed: () {
                Navigator.pop(context);
                _performPayment(context, creancier, creance, billAmount, password, referenceOrFactureNumber);
              },
            ),
          ],
        );
      },
    );
  }

  void _performPayment(BuildContext context, String creancier, String creance, double amount, String password, String referenceOrFactureNumber) async {
    try {
      // Make the HTTP request to validate the password and process the payment
      var response = await http.post(
        Uri.parse('https://your-backend-url.com/payment'),
        body: {
          'creancier': creancier,
          'creance': creance,
          'amount': amount.toString(),
          'password': password,
          'referenceOrFactureNumber': referenceOrFactureNumber,
        },
      );

      if (response.statusCode == 200) {
        // Payment success
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Paiement effectué'),
              content: Text('Le paiement de $amount € pour la créance "$creance" chez "$creancier" a été effectué.'),
              actions: [
                TextButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            );
          },
        );
      } else {
        // Payment failed, display error message
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Erreur'),
              content: Text('Mot de passe incorrect ou solde insuffisant.'),
              actions: [
                TextButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            );
          },
        );
      }
    } catch (e) {
      // Handle exceptions or show an error message
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Erreur'),
            content: Text('Une erreur s\'est produite lors du paiement.'),
            actions: [
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        },
      );
    }
  }



}