// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:rohan_erojgar/components/job_tile.dart';
import 'package:rohan_erojgar/constants.dart';
import 'package:rohan_erojgar/controllers/user_controller.dart';
import 'package:http/http.dart' as http;
import 'package:rohan_erojgar/models/job.dart';

class JobsFromURL extends StatefulWidget {
  final bool useSearch;
  final String url;
  const JobsFromURL(
      {Key? key, this.refetch, required this.url, this.useSearch = false})
      : super(key: key);
  final Function? refetch;

  @override
  State<JobsFromURL> createState() => _JobsFromURLState();
}

class _JobsFromURLState extends State<JobsFromURL> {
  @override
  Widget build(BuildContext context) {
    return Consumer<UserController>(builder: (context, userController, child) {
      return FutureBuilder<List<Job>>(
          future: http.get(Uri.parse(kAPIURL + widget.url), headers: {
            'Content-Type': "application/json",
            "userid": userController.isLoggedIn ? userController.user!.id : "",
          }).then((response) {
            if (response.statusCode == 200) {
              var body = jsonDecode(response.body);

              if (body['status'] == 'success') {
                return (body['jobs'] as List)
                    .map((e) => Job.fromPayload(e))
                    .toList();
              } else {
                throw Exception(body['error'] ?? "Error Occurred");
              }
            }
            throw Exception("Invalid response: " + response.body);
          }).catchError((error) {
            throw Exception(error);
          }),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }
            if (snapshot.hasData) {
              if ((snapshot.data as List).isEmpty) {
                return Padding(
                  padding: const EdgeInsets.all(kUnitPadding * 3),
                  child: Center(
                    child: Text(
                      "No Jobs Found",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                );
              }
              return Jobs(
                jobs: snapshot.data as List<Job>,
                useSearch: widget.useSearch,
                refetch: widget.refetch ?? refetch,
              );
            }
            return CupertinoActivityIndicator();
          });
    });
  }

  void refetch() {
    setState(() {});
  }
}
