import 'package:flutter/material.dart';
import 'package:flutter_sharedpref/home.dart';
import 'package:flutter_sharedpref/login.dart';
import 'package:lottie/lottie.dart'; // Import the Lottie package
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: FutureBuilder<bool>(
          future: checkLoginStatus(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // Show the Lottie animation while waiting
              return Center(
                child: Container(
                  height: 250,
                  width: 250,
                  child: Lottie.asset('assets/animations/loader.json')),
              );
            } else {
              Future.delayed(Duration(seconds: 2), () {
                if (snapshot.hasData) {
                  if (snapshot.data == true) {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomePage()));
                  } else {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LoginPage()));
                  }
                }
              });
              // Show another Lottie animation during the delay
              return Center(
                child: Container(
                  height: 250,
                  width: 250,
                  child: Lottie.asset('assets/animations/loader.json')),
              );
            }
          },
        ),
      ),
    );
  }
}

// Rest of the code remains the same as before

Future<bool> checkLoginStatus() async {
  final prefs = await SharedPreferences.getInstance();
  final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
  return isLoggedIn;
}
