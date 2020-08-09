import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

class Match with ChangeNotifier {
  final String id;
  final String name;
  final String gender;
  final String job;
  final String department;
  final String photoUrl;
  final String sector;
  final String company;
  final String bio;
  final int age;
  final int accountType;
  final int points;

  Match({
    @required this.id,
    @required this.name,
    @required this.gender,
    @required this.job,
    @required this.department,
    @required this.photoUrl,
    @required this.sector,
    @required this.company,
    @required this.bio,
    @required this.age,
    @required this.accountType,
    @required this.points
  });

  String getStandardAvatar() {
    switch (gender) {
      case "male":
        return "lib/assets/icons/people/male.svg";
      case "female":
        return "lib/assets/icons/people/female.svg";
      default:
        return "lib/assets/icons/people/profile.svg";
    }
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'gender': gender,
    'job': job,
    'department': department,
    'photoUrl': photoUrl,
    'sector': sector,
    'company': company,
    'bio': bio,
    'age': age,
    'accountType': accountType,
    'points': points,
  };

  accept() {

  }

  delete() {

  }


}