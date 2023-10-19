import 'package:flutter/material.dart';
import 'package:flutter_sharedpref/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String username = ''; // Add this variable

  @override
  void initState() {
    super.initState();
    // Retrieve the username from shared preferences when the home page is loaded
    getUsernameFromPrefs();
  }

  Future<void> getUsernameFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString('username') ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () async {
              // Clear login status and username in shared preferences
              final prefs = await SharedPreferences.getInstance();
              prefs.setBool('isLoggedIn', false);
              prefs.remove('username');

              // Navigate back to the login page
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Welcome to the Home Page!'),
            Text('Username: $username'), // Display the username
          ],
        ),
      ),
    );
  }
}
