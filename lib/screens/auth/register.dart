// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rohan_erojgar/constants.dart';
import 'package:rohan_erojgar/controllers/user_controller.dart';
import 'package:rohan_erojgar/helpers.dart';
import 'package:rohan_erojgar/models/user.dart';
import 'package:rohan_erojgar/screens/auth/login.dart';
import 'package:http/http.dart' as http;

import '../home_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  UserRole registerAs = UserRole.jobSeeker;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register"),
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
                    validator: (String? v) {
                      if (v == null) return "Required";
                      if (v.isEmpty) return "Required";
                      if (!v.contains("@")) return "Invalid Email";
                      if (!v.contains(".")) return "Invalid Email";
                      return null;
                    },
                    controller: emailController,
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
                    validator: defaultValidator,
                    controller: nameController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        (registerAs == UserRole.employer)
                            ? Icons.home_outlined
                            : Icons.person,
                      ),
                      hintText: (registerAs == UserRole.employer)
                          ? "Organization Name"
                          : "Full Name",
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(kUnitPadding * 2),
                  child: TextFormField(
                    validator: (String? value) {
                      if (value == null || value.isEmpty) return "Required";
                      if (value.length < 8) {
                        return "Minimum 8 characters needed.";
                      }
                      return null;
                    },
                    controller: passwordController,
                    decoration: InputDecoration(
                      // prefixIcon: ,
                      prefixIcon: Icon(Icons.lock_outline_rounded),
                      hintText: "Password",
                    ),
                    obscureText: true,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(kUnitPadding * 2),
                  child: TextFormField(
                    obscureText: true,
                    controller: confirmPasswordController,
                    decoration: InputDecoration(
                      // prefixIcon: ,
                      prefixIcon: Icon(Icons.lock_outline_rounded),
                      hintText: "Confirm Password",
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) return "Required";
                      if (value != passwordController.text) {
                        return "Password dont match ";
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(kUnitPadding * 2),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          "Register As: ",
                          textAlign: TextAlign.left,
                        ),
                      ),
                      Row(
                        children: [
                          Row(
                            children: [
                              Radio(
                                groupValue: registerAs,
                                value: UserRole.jobSeeker,
                                onChanged: (UserRole? v) {
                                  if (v != null) {
                                    setState(() {
                                      registerAs = v;
                                    });
                                  }
                                },
                              ),
                              Text("Job Seeker"),
                            ],
                          ),
                          Row(
                            children: [
                              Radio(
                                groupValue: registerAs,
                                value: UserRole.employer,
                                onChanged: (UserRole? v) {
                                  if (v != null) {
                                    setState(() {
                                      registerAs = v;
                                    });
                                  }
                                },
                              ),
                              Text("Employer"),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(kUnitPadding * 2),
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        try {
                          var resp = await http.post(
                              Uri.parse(kAPIURL + "/users/register"),
                              headers: {
                                "Content-Type": "application/json",
                              },
                              body: jsonEncode({
                                "name": nameController.text,
                                "password": passwordController.text,
                                "email": emailController.text,
                                "role": registerAs == UserRole.employer
                                    ? "employer"
                                    : "job-seeker",
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
                    child: Text("Sign Up"),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => LoginPage()));
                  },
                  child: Padding(
                    padding: EdgeInsets.all(kUnitPadding * 2),
                    child: Text("Already have an account ?"),
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
