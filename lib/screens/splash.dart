// ignore_for_file: avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:rohan_erojgar/constants.dart';
import 'package:rohan_erojgar/screens/auth/register.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      Navigator.of(navigatorKey.currentState!.context)
          .push(MaterialPageRoute(builder: (context) => RegisterPage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColorBG,
      body: Container(
        child: Center(
          child: Container(
              constraints: BoxConstraints(
                maxWidth: 220,
              ),
              child: Image.asset("assets/images/splash_logo.png")),
        ),
      ),
    );
  }
}
