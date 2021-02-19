class User {
  String id;
  String name;
  String phone;
  String email;
  String university;
  String profession;
  User(
      {this.id,
      this.name,
      this.phone,
      this.email,
      this.university,
      this.profession});

  factory User.fromJson(Map<String, dynamic> json) => User(
      id: json["_id"],
      name: json["name"],
      phone: json["phone"],
      email: json["email"],
      university: json["university"],
      profession: json['profession']);

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "phone": phone,
        "email": email,
        "university": university,
        "profession": profession
      };
}
