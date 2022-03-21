import 'package:chat_app/controller/auth.dart';
import 'package:chat_app/view/widgets/input_fileld.dart';
import 'package:chat_app/view/widgets/singup_gender_box.dart';
import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:provider/provider.dart';

class Signup_Screen extends StatefulWidget {
  const Signup_Screen({Key? key}) : super(key: key);

  @override
  State<Signup_Screen> createState() => _Signup_ScreenState();
}

class _Signup_ScreenState extends State<Signup_Screen> {
  final GlobalKey<FormState> _key = GlobalKey();
  var agree = false;
  bool _isloading = false;
  Color? bordercolormale;
  Color? bordercolorfemale;
  TextEditingController fname = TextEditingController();
  TextEditingController lname = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController passwd = TextEditingController();
  TextEditingController cpasswd = TextEditingController();
  String gender = "";

  @override
  Widget build(BuildContextcontext) {
    return Scaffold(
      appBar: null,
      body: _isloading
          ? const Center(child: CircularProgressIndicator())
          : Container(
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
                        Text(
                          'Chat App',
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.03),
                        SizedBox(
                          width: double.infinity,
                          child: Text(
                            'Sign Up',
                            style: Theme.of(context).textTheme.headline5,
                          ),
                        ),
                        Form(
                          key: _key,
                          child: Column(
                            children: [
                              SizedBox(height: 15),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                      child: Input_Field('First Name', fname)),
                                  SizedBox(width: 15),
                                  Flexible(
                                      child: Input_Field('Last Name', lname)),
                                ],
                              ),
                              SizedBox(height: 15),
                              Input_Field('Email', email,
                                  type: TextInputType.emailAddress),
                              SizedBox(height: 15),
                              Input_Field(
                                'Password',
                                passwd,
                                icon: Icons.remove_red_eye,
                              ),
                              SizedBox(height: 15),
                              Input_Field(
                                'Confirm Password',
                                cpasswd,
                                icon: Icons.remove_red_eye,
                                ctext: passwd.text.toString(),
                              ),
                              SizedBox(height: 15),
                              SizedBox(
                                  width: double.infinity,
                                  child: Text('Gender:',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline4)),
                              SizedBox(height: 5),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                      child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        bordercolormale = Colors.blue;
                                        bordercolorfemale =
                                            Theme.of(context).primaryColor;
                                        gender = 'male';
                                      });
                                    },
                                    child: Signup_Gender_Box(
                                        Icons.male,
                                        bordercolormale ??
                                            Theme.of(context).primaryColor),
                                  )),
                                  SizedBox(width: 15),
                                  Expanded(
                                      child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        bordercolorfemale = Colors.blue;
                                        bordercolormale =
                                            Theme.of(context).primaryColor;
                                        gender = 'female';
                                      });
                                    },
                                    child: Signup_Gender_Box(
                                        Icons.female,
                                        bordercolorfemale ??
                                            Theme.of(context).primaryColor),
                                  )),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 15),
                        CheckboxListTile(
                            activeColor: Colors.blue,
                            contentPadding: EdgeInsets.zero,
                            controlAffinity: ListTileControlAffinity.leading,
                            title: Text('I agree to the Terms & Conditions'),
                            value: agree,
                            onChanged: (val) {
                              setState(() {
                                agree = val!;
                              });
                            }),
                        SizedBox(height: 15),
                        SizedBox(
                          width: double.infinity,
                          height: 60,
                          child: ElevatedButton(
                              child: const Text(
                                'Create Account',
                                style: TextStyle(fontSize: 18),
                              ),
                              onPressed: () async {
                                if (_key.currentState!.validate() &&
                                    gender != '' &&
                                    agree) {
                                  _key.currentState!.save();
                                  setState(() {
                                    _isloading = true;
                                  });

                                  try {
                                    await Provider.of<Auth>(context,
                                            listen: false)
                                        .aut_request(email.text.trim(),
                                            passwd.text, 'signUp',
                                            fname: fname.text,
                                            lname: lname.text,
                                            gender: gender);
                                    setState(() {
                                      _isloading = false;
                                      fname.clear();
                                      lname.clear();
                                      email.clear();
                                      passwd.clear();
                                      cpasswd.clear();
                                      gender = '';
                                      agree = false;
                                      bordercolormale =
                                          Theme.of(context).primaryColor;
                                      bordercolorfemale =
                                          Theme.of(context).primaryColor;
                                      MotionToast(
                                              icon: Icons
                                                  .check_circle_outline_outlined,
                                              primaryColor: Colors.blueAccent,
                                              title: Text("Sucess !!"),
                                              description:
                                                  Text("New account created"))
                                          .show(context);
                                    });
                                  } catch (error) {
                                    MotionToast(
                                            icon: Icons
                                                .check_circle_outline_outlined,
                                            primaryColor: Colors.orange,
                                            title: Text("Wait !!"),
                                            description: Text(error.toString()))
                                        .show(context); setState(() {
                                    _isloading = false;
                                  });
                                  }

                                 
                                } else {
                                  MotionToast(
                                          icon: Icons.warning_amber_outlined,
                                          primaryColor: Colors.redAccent,
                                          title: Text("Warning !!"),
                                          description:
                                              Text("All fields are required"))
                                      .show(context);
                                }
                                setState(() {});

                                //sign up
                              }),
                        ),
                        const SizedBox(height: 15),
                        const Text.rich(
                          TextSpan(children: [
                            TextSpan(text: 'Already Registred?'),
                            TextSpan(
                                text: ' LOG IN',
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold))
                          ]),
                        ),
                        SizedBox(height: 15)
                      ]),
                ),
              ),
            ),
    );
  }
}
