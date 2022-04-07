import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/user_provider.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen(this.duration, this.gotoPage);

  int duration = 0;
  Widget gotoPage;

  @override
  Widget build(BuildContext context) {

     Future.delayed(
        Duration(
          seconds: duration,
        ),
        () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => gotoPage)));

    return Scaffold(
      body: Container(
        color: Colors.teal,
        alignment: Alignment.center,
        child: const Icon(
          Icons.favorite_border,
          size: 30,
        ),
      ),
    );
  }
}
