import 'package:rohan_erojgar/constants.dart';
import 'package:rohan_erojgar/controllers/user_controller.dart';
import 'job.dart';

class User {
  String name;
  UserRole role;
  String email;
  String id;
  String? dob;
  String? address;
  String? occupation;
  String? experience;
  String? qualification;
  String? phoneNumber;
  String? website;
  List<String> savedJobs;
  int postCount;

  User({
    required this.name,
    required this.email,
    required this.role,
    required this.id,
    required this.savedJobs,
    required this.postCount,
    this.dob,
    this.address,
    this.occupation,
    this.experience,
    this.qualification,
    this.phoneNumber,
    this.website,
  });

  static User fromPayload(Map<String, dynamic> rawUser) {
    return User(
      id: rawUser['_id'],
      name: rawUser['name'],
      email: rawUser['email'],
      role: rawUser['role'] == 'job-seeker'
          ? UserRole.jobSeeker
          : rawUser['role'] == 'employer'
              ? UserRole.employer
              : UserRole.admin,
      address: rawUser['address'],
      occupation: rawUser['occupation'],
      experience: rawUser['experience'],
      qualification: rawUser['qualification'],
      phoneNumber: rawUser['phoneNumber'],
      dob: rawUser['dob'],
      website: rawUser['website'],
      postCount: rawUser['postCount'],
      savedJobs:
          (rawUser['savedJobs'] as List).map((e) => e.toString()).toList(),
    );
  }

  bool needsUpdatingProfile() {
    for (var prop in [dob, address, occupation, experience, qualification]) {
      if (prop == null) return true;
    }
    return false;
  }

  bool hasSavedJob(String jobId) {
    return savedJobs.contains(jobId);
  }

  bool hasAppliedToJob(Job job) {
    return job.applications.contains(id);
  }

// to know if user can post this job for free, or needs to make payment from khalti to post this job.
  bool canPostJobFreely() {
    return postCount < kFreeJobPosts || role == UserRole.admin;
  }
}
