import 'package:flutter/material.dart';


import 'package:grocery/screens/user_screen/user_screen.dart';
import 'package:grocery/services/auth.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../components/constants.dart';


class RegistrationScreen extends StatelessWidget {
  RegistrationScreen({Key? key}) : super(key: key);

  String? email;
  String? password;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: 3.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Flexible(
              child: Container(
                height: 25.h,
                child: Image.asset('images/Logo.png'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  email = value;
                },
                decoration: decoration.copyWith(hintText: 'Enter your email'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                  obscureText: true,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    password = value;
                  },
                  decoration:
                      decoration.copyWith(hintText: 'Enter your password')),
            ),
            SizedBox(
              height: 3.h,
            ),
            TextButton(
                child: const Text(
                  'Registration',
                ),
                style: TextButton.styleFrom(
                  padding: EdgeInsets.all(2.w),
                  backgroundColor: Colors.blueGrey,
                  primary: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                ),
                //  color: Colors.blueAccent,
                onPressed: () async {
                  if (email == null || password == null) {
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
                  } else {
                    final success = await AuthMethods()
                        .signUp(email: email!, password: password!);
                    if (success == true) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => UserScreen(email: email,)));
                    } else {
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
                  }
                }),
          ],
        ),
      ),
    );
  }
}
