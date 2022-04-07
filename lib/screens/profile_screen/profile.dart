import 'package:flutter/material.dart';

import 'package:grocery/models/user.dart';
import 'package:grocery/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../components/custom_navbar.dart';
import '../../enums.dart';
import 'component/profile_field.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);
  static const id = '2';

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool nameEdit = false;
  bool numberEdit = false;
  bool addressEdit = false;
  bool emailEdit = false;


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Provider.of<UserProvider>(context, listen: false).fetch(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child: CircularProgressIndicator(
                    backgroundColor: Colors.lightBlueAccent));
          } else if (snapshot.hasError) {
            return Center(child: Text('an error occured${snapshot.error}'));
          } else {

            final User user = Provider.of<UserProvider>(context).myUser!;
            return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
            backgroundColor:Theme.of(context).cardColor,
            actions: [
          TextButton(

              onPressed: () async {
                final success =
                    await Provider.of<UserProvider>(context, listen: false)
                        .userInfo(
                            user.email, user.name, user.phone, user.address, false);
                if (success == true) {
                  Navigator.pop(context);
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
              },
              child: Text(
                'Save',
                style: TextStyle(fontSize: 16.sp, color: Theme.of(context).primaryColor),
              ))
        ]),
        body:  SingleChildScrollView(
                  padding: EdgeInsets.all(1.6.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        backgroundImage: AssetImage('images/spicy-food.png'),
                        radius: 60.w,
                      ),
                      ProfileFields(
                        hint: user.email,
                        ontap: (value) {
                          user.email = value;
                        },
                        editTab: () {
                          setState(() {
                            emailEdit = true;
                          });
                        },
                        enable: emailEdit,
                        type: TextInputType.emailAddress,
                      ),
                      ProfileFields(
                        hint: user.name,
                        ontap: (value) {
                          user.name = value;
                        },
                        editTab: () {
                          setState(() {
                            nameEdit = true;
                          });
                        },
                        enable: nameEdit,
                        type: TextInputType.name,
                      ),
                      ProfileFields(
                        hint: user.phone.toString(),
                        ontap: (value) {
                          user.phone = value;
                        },
                        editTab: () {
                          setState(() {
                            numberEdit = true;
                          });
                        },
                        enable: numberEdit,
                        type: TextInputType.number,
                      ),
                      ProfileFields(
                        hint: user.address,
                        ontap: (value) {
                          user.address = value;
                        },
                        editTab: () {
                          setState(() {
                            addressEdit = true;
                          });
                        },
                        enable: addressEdit,
                        type: TextInputType.streetAddress,
                        lines: 3,
                      ),
                    ],
                  ),
                ),


        bottomNavigationBar: CustomBottomNavBar(
          selectedMenu: MenuState.profile,
        ));
  }});
}}
