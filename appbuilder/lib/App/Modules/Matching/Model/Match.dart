import 'package:flutter/cupertino.dart';

class Match with ChangeNotifier {
  final String id;
  final String name;
  final String gender;
  final String photoUrl;
  final String bio;
  final int age;
  final int points;
  Match(
    this.id,
    this.name,
    this.gender,
    this.photoUrl,
    this.bio,
    this.age,
    this.points,
  );

  Match.fromStream(this.id, Map<String, dynamic> doc)
      : name = doc['name'],
        gender = doc['gender'],
        photoUrl = doc['photoUrl'],
        bio = doc['bio'],
        age = doc['age'],
        points = doc['points'];

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
        'photoUrl': photoUrl,
        'bio': bio,
        'age': age,
        'points': points,
      };
}
