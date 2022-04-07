import 'package:flutter/material.dart';
import 'package:grocery/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../components/constants.dart';

\


class UserScreen extends StatelessWidget {
   UserScreen({this.email ,Key? key}) : super(key: key);
   String? email;
  int? phone;
  String? address;
  String? name;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [


              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  keyboardType: TextInputType.emailAddress,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    name = value;
                  },
                  decoration: decoration.copyWith(hintText: 'Enter your name'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  keyboardType: TextInputType.emailAddress,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    address = value;
                  },
                  decoration: decoration.copyWith(hintText: 'Enter your address'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                    keyboardType: TextInputType.phone,
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      phone = int.tryParse(value);
                    },
                    decoration: decoration.copyWith(
                      hintText: 'Enter your phone number',
                    )),
              ),
              SizedBox(height: 2.h,),
              TextButton(
                  child: const Text(
                    'add info',
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
                    if (name == null ||
                        phone == null ||
                        email == null ||
                        address == null
                       ) {


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
                      final success = await Provider.of<UserProvider>(context, listen: false).userInfo(email!, name!,phone!, address!,true);
                      if (success == true) {
                        Navigator.pushNamed(context, Home.id);
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
      ),
    );
  }
}
