// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:rohan_erojgar/classes/job_filter.dart';
import 'package:rohan_erojgar/constants.dart';
import 'package:rohan_erojgar/controllers/search_controller.dart';
import 'package:rohan_erojgar/screens/job_details.dart';

import '../models/job.dart';

class JobTile extends StatelessWidget {
  final Job job;
  final Function? refetch;
  const JobTile({Key? key, required this.job, this.refetch}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        var resp = await Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => JobDetailsPage(job: job)));
        if (resp is String && resp == 'refresh') {
          if (refetch != null) refetch!();
        }
      },
      child: Container(
        padding: EdgeInsets.all(kUnitPadding * 3),
        margin: EdgeInsets.all(kUnitPadding),
        decoration: BoxDecoration(
          color: primaryColorBG,
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              job.title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: kUnitPadding * 1,
            ),
            Text(
              job.companyName,
              style: TextStyle(
                color: Color(0xffcccccc),
                fontSize: 15,
                // fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: kUnitPadding * 1,
            ),
            Text(
              job.location,
              style: TextStyle(
                color: Colors.white,
                // fontSize: 15,
                // fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: kUnitPadding * 1,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "Deadline: " +
                      DateFormat(DateFormat.YEAR_MONTH_DAY)
                          .format(job.deadline),
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class Jobs extends StatefulWidget {
  final List<Job> jobs;
  final JobFilter? filter;
  final bool useSearch;
  final Function? refetch;
  const Jobs(
      {Key? key,
      required this.jobs,
      this.filter,
      this.useSearch = false,
      this.refetch})
      : super(key: key);

  @override
  State<Jobs> createState() => _JobsState();
}

class _JobsState extends State<Jobs> {
  late JobFilter filter =
      widget.filter ?? JobFilter(category: "Any", jobType: "Any", query: "");

  @override
  Widget build(BuildContext context) {
    return Consumer<SearchController>(
        builder: (context, searchController, child) {
      if (widget.useSearch) {
        filter.query = searchController.query.trim();
      }
      var jobsToShow = widget.jobs.where((job) => job.matches(filter)).toList();
      return Column(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Text("${jobsToShow.length} jobs found."),
              ),
              if (widget.jobs.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Wrap(
                    alignment: WrapAlignment.spaceBetween,
                    children: [
                      DropdownButton(
                        value: filter.jobType,
                        items: ["Any", ...kJobTypes]
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          if (newValue != null) {
                            setState(() {
                              filter.jobType = newValue.toString();
                            });
                          }
                        },
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      DropdownButton(
                        value: filter.category,
                        items: ["Any", ...kJobCategories]
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          if (newValue != null) {
                            setState(() {
                              filter.category = newValue.toString();
                            });
                          }
                        },
                      ),
                    ],
                  ),
                )
            ],
          ),
          Column(
            children: jobsToShow
                .map((e) => JobTile(
                      job: e,
                      refetch: widget.refetch,
                    ))
                .toList(),
          ),
        ],
      );
    });
  }
}
