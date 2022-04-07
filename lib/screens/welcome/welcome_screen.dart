import 'package:flutter/material.dart';


import 'package:grocery/screens/sign_up/registration_screen.dart';

import '../login_screen.dart';
import 'component/regisertation_bt.dart';

class Welcome extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                'images/veg.jpg',
                fit: BoxFit.cover,
              ),
            ),
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Center(child: Text('the logo is here',style: TextStyle(color: Colors.teal),)),
                  const SizedBox(height: 20,),

                  RegiterationButtons(text: 'Login',page: LoginScreen(),),
                  const SizedBox(height: 10,),
                  RegiterationButtons(text: 'Signup',page: RegistrationScreen(),),


                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}


