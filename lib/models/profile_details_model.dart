import 'package:task_mate/models/profile_model.dart';

class ProfileDetailsModel {
  String? status;
  List<ProfileDetails>? profileDetails;

  ProfileDetailsModel({this.status, this.profileDetails});

  ProfileDetailsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      profileDetails = <ProfileDetails>[];
      json['data'].forEach((v) {
        profileDetails!.add(ProfileDetails.fromJson(v));
      });
    }
  }
}
