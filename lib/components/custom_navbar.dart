import 'package:flutter/material.dart';

import 'package:grocery/screens/all_items_screen/all_items_screen.dart';
import 'package:grocery/screens/home/home_screen.dart';
import 'package:grocery/screens/order_screen/order_screen.dart';
import 'package:grocery/screens/profile_screen/profile.dart';

import '../enums.dart';

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({
    Key? key,
    required this.selectedMenu,
  }) : super(key: key);

  final MenuState selectedMenu;

  @override
  Widget build(BuildContext context) {
    final Color inActiveIconColor = Color(0xFFB6B6B6);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        boxShadow: [
          BoxShadow(
            offset: Offset(0, -3),
            blurRadius: 20,
            color: Color(0xFFDADADA).withOpacity(0.15),
          ),
        ],
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: SafeArea(
          top: false,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                  icon: Icon(Icons.home),
                  color: MenuState.home == selectedMenu
                      ? Colors.teal
                      : inActiveIconColor,
                  onPressed: () {
                    Navigator.pushNamed(context, Home.id);
                  }
                  //  Navigator.pushNamed(context, HomeScreen.routeName),
                  ),
              IconButton(
                icon: Icon(
                  Icons.favorite,
                  color: MenuState.favorite == selectedMenu
                      ? Colors.teal
                      : inActiveIconColor,
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AllItemsScreen(isfav: true,)));
                },
              ),
              IconButton(
                icon: Icon(
                  Icons.receipt,
                  color: MenuState.orders == selectedMenu
                      ? Colors.teal
                      : inActiveIconColor,
                ),
                onPressed: () {
                  Navigator.pushNamed(context, OrdersScreen.id);
                },
              ),
              IconButton(
                  icon: Icon(
                    Icons.account_circle_outlined,
                    color: MenuState.profile == selectedMenu
                        ? Colors.teal
                        : inActiveIconColor,
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, Profile.id);
                  }

                  // Navigator.pushNamed(context, ProfileScreen.routeName),
                  ),
            ],
          )),
    );
  }
}
