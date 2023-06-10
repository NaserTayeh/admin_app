import 'dart:convert';

class AppUser {
  String email;
  String? id;
  String? imageUrl;
  String userName;
  String userpass;
  String phoneNumber;
  bool isAdmin;
  AppUser(
      {required this.email,
      required this.userName,
      required this.phoneNumber,
      required this.userpass,
      this.id,
      this.imageUrl,
      this.isAdmin = false});

  Map<String, dynamic> toMap() {
    return {
      'emailAddress': email,
      'fullName': userName,
      'password': userpass,
    };
  }

  factory AppUser.fromMap(Map<String, dynamic> map) {
    return AppUser(
        userpass: map['password'],
        email: map['emailAddress'] ?? '',
        userName: map['fullName'] ?? '',
        phoneNumber: map['phoneNumber'] ?? '',
        imageUrl: map['imageUrl'],
        isAdmin: map['isAdmin'] ?? false);
  }

  String toJson() => json.encode(toMap());

  factory AppUser.fromJson(String source) =>
      AppUser.fromMap(json.decode(source));
}
