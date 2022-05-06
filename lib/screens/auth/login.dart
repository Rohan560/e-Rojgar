// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rohan_erojgar/constants.dart';
import 'package:rohan_erojgar/screens/auth/register.dart';
import '../../controllers/user_controller.dart';
import '../../helpers.dart';
import 'package:http/http.dart' as http;
import '../../models/user.dart';
import '../home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // @override
  // void initState() {
  //   super.initState();
  //   _emailController.text = "asdf@asdf.asdf";
  //   _passwordController.text = 'asdfasdf';
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
        elevation: 0,
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: kTopContentMargin,
                ),
                Padding(
                  padding: EdgeInsets.all(kUnitPadding * 2),
                  child: TextFormField(
                    validator: defaultValidator,
                    controller: _emailController,
                    decoration: InputDecoration(
                      // prefixIcon: ,
                      prefixIcon: Icon(Icons.email),
                      hintText: "Email",
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(kUnitPadding * 2),
                  child: TextFormField(
                    obscureText: true,
                    controller: _passwordController,
                    validator: defaultValidator,
                    decoration: InputDecoration(
                      // prefixIcon: ,
                      prefixIcon: Icon(Icons.lock_outline_rounded),
                      hintText: "Password",
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(kUnitPadding * 2),
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        try {
                          var resp = await http.post(
                              Uri.parse(kAPIURL + "/users/login"),
                              headers: {
                                "Content-Type": "application/json",
                              },
                              body: jsonEncode({
                                "password": _passwordController.text,
                                "email": _emailController.text,
                              }));

                          var decoded = jsonDecode(resp.body) as Map;

                          if (decoded['status'] != "success") {
                            throw Exception(decoded['error'] ?? "Error");
                          }

                          var user = User.fromPayload(decoded['user']);

                          Provider.of<UserController>(context, listen: false)
                              .setUser(user);
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => HomePage()));
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(e.toString())));
                        }
                      }
                    },
                    child: Text("Login"),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => RegisterPage()));
                  },
                  child: Padding(
                    padding: EdgeInsets.all(kUnitPadding * 2),
                    child: Text("I don't have an account"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
