import 'package:rohan_erojgar/classes/job_filter.dart';

class Job {
  String id;
  String title;
  String companyName;
  String location;
  String jobType;
  String category;
  String eligibleFor;
  String skills;
  String selectionProcess;
  String jobDescription;
  String salary;
  DateTime deadline;
  String phoneNumber;
  String email;
  String? website;
  String postedBy;
  List<String> applications;

  Job({
    required this.id,
    required this.title,
    required this.companyName,
    required this.location,
    required this.jobType,
    required this.jobDescription,
    required this.category,
    required this.eligibleFor,
    required this.skills,
    required this.selectionProcess,
    required this.salary,
    required this.deadline,
    this.website,
    required this.phoneNumber,
    required this.email,
    required this.postedBy,
    required this.applications,
  });

  //format raw jobs data into dart classes
  static Job fromPayload(Map<String, dynamic> rawJob) {
    return Job(
      id: rawJob['_id'],
      title: rawJob['title'],
      companyName: rawJob['companyName'],
      location: rawJob['location'],
      jobType: rawJob['jobType'],
      jobDescription: rawJob['jobDescription'],
      category: rawJob['category'],
      eligibleFor: rawJob['eligibleFor'],
      skills: rawJob['skills'],
      selectionProcess: rawJob['selectionProcess'],
      salary: rawJob['salary'],
      deadline: DateTime.parse(rawJob['deadline']),
      phoneNumber: rawJob['phoneNumber'],
      email: rawJob['email'],
      postedBy: rawJob['postedBy'],
      applications:
          (rawJob['applications'] as List).map((e) => e.toString()).toList(),
      website: rawJob['website'],
    );
  }

  bool matches(JobFilter filter) {
    bool passed = true;
    if (filter.category.isNotEmpty) {
      if (!(filter.category == "Any" || filter.category == category)) {
        passed = false;
      }
    }
    if (filter.jobType.isNotEmpty) {
      if (!(filter.jobType == "Any" || filter.jobType == jobType)) {
        passed = false;
      }
    }

    // if (filter.query.l) {
    if (!matchesSearch(filter.query)) {
      passed = false;
      // }as
    }

    return passed;
  }

  bool matchesSearch(String q) {
    if (title.contains(q)) return true;
    if (jobDescription.contains(q)) return true;
    return false;
  }
}
