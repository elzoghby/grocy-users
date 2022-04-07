import 'package:flutter/material.dart' ;
import '../models/user.dart';
import '../services/database_methods.dart';

class UserProvider with ChangeNotifier {
  User? myUser ;
fetch() async {
 myUser = await DatabaseMethods().fetchUser();
 notifyListeners();
}
  userInfo(String email, String name, int phone, String address ,bool signup ) async {
    final User user =User(email, name, phone, address);

    notifyListeners();
    try{
      if (signup) {
        await DatabaseMethods().setUserInfo(user);

      } else {
        await DatabaseMethods().updateUserInfo(
          email,
          name,
          address,
          phone,
        );
      }
      return true;
    }
    catch(e){
      return e;
    }

  }
}
