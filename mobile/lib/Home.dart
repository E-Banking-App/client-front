import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
//import 'package:dio/dio.dart';

import 'DonationPage.dart';
import 'CreancierPage.dart';
import 'RechargePage.dart';
import 'SoldePage.dart';
import 'main.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomeState();
}

class HomeState extends State<Home> {
  int _selectedIndex = 0;

  List<String> _creanciers = [];
  Map<String, List<String>> _creances = {};
  Map<String, String> _images = {}; // Ajoutez cette ligne ici



  List<String> donations = [];
  Map<String, String> imagesdonations = {}; // Ajoutez cette ligne ici



  List<String> recharges = [];
  Map<String, String> imagesrecharges = {}; // Ajoutez cette ligne ici




  @override
  void initState() {
    super.initState();
    _fetchCreanciers();

    _fetchCreanciersDonations();

    _fetchCreanciersRecharges();

  }

 

void _fetchCreanciers() async {
  // Ajouter manuellement Lydec avec ses créances et son image pour tester
  _creanciers.add('Lydec');
  _creances['Lydec'] = ['Eau', 'Electricité'];
  
 
  
  _images['Lydec'] = 'https://upload.wikimedia.org/wikipedia/commons/3/37/Logo_Lydec_2010.png';
  
  //_images['Lydec'] = '/Users/nouhaed-daoui/Desktop/Lydec.png';
  var headers = {
  'Authorization': 'Bearer ${GlobalData.authToken}',
};
  var url = Uri.parse('http://localhost:8082/creditor/facture');
  var response = await http.get(url, headers: headers);
  
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


void _fetchCreanciersDonations() async {
  // Ajouter manuellement Lydec avec ses créances et son image pour tester
  donations.add('Association Kheir');

  imagesdonations['Association Kheir'] = 'https://www.barlamane.com/fr/wp-content/uploads/2018/05/dar-al-kheir-kenitra.jpg';
  
  var headers = {
  'Authorization': 'Bearer ${GlobalData.authToken}',
};
  var url = Uri.parse('http://localhost:8082/creditor/donation');
  var response = await http.get(url, headers: headers);
  
  if (response.statusCode == 200) {
    Map<String, dynamic> jsonData = json.decode(response.body);
    jsonData.forEach((key, value) {
      if (key != 'Association Kheir') {
        donations.add(key);
      
        imagesdonations[key] = value['image'];
      }
    });
    setState(() {});
  } else {
    throw Exception('Failed to load creanciers de donation ');
  }
}

void _fetchCreanciersRecharges() async  {

  // Ajouter manuellement Lydec avec ses créances et son image pour tester
  recharges.add('Orange');
  
  
 
  
  //imagesrecharges['Orange'] = 'https://emploi24.ma/wp-content/uploads/2023/01/Orange-Maroc-recrute-des-Stagiaires-PFE-2023.webp';
  imagesrecharges['Orange']='https://emploi24.ma/wp-content/uploads/2023/01/Orange-Maroc-recrute-des-Stagiaires-PFE-2023.webp';
  
  var headers = {
  'Authorization': 'Bearer ${GlobalData.authToken}',
};
  var url = Uri.parse('http://localhost:8082/creditor/recharge');
  var response = await http.get(url, headers: headers);
  
  if (response.statusCode == 200) {
    Map<String, dynamic> jsonData = json.decode(response.body);
    jsonData.forEach((key, value) {
      if (key != 'Orange') {
        recharges.add(key);
      
        imagesrecharges[key] = value['image'];
      }
    });
    setState(() {});
  } else {
    throw Exception('Failed to load creanciers de recharge ');
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
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          _buildCreanciers(),
          _buildHistorique(),
          _buildDonation(),
          _buildRecharges(),
          SoldePage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Facturation',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'Historique',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Donation',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Recharge',
          ),
          BottomNavigationBarItem(
             icon: Icon(Icons.account_balance),
            label: ' Mon Solde',
),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey, 
        unselectedLabelStyle: TextStyle(color: Colors.grey),
        showUnselectedLabels: true,
        onTap: _onItemTapped,
      ),
    ),
  );
}

Widget _buildDonation() {
  if (donations.isEmpty) {
    return Center(child: CircularProgressIndicator());
  } else {
    return ListView.builder(
      itemCount: donations.length,
      itemBuilder: (context, index) {
        String creancier = donations[index];
        String imageUrl = imagesdonations[creancier] ?? '';

        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DonationPage(
                  creancier: creancier,
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


  Widget _buildRecharges() {

 if (recharges.isEmpty) {
    return Center(child: CircularProgressIndicator());
  } else {
    return ListView.builder(
      itemCount: recharges.length,
      itemBuilder: (context, index) {
        String creancier = recharges[index];
        String imageUrl = imagesrecharges[creancier] ?? '';

        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => RechargePage(
                  creancier: creancier,
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
                  // Image.network(
                  //   imageUrl,
                  //   width: 70.0, //50
                  //   height: 70.0, //50
                  //   fit: BoxFit.cover,
                  // ),
                  Container(
                    width: 70.0, //50
                     height: 70.0, //50
                       child: Image.network(
                             imageUrl,
                              fit: BoxFit.contain,
                                   ),
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


}

