import 'dart:convert';

class User {
  String id;
  String first_name;
  String last_name;
  String email;
  String gender;
  String umage_url;
  List<String> conversations;

  User({
    required this.id,
    required this.first_name,
    required this.last_name,
    required this.email,
    required this.gender,
    required this.umage_url,
    required this.conversations,
  });
}
