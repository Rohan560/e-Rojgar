// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:rohan_erojgar/constants.dart';
import 'package:rohan_erojgar/controllers/user_controller.dart';
import 'package:rohan_erojgar/models/user.dart';
import 'package:rohan_erojgar/screens/applications.dart';
import 'package:rohan_erojgar/screens/edit_job.dart';
import '../models/job.dart';
import 'package:http/http.dart' as http;

class JobDetailsPage extends StatefulWidget {
  final Job job;
  const JobDetailsPage({Key? key, required this.job}) : super(key: key);

  @override
  State<JobDetailsPage> createState() => _JobDetailsPageState();
}

class _JobDetailsPageState extends State<JobDetailsPage> {
  late Job job = widget.job;

  @override
  Widget build(BuildContext context) {
    return Consumer<UserController>(builder: (context, userController, child) {
      return Scaffold(
        appBar: AppBar(
          title: Text(job.title),
          elevation: 0.0,
          actions: [
            if (userController.role != UserRole.jobSeeker)
              IconButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => EditJob(job: job)));
                  },
                  icon: Icon(Icons.edit)),
          ],
        ),
        body: SafeArea(
          child: ListView(
            children: [
              SizedBox(
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        color: primaryColorBG,
                        height: 30,
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 5,
                              spreadRadius: 4,
                            ),
                          ],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(kUnitPadding * 3),
                          child: Column(
                            children: [
                              Padding(
                                padding:
                                    EdgeInsets.only(bottom: kUnitPadding * 3),
                                child: Text(
                                  job.companyName,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Text(
                                "Last Date of Application: " +
                                    DateFormat(DateFormat.YEAR_MONTH_DAY)
                                        .format(job.deadline),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: kUnitPadding * 2.2,
              ),
              Container(
                padding: EdgeInsets.all(kUnitPadding * 1.8),
                margin: EdgeInsets.all(kUnitPadding * 1.8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 2,
                        spreadRadius: 2,
                        color: Colors.black.withOpacity(0.2))
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    "Location: " + job.location,
                    "Eligible for: " + job.eligibleFor,
                    "Skills: " + job.skills,
                    "Selection Process: " + job.selectionProcess,
                    'Type: ' + job.jobType,
                    "Category: " + job.category,
                  ]
                      .map((e) => Padding(
                            padding: const EdgeInsets.all(kUnitPadding * 0.7),
                            child: Text(
                              e,
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                          ))
                      .toList(),
                ),
              ),
              Container(
                padding: EdgeInsets.all(kUnitPadding * 1.8),
                margin: EdgeInsets.all(kUnitPadding * 1.8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 2,
                        spreadRadius: 2,
                        color: Colors.black.withOpacity(0.2))
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Description",
                      style: TextStyle(
                        color: primaryColorBG,
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                    ),
                    SizedBox(
                      height: kUnitPadding,
                    ),
                    Text(job.jobDescription),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(kUnitPadding * 1.8),
                margin: EdgeInsets.all(kUnitPadding * 1.8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 2,
                        spreadRadius: 2,
                        color: Colors.black.withOpacity(0.2))
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Salary",
                      style: TextStyle(
                        color: primaryColorBG,
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                    ),
                    SizedBox(
                      height: kUnitPadding,
                    ),
                    Text(
                      job.salary,
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(kUnitPadding * 1.8),
                margin: EdgeInsets.all(kUnitPadding * 1.8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 2,
                        spreadRadius: 2,
                        color: Colors.black.withOpacity(0.2))
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Contact Us",
                      style: TextStyle(
                        color: primaryColorBG,
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                    ),
                    SizedBox(
                      height: kUnitPadding,
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.symmetric(vertical: kUnitPadding),
                      child: Text("Email: " + job.email),
                    ),
                    if (job.website != null)
                      Padding(
                        padding:
                            const EdgeInsets.symmetric(vertical: kUnitPadding),
                        child: Text("Website: " + job.website!),
                      ),
                    Padding(
                      padding:
                          const EdgeInsets.symmetric(vertical: kUnitPadding),
                      child: Text("Phone: " + job.phoneNumber),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          child: userController.role == UserRole.jobSeeker
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      TextButton(
                        onPressed: () async {
                          try {
                            var resp = await http.post(
                                Uri.parse(
                                    kAPIURL + "/jobs/${job.id}/toggleSave"),
                                headers: {
                                  'Content-Type': "application/json",
                                  'userid': userController.user!.id,
                                });
                            if (resp.statusCode != 200) {
                              throw Exception("Bad Response");
                            }
                            var data = jsonDecode(resp.body);
                            userController
                                .setUser(User.fromPayload(data['user']));
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                    userController.user!.hasSavedJob(job.id)
                                        ? "Saved to wishlist"
                                        : "Removed from wishlist"),
                              ),
                            );
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(e.toString())));
                          }
                        },
                        child: Icon(
                          userController.user!.savedJobs.contains(job.id)
                              ? Icons.favorite_rounded
                              : Icons.favorite_outline,
                          size: 32,
                          color: userController.user!.savedJobs.contains(job.id)
                              ? Colors.redAccent
                              : primaryColorBG,
                        ),
                      ),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () async {
                            try {
                              var resp = await http.post(
                                  Uri.parse(kAPIURL +
                                      "/jobs/${job.id}/toggleApplication"),
                                  headers: {
                                    'Content-Type': "application/json",
                                    'userid': userController.user!.id,
                                  });
                              if (resp.statusCode != 200) {
                                throw Exception("Bad Response");
                              }
                              var data = jsonDecode(resp.body);
                              setState(() {
                                job = Job.fromPayload(data['job']);
                              });
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                      userController.user!.hasAppliedToJob(job)
                                          ? "Applied"
                                          : "Removed Application"),
                                ),
                              );
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(e.toString())));
                            }
                          },
                          child: Text(userController.user!.hasAppliedToJob(job)
                              ? "Unapply"
                              : "Apply"),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                    ],
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    ApplicationsPage(job: job)));
                          },
                          child: Text("Applications"),
                        ),
                      ),
                      TextButton(
                        onPressed: () async {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text("Are your sure?"),
                                content: Text(
                                    "This job and all applications related to this job will be deleted. It cannot be undone."),
                                actions: [
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      TextButton(
                                        onPressed: () async {
                                          try {
                                            var resp = await http.delete(
                                                Uri.parse(kAPIURL +
                                                    "/jobs/${job.id}"),
                                                headers: {
                                                  "content-type":
                                                      "application/json",
                                                  'userid':
                                                      userController.user!.id,
                                                });
                                            if (resp.statusCode != 200) {
                                              throw Exception("Bad Response.");
                                            }
                                            var json = jsonDecode(resp.body);
                                            if (json['status'] != 'success') {
                                              throw Exception(json['error'] ??
                                                  "Server Error");
                                            } else {
                                              Navigator.of(context).pop();
                                              Navigator.of(context)
                                                  .pop("refresh");
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(SnackBar(
                                                      content:
                                                          Text("Job Deleted")));
                                            }
                                          } catch (e) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                                    content: Text(
                                                        "Something went wrong. " +
                                                            e.toString())));
                                          }
                                        },
                                        child: Text("Yes, Delete"),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text("Cancel"),
                                      ),
                                    ],
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: Row(
                          children: [
                            Text("Delete"),
                            SizedBox(
                              width: 10,
                            ),
                            Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
        ),
      );
    });
  }
}
