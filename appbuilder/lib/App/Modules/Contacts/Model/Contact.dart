class Contact {
  String id;
  String name;
  String gender;
  String photoUrl;
  String bio;
  int accountType;
  int age;
  int points;

  Contact(this.id,
      this.name,
      this.gender,
      this.photoUrl,
      this.bio,
      this.accountType,
      this.age,
      this.points,);

  Contact.fromStream(this.id, Map<String, dynamic> doc) {
    name = doc['name'];
    gender = doc['gender'];
    photoUrl = doc['photoUrl'];
    bio = doc['bio'];
    accountType = doc['accountType'];
    age = doc['age'];
    points = doc['points'];
  }

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

  Map<String, dynamic> toJson() =>
      {
        'id': id,
        'name': name,
        'gender': gender,
        'photoUrl': photoUrl,
        'bio': bio,
        'age': age,
        'points': points,
      };
}
