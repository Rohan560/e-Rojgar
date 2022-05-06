// ignore_for_file: prefer_const_constructors,prefer_const_literals_to_create_immutables, avoid_print

import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rohan_erojgar/constants.dart';
import 'package:rohan_erojgar/controllers/user_controller.dart';

import '../helpers.dart';
import '../models/user.dart';

class ProfilePage extends StatefulWidget {
  final bool toPop;
  const ProfilePage({Key? key, this.toPop = false}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // late DateTime dob = DateTime(2000, 2, 1);
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController occupationController = TextEditingController();
  final TextEditingController experienceController = TextEditingController();
  final TextEditingController qualificationController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController websiteController = TextEditingController();
  final TextEditingController dobController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  void initValues(User user) {
    nameController.text = user.name;
    if (user.address != null) addressController.text = user.address!;
    if (user.occupation != null) occupationController.text = user.occupation!;
    if (user.qualification != null) {
      qualificationController.text = user.qualification!;
    }
    if (user.experience != null) experienceController.text = user.experience!;
    if (user.phoneNumber != null) {
      phoneNumberController.text = user.phoneNumber!;
    }
    if (user.website != null) {
      websiteController.text = user.website!;
    }
    if (user.dob != null) dobController.text = user.dob!;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserController>(builder: (context, userController, child) {
      if (userController.isLoggedIn) initValues(userController.user!);
      return Form(
        key: _formKey,
        child: Scaffold(
          appBar: AppBar(title: Text("Profile")),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Update your Profile",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      userController.role == UserRole.jobSeeker
                          ? "Full Name"
                          : "Organization Name",
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      decoration:
                          InputDecoration(hintText: userController.user!.name),
                      validator: defaultValidator,
                      controller: nameController,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Email ",
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      enabled: false,
                      decoration: InputDecoration(
                        hintText: userController.user!.email,
                        suffixIcon: Icon(Icons.email),
                      ),
                    ),
                  ),
                  if (userController.role == UserRole.jobSeeker)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Date of Birth",
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    ),
                  if (userController.role == UserRole.jobSeeker)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: dobController,
                        decoration: InputDecoration(
                          hintText:
                              userController.user!.dob ?? "Enter Your DOB",
                          suffixIcon: Icon(Icons.date_range),
                        ),
                        validator: defaultValidator,
                      ),
                    ),
                  if (userController.role == UserRole.jobSeeker)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Address",
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    ),
                  if (userController.role == UserRole.jobSeeker)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: addressController,
                        decoration: InputDecoration(
                          hintText: userController.user!.address ??
                              "Enter Your Address",
                          suffixIcon: Icon(Icons.location_on_outlined),
                        ),
                        validator: defaultValidator,
                      ),
                    ),
                  if (userController.role == UserRole.jobSeeker)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Occupation",
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    ),
                  if (userController.role == UserRole.jobSeeker)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: occupationController,
                        decoration: InputDecoration(
                          hintText: userController.user!.occupation ??
                              "Enter Your Occupation",
                        ),
                        validator: defaultValidator,
                      ),
                    ),
                  if (userController.role == UserRole.jobSeeker)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Experience",
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    ),
                  if (userController.role == UserRole.jobSeeker)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: experienceController,
                        decoration: InputDecoration(
                          hintText: userController.user!.experience ??
                              "Enter Your Experience",
                        ),
                        validator: defaultValidator,
                      ),
                    ),
                  if (userController.role == UserRole.jobSeeker)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Qualification",
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    ),
                  if (userController.role == UserRole.jobSeeker)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: qualificationController,
                        decoration: InputDecoration(
                          hintText: userController.user!.qualification ??
                              "Enter Your Qualification",
                        ),
                        validator: defaultValidator,
                      ),
                    ),
                  // if (userController.role == UserRole.jobSeeker)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Phone Number",
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ),
                  // if (userController.role == UserRole.jobSeeker)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: phoneNumberController,
                      decoration: InputDecoration(
                        hintText: userController.user!.phoneNumber ??
                            "Enter Your Phone Number",
                      ),
                      validator: defaultValidator,
                    ),
                  ),
                  if (userController.role != UserRole.jobSeeker)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Website",
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    ),
                  if (userController.role != UserRole.jobSeeker)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: websiteController,
                        decoration: InputDecoration(
                          hintText: userController.user!.website ??
                              "Enter your website",
                        ),
                        validator: defaultValidator,
                      ),
                    ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: BottomAppBar(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  try {
                    var resp = await http.put(Uri.parse(kAPIURL + "/users/me"),
                        headers: {
                          "Content-Type": "application/json",
                          "userid": userController.user!.id,
                        },
                        body: jsonEncode({
                          "name": nameController.text,
                          "address": addressController.text,
                          "occupation": occupationController.text,
                          "experience": experienceController.text,
                          "qualification": qualificationController.text,
                          "phoneNumber": phoneNumberController.text,
                          "dob": dobController.text,
                          "website": websiteController.text,
                        }));

                    var decoded = jsonDecode(resp.body) as Map;

                    if (decoded['status'] != "success") {
                      throw Exception(decoded['error'] ?? "Error");
                    }

                    var user = User.fromPayload(decoded['user']);

                    Provider.of<UserController>(context, listen: false)
                        .setUser(user);
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text("Updated !!")));
                    if (widget.toPop) {
                      Navigator.of(context).pop();
                    }
                  } catch (e) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text(e.toString())));
                  }
                } else {
                  print("Invalid data");
                }
              },
              child: Text("Update"),
            ),
          )),
        ),
      );
    });
  }
}
