// ignore_for_file: prefer_const_constructors,prefer_const_literals_to_create_immutables, avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:rohan_erojgar/constants.dart';
import 'package:rohan_erojgar/controllers/user_controller.dart';
import 'package:rohan_erojgar/helpers.dart';
import 'package:http/http.dart' as http;

import '../models/job.dart';

class EditJob extends StatefulWidget {
  final Job job;
  const EditJob({required this.job, Key? key}) : super(key: key);

  @override
  State<EditJob> createState() => _EditJobState();
}

class _EditJobState extends State<EditJob> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController jobTitleController = TextEditingController();
  final TextEditingController companyNameController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController selectionProcessController =
      TextEditingController();
  final TextEditingController eligibleForController = TextEditingController();
  final TextEditingController skillsController = TextEditingController();
  final TextEditingController jobDescriptionController =
      TextEditingController();
  final TextEditingController salaryController = TextEditingController();
  final TextEditingController websiteController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  String jobType = kJobTypes[0];
  String category = kJobCategories[0];
  DateTime deadline = DateTime.now();

  late Job currentJob = widget.job;

  @override
  void initState() {
    super.initState();
    jobTitleController.text = currentJob.title;
    companyNameController.text = currentJob.companyName;
    locationController.text = currentJob.location;
    selectionProcessController.text = currentJob.selectionProcess;
    eligibleForController.text = currentJob.eligibleFor;
    skillsController.text = currentJob.skills;
    jobDescriptionController.text = currentJob.jobDescription;
    salaryController.text = currentJob.salary;
    websiteController.text = currentJob.website ?? "Enter Website";
    phoneController.text = currentJob.phoneNumber;
    emailController.text = currentJob.email;
    deadline = currentJob.deadline;
    jobType = currentJob.jobType;
    category = currentJob.category;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pop("refresh");
        Navigator.of(context).pop("refresh");
        return true;
      },
      child:
          Consumer<UserController>(builder: (context, userController, child) {
        return Form(
          key: _formKey,
          child: Scaffold(
            appBar: AppBar(title: Text("Edit Job")),
            body: Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: kUnitPadding * 2, horizontal: kUnitPadding),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Job Title *",
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: jobTitleController,
                        decoration: InputDecoration(hintText: "Title of Job"),
                        validator: defaultValidator,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Company Name *",
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        enabled: false,
                        controller: companyNameController,
                        decoration: InputDecoration(hintText: "Company Name"),
                        validator: defaultValidator,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Location",
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: locationController,
                        decoration: InputDecoration(hintText: "Location"),
                        validator: defaultValidator,
                      ),
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Job Type",
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: DropdownButton(
                            value: jobType,
                            items: kJobTypes
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (newValue) {
                              if (newValue != null) {
                                setState(() {
                                  jobType = newValue.toString();
                                });
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Category",
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: DropdownButton(
                            value: category,
                            items: kJobCategories
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (newValue) {
                              if (newValue != null) {
                                setState(() {
                                  category = newValue.toString();
                                });
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Selection Process",
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: selectionProcessController,
                        decoration:
                            InputDecoration(hintText: "Selection Process"),
                        validator: defaultValidator,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Eligible For",
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: eligibleForController,
                        decoration: InputDecoration(hintText: "Eligible For"),
                        validator: defaultValidator,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Skills",
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: skillsController,
                        decoration: InputDecoration(hintText: "Skills"),
                        validator: defaultValidator,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Job Description",
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: jobDescriptionController,
                        maxLines: 3,
                        decoration: InputDecoration(
                          hintText: "Job Description",
                        ),
                        validator: defaultValidator,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Salary",
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: salaryController,
                        decoration: InputDecoration(hintText: "Salary"),
                        validator: (String? value) {
                          if (value != null) {
                            try {
                              double.parse(value);
                            } catch (e) {
                              return "Invalid Number";
                            }
                          } else {
                            return "Required.";
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Deadline",
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: primaryColorBG,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: kUnitPadding * 2,
                            vertical: kUnitPadding * 3,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                DateFormat('yyyy MMM dd').format(deadline),
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              GestureDetector(
                                child: Icon(Icons.date_range),
                                onTap: () {
                                  DatePicker.showDatePicker(context,
                                      minTime: DateTime.now(),
                                      onConfirm: (date) {
                                    setState(() {
                                      deadline = date;
                                    });
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Contact Information",
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: websiteController,
                        decoration: InputDecoration(hintText: "Website"),
                        validator: defaultValidator,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: phoneController,
                        decoration: InputDecoration(hintText: "Phone"),
                        validator: defaultValidator,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: emailController,
                        decoration: InputDecoration(hintText: "Email"),
                        validator: defaultValidator,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            bottomNavigationBar: BottomAppBar(
                child: Padding(
              padding: const EdgeInsets.all(kUnitPadding * 2),
              child: ElevatedButton(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Update"),
                ),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    try {
                      var rawJob = {
                        'title': jobTitleController.text,
                        'companyName': companyNameController.text,
                        'location': locationController.text,
                        'jobType': jobType,
                        'category': category,
                        'selectionProcess': selectionProcessController.text,
                        'eligibleFor': eligibleForController.text,
                        'skills': skillsController.text,
                        'jobDescription': jobDescriptionController.text,
                        'salary': salaryController.text,
                        'deadline': deadline.millisecondsSinceEpoch,
                        'email': emailController.text,
                        'phoneNumber': phoneController.text,
                      };
                      if (websiteController.text.isNotEmpty) {
                        rawJob['website'] = websiteController.text;
                      }
                      var resp = await http.put(
                        Uri.parse(kAPIURL + "/jobs/${widget.job.id}"),
                        headers: {
                          'Content-Type': "application/json",
                          'userid': userController.user!.id,
                        },
                        body: jsonEncode(rawJob),
                      );
                      if (resp.statusCode != 200) {
                        print(resp.body);
                        throw Exception("Bad Resposne.");
                      }
                      var body = jsonDecode(resp.body);
                      if (body['status'] != "success") {
                        throw Exception(body['error'] ?? "Error Occurred");
                      }

                      setState(() {
                        currentJob = Job.fromPayload(body['job']);
                      });

                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text("Updated !")));
                    } catch (e) {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text(e.toString())));
                    }
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Some field is not valid.")));
                  }
                },
              ),
            )),
          ),
        );
      }),
    );
  }
}
