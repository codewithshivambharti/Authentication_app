import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:untitled2/authentication/Register.dart';
import 'package:untitled2/authentication/homescreen.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  FirebaseAuth auth = FirebaseAuth.instance;

  void NextScreen() async {
    await Future.delayed(Duration(seconds: 3));
    if (auth.currentUser == null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Register()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Homescreen()),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    NextScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: FlutterLogo(size: 100)));
  }
}
