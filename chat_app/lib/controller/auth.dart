import 'dart:convert';

import 'package:chat_app/model/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Auth with ChangeNotifier {
  String? fname = '';
  String? lname = '';
  String? gender = '';

  //SignUp & Log In
  Future<void> aut_request(String email, String password, String method,
      {String? fname, String? lname, String? gender}) async {
    this.fname = fname;
    this.lname = lname;
    this.gender = gender;
    String url =
        "https://identitytoolkit.googleapis.com/v1/accounts:$method?key=AIzaSyDEtGPGqfUUc5aVtIepVMNQ3K2TQ4vo--w";

    try {
      final res = await http.post(Uri.parse(url),
          body: json.encode({
            'email': email,
            'password': password,
            'returnSecureToken': true
          }));
      final resdata = jsonDecode(res.body);
      if (resdata['error'] != null) {
        throw resdata['error']['message'];
      } else {
        if (method == 'signUp') {
          User user = User(
              id: resdata['localId'],
              first_name: fname!,
              last_name: lname!,
              email: resdata['email'],
              gender: gender!,
              umage_url:
                  'https://www.google.com/search?q=image+user&sxsrf=APq-WBtu1U_yc2pvwJ3olUwx9z5EeoPp1Q:1647877375612&tbm=isch&source=iu&ictx=1&vet=1&fir=4kXGls3qUNG46M%252Cu1SY3va6wsUW9M%252C_%253BWN1ZVDaSPGIKeM%252CaaowI9IWhkMM3M%252C_%253BP6AlQsrs5ks3RM%252CnKbZ7-T8tpkWLM%252C_%253BKnR9uI1e8d4qTM%252CIuY_NaZ2k4MpJM%252C_%253BjzLGk2_vrr2J8M%252Cx8M0a6B2rIP-XM%252C_%253B88B5e2_5bsGKgM%252CKxKM_2p9Iw3vnM%252C_%253B95h6SMZvK0Jh_M%252Cx8M0a6B2rIP-XM%252C_%253BksweUyHJewvXXM%252CP2GhsC3zFY6nrM%252C_%253BAgu8-ECdH8TgqM%252CLpuS0x_nac3LYM%252C_%253BDS4EgFyc5oiyuM%252CaWImjUDfpSarFM%252C_%253BXdC5LtXPQjByAM%252CdDCOL4ybBjBxtM%252C_%253BpOq9fvJabj6E8M%252CJmTN_lQo3NRiZM%252C_%253BB660X6hvLXc36M%252CaaowI9IWhkMM3M%252C_%253B25ueDBlTN15qmM%252CdH9RtTEUJxcyyM%252C_%253BMPNA2k6UZHFbzM%252CFtRKGlUzid6BIM%252C_%253Bgih4LeqsiUeY7M%252CNuov5WBS_reG6M%252C_&usg=AI4_-kRhdQ9uLpYIQkdNOOzKwBMhzIbVrQ&sa=X&ved=2ahUKEwiK_ezMxdf2AhWM3oUKHbGFB3UQ9QF6BAgcEAE#imgrc=ksweUyHJewvXXM',
              conversations: []);

          addUser(user);
        }

        //else Log in

      }
    } catch (e) {
      rethrow;
    }
    notifyListeners();
  }

  //Add new user to fire store
  final users = FirebaseFirestore.instance.collection('/users');
  Future<void> addUser(User user) async {
    await users
        .add({
          'first_name': user.first_name,
          'last_name': user.last_name,
          'email': user.email,
          'gender': user.gender,
          'image': user.umage_url,
          'uid': user.id,
          'conversations': user.conversations
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
    notifyListeners();
  }
}
