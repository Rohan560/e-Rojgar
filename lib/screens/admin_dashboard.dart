// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rohan_erojgar/constants.dart';
import 'package:rohan_erojgar/controllers/user_controller.dart';
import 'package:http/http.dart' as http;

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({Key? key}) : super(key: key);

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserController>(builder: (context, userController, child) {
      return FutureBuilder(
          future: http.get(Uri.parse(kAPIURL + "/admin/stats"),
              headers: {'userid': userController.user!.id}).then((response) {
            if (response.statusCode != 200) throw Exception("Bad response ");
            var body = jsonDecode(response.body);
            if (body['status'] != 'success') {
              throw Exception(body['error'] ?? "Errored out");
            }
            return body['stats'] as Map<String, dynamic>;
          }),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List stats = [
                ['Total Jobseekers', (snapshot.data as Map)['jobSeekers']],
                ['Total Employers', (snapshot.data as Map)['employers']],
                ['Total Jobs', (snapshot.data as Map)['jobs']],
                ['Total Applications', (snapshot.data as Map)['applications']],
              ];
              return ListView(
                children: [
                  for (var stat in stats)
                    Container(
                      width: double.infinity,
                      margin: EdgeInsets.all(kUnitPadding * 2),
                      padding: EdgeInsets.all(kUnitPadding * 2),
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            spreadRadius: 1,
                          )
                        ],
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(kUnitPadding),
                            child: Text(
                              stat[0].toString(),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          // Divider(),
                          Text(
                            stat[1].toString(),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              );
            }
            if (snapshot.hasError) {
              return Text("Errored Out: " + snapshot.error.toString());
            }
            return Center(child: CupertinoActivityIndicator());
          });
    });
  }
}
