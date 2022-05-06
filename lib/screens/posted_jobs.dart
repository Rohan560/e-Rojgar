// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rohan_erojgar/components/jobs_from_url.dart';
import 'package:rohan_erojgar/constants.dart';
import 'package:rohan_erojgar/controllers/user_controller.dart';

class PostedJobs extends StatelessWidget {
  const PostedJobs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<UserController>(builder: (context, userController, child) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Posted Jobs"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(kUnitPadding * 2),
          child: ListView(
            children: [
              JobsFromURL(url: "/jobs/by/${userController.user!.id}"),
            ],
          ),
        ),
      );
    });
  }
}
