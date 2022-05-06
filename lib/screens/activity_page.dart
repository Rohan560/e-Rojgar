// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:rohan_erojgar/components/jobs_from_url.dart';

class ActivityPage extends StatefulWidget {
  const ActivityPage({Key? key}) : super(key: key);

  @override
  State<ActivityPage> createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text("Activities"),
            bottom: TabBar(tabs: [
              Tab(
                text: "Saved",
              ),
              Tab(
                text: "Applied",
              ),
            ]),
          ),
          body: TabBarView(children: [
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: JobsFromURL(
                url: "/users/me/saved",
                key: UniqueKey(),
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: JobsFromURL(
                url: "/users/me/applied",
                key: UniqueKey(),
              ),
            ),
          ]),
        ));
  }
}
