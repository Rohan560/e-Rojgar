// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rohan_erojgar/components/jobs_from_url.dart';
import 'package:rohan_erojgar/constants.dart';
import 'package:rohan_erojgar/controllers/search_controller.dart';
import 'package:rohan_erojgar/controllers/user_controller.dart';
import 'package:rohan_erojgar/screens/activity_page.dart';
import 'package:rohan_erojgar/screens/admin_dashboard.dart';
import 'package:rohan_erojgar/screens/post_job.dart';
import 'package:rohan_erojgar/screens/posted_jobs.dart';
import 'package:rohan_erojgar/screens/profile.dart';
import '../classes/navigation.dart';
import '../components/custom_drawer.dart';
import 'logout.dart';

final Map<UserRole, List<Navigation>> routes = {
  UserRole.employer: [
    Navigation(icon: Icons.home_outlined),
    Navigation(icon: Icons.add, builder: (context) => PostJob()),
    Navigation(
        icon: Icons.account_circle_outlined,
        builder: (context) => ProfilePage()),
    Navigation(icon: Icons.logout, builder: (context) => LogoutPage()),
  ],
  UserRole.jobSeeker: [
    Navigation(icon: Icons.home_outlined),
    Navigation(icon: Icons.message, builder: (context) => ActivityPage()),
    Navigation(
        icon: Icons.account_circle_outlined,
        builder: (context) => ProfilePage()),
    Navigation(icon: Icons.logout, builder: (context) => LogoutPage()),
  ],
  UserRole.admin: [
    Navigation(
      icon: Icons.dashboard_outlined,
    ),
    Navigation(icon: Icons.add, builder: (context) => PostJob()),
    Navigation(
        icon: Icons.check_box_outlined, builder: (context) => PostedJobs()),
    Navigation(icon: Icons.logout, builder: (context) => LogoutPage()),
  ],
};

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<UserController>(
        builder: (context, currentUserRoleController, child) {
      var navSetting = routes[currentUserRoleController.role]!;
      Future.delayed(Duration(milliseconds: 100), (() {
        if (currentUserRoleController.isLoggedIn &&
            currentUserRoleController.role == UserRole.jobSeeker &&
            currentUserRoleController.user!.needsUpdatingProfile()) {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ProfilePage(
                    toPop: true,
                  )));
        }
      }));
      var searchField = TextFormField(
        onChanged: (value) {
          Provider.of<SearchController>(context, listen: false).setQuery(value);
        },
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
            horizontal: kUnitPadding * 3,
            vertical: 0,
          ),
          fillColor: Colors.white,
          hintText: "Search Jobs...",
        ),
      );
      return Scaffold(
        appBar: AppBar(
          title: currentUserRoleController.role != UserRole.admin
              ? Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: searchField,
                )
              : Text("Admin Dashboard"),
          actions: currentUserRoleController.role != UserRole.admin
              ? [
                  IconButton(onPressed: () {}, icon: Icon(Icons.search)),
                ]
              : [],
        ),
        body: currentUserRoleController.role == UserRole.admin
            ? AdminDashboard()
            : currentUserRoleController.role == UserRole.employer
                ? ListView(
                    children: [
                      JobsFromURL(
                        refetch: refetch,
                        useSearch: true,
                        url: "/jobs/by/${currentUserRoleController.user!.id}",
                        key: UniqueKey(),
                      ),
                    ],
                  )
                : ListView(
                    children: [
                      JobsFromURL(
                        useSearch: true,
                        url: "/jobs",
                        key: UniqueKey(),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
        bottomNavigationBar: BottomAppBar(
          child: Container(
            color: primaryColorBG,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                for (var nav in navSetting)
                  IconButton(
                    color: Colors.white,
                    onPressed: () async {
                      if (nav.builder != null) {
                        var feedback = await Navigator.of(context).push(
                          MaterialPageRoute(builder: nav.builder!),
                        );
                        if (feedback is String && feedback == 'refresh') {
                          setState(() {});
                        }
                      }
                    },
                    icon: Icon(
                      nav.icon,
                      size: 30,
                    ),
                  )
              ],
            ),
          ),
        ),
        drawer: CustomDrawer(),
      );
    });
  }

  void refetch() {
    setState(() {});
  }
}
