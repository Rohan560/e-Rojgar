// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rohan_erojgar/constants.dart';
import 'package:rohan_erojgar/controllers/user_controller.dart';
import 'package:rohan_erojgar/screens/auth/login.dart';

class LogoutPage extends StatefulWidget {
  const LogoutPage({Key? key}) : super(key: key);

  @override
  State<LogoutPage> createState() => _LogoutPageState();
}

class _LogoutPageState extends State<LogoutPage> {
  void gotoLoginLater(BuildContext context) {
    Future.delayed(
      Duration(seconds: 1),
      (() {
        Provider.of<UserController>(context, listen: false).setUser(null);
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => LoginPage()),
            (route) => false);
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    gotoLoginLater(context);

    return Scaffold(
      appBar: AppBar(title: Text("Logout")),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(kUnitPadding * 4),
              child: Text("Logging Out."),
            ),
            CupertinoActivityIndicator(),
          ],
        ),
      ),
    );
  }
}
