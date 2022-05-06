// ignore_for_file: prefer_const_constructors,prefer_const_literals_to_create_immutables

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:rohan_erojgar/constants.dart';
import 'package:rohan_erojgar/controllers/user_controller.dart';

import '../models/job.dart';
import '../models/user.dart';

class ApplicationsPage extends StatelessWidget {
  final Job job;
  const ApplicationsPage({Key? key, required this.job}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(job.title)),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Applications",
              style: Theme.of(context).textTheme.headline5,
            ),
          ),
          Consumer<UserController>(builder: (context, userController, child) {
            return FutureBuilder<List<User>>(
              future: http.get(
                  Uri.parse(kAPIURL + "/jobs/${job.id}/applications"),
                  headers: {
                    'content-type': 'application/json',
                    'userid': userController.user!.id,
                  }).then((resp) {
                if (resp.statusCode != 200) {
                  throw Exception("Bad Response: " + resp.body);
                }
                var data = jsonDecode(resp.body);
                if (data['status'] != 'success') {
                  throw Exception(data['error'] ?? "Error Occurrd");
                }
                return (data['applications'] as List)
                    .map((e) => User.fromPayload(e))
                    .toList();
              }),
              builder: ((context, snapshot) {
                if (snapshot.hasData) {
                  var users = snapshot.data!;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("${users.length} Applications Found."),
                      ),
                      for (User u in users)
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(kUnitPadding * 2),
                          margin: EdgeInsets.all(kUnitPadding),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey.withOpacity(0.2),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  u.name,
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text('''Email: ${u.email}
Phone: ${u.phoneNumber}
Address: ${u.address}
Experience: ${u.experience}
Qualification: ${u.qualification}
Occupation: ${u.occupation}'''),
                              ],
                            ),
                          ),
                        ),
                    ],
                  );
                } else if (snapshot.hasError) {
                  return Text("Error: " + snapshot.error.toString());
                }
                return Center(child: CupertinoActivityIndicator());
              }),
            );
          }),
        ]),
      ),
    );
  }
}
