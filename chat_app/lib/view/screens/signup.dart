import 'package:chat_app/view/widgets/input_fileld.dart';
import 'package:chat_app/view/widgets/singup_gender_box.dart';
import 'package:flutter/material.dart';

class Signup_Screen extends StatefulWidget {
  const Signup_Screen({Key? key}) : super(key: key);

  @override
  State<Signup_Screen> createState() => _Signup_ScreenState();
}

class _Signup_ScreenState extends State<Signup_Screen> {
  final GlobalKey<FormState> _key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Container(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.0),
          child: SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.06,
                  ),
                  const Text(
                    'Chat App',
                    style: TextStyle(
                      fontFamily: 'Kalam',
                      fontWeight: FontWeight.bold,
                      fontSize: 35,
                      color: Colors.blueAccent,
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                  const SizedBox(
                    width: double.infinity,
                    child: Text(
                      'Sign Up',
                      style: TextStyle(
                        fontFamily: 'Kalam',
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Form(
                    key: _key,
                    child: Column(
                      children: [
                        SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(child: Input_Field('First Name')),
                            SizedBox(width: 15),
                            Flexible(child: Input_Field('Last Name')),
                          ],
                        ),
                        SizedBox(height: 15),
                        Input_Field('Email', type: TextInputType.emailAddress),
                        SizedBox(height: 15),
                        Input_Field('Password', icon: Icons.remove_red_eye),
                        SizedBox(height: 15),
                        Input_Field('Confirm Password',
                            icon: Icons.remove_red_eye),
                        SizedBox(height: 15),
                        const SizedBox(
                            width: double.infinity,
                            child: Text('Gender:',
                                style: TextStyle(
                                  fontSize: 17,
                                  color: Colors.black54,
                                ))),
                        SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                                child: Signup_Gender_Box(
                                    Icons.male, Colors.black)),
                            SizedBox(width: 15),
                            Expanded(
                                child: Signup_Gender_Box(
                                    Icons.female, Colors.black)),
                          ],
                        ),
                      ],
                    ),
                  )
                ]),
          ),
        ),
      ),
    );
  }
}
