import 'package:flutter/material.dart';
import 'package:grocery/components/custom_navbar.dart';

import 'package:grocery/enums.dart';
import 'package:grocery/screens/home/components/body.dart';
import 'package:provider/provider.dart';

import '../../providers/cart_provider.dart';
import '../../providers/item_provider.dart';
import '../../providers/user_provider.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  static const id = '1';

  @override
  State<Home> createState() => _HomeState();
}

Future<void> fetcher(BuildContext context) async {
  Provider.of<ItemsProvider>(context, listen: false).fetchItems();
  Provider.of<CartProvider>(context, listen: false).fetchCarts();

}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: const Color(0x3B3C53),
      body: FutureBuilder(
          future: fetcher(context),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                  child: CircularProgressIndicator(
                      backgroundColor: Colors.lightBlueAccent));
            } else if (snapshot.hasError) {
              return Center(child: Text('an error occured${snapshot.error}'));
            } else {
              return Body();
            }
          }),
      backgroundColor: Theme.of(context).backgroundColor,
      bottomNavigationBar: CustomBottomNavBar(
        selectedMenu: MenuState.home,
      ),
    );
  }
}
