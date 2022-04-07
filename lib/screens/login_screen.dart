

import 'package:flutter/material.dart';


import 'package:firebase_auth/firebase_auth.dart';

import 'package:grocery/screens/additemscreen/add_item_screen.dart';

import 'package:grocery/services/auth.dart';
import 'package:responsive_sizer/responsive_sizer.dart';


import '../components/constants.dart';

class LoginScreen extends StatefulWidget {
  static const id = '3';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final auth = FirebaseAuth.instance;
  String? email;
  String? password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Flexible(
              child: SizedBox(
                height: 200.0,
                child: Image.asset('images/fruit.png'),
              ),
            ),
            SizedBox(
              height: 6.h,
            ),
            TextField(
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  email = value;
                },
                decoration: decoration.copyWith(hintText: 'Enter your email')),
            SizedBox(
              height: 0.8.h,
            ),
            TextField(
                obscureText: true,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  password = value;
                },
                decoration:
                decoration.copyWith(hintText: 'Enter your password')),
            SizedBox(
              height: 5.h,
            ),
            TextButton(
                onPressed: () async {
                  if (email != null && password != null) {
                    final success = await AuthMethods().logIn(
                        email!, password!);
                    if (success==true) {
                      Navigator.pushNamed(context, AddProduct.id);

                    }

                    else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            ' error: $success',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.redAccent,
                            ),
                          ),
                        ),
                      );
                    }

                }  else{
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'fill all fields to continue',
                          textAlign: TextAlign.center,
                          style: TextStyle(

                            color: Colors.redAccent,
                          ),
                        ),
                      ),
                    );
                  }
                },

                child: Text(
                  'Login',
                  style: TextStyle(fontSize: 16.sp),
                ))
          ],
        ),
      ),
    );
  }
}
