import 'package:flutter/material.dart';
import 'package:grocery/components/search_field.dart';
import 'package:grocery/models/category.dart';
import 'package:grocery/providers/item_provider.dart';
import 'package:provider/provider.dart';


import '../../components/categories.dart';
import '../../components/custom_navbar.dart';
import '../../components/products_grid.dart';
import '../../enums.dart';

import '../home/components/top_bar.dart';
class AllItemsScreen extends StatelessWidget {
   AllItemsScreen({this.isfav=false,Key? key}) : super(key: key);
  final bool isfav ;
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SafeArea(


          child: Column(
            children: [
              TopBar(),
              SearchField(),
              Categories(),
          ProductsGrid(items: isfav?Provider.of<ItemsProvider>(context).getFav():Provider.of<ItemsProvider>(context).items,),
            ],

        ),
      ),
        bottomNavigationBar: isfav? CustomBottomNavBar(selectedMenu: MenuState.favorite,):null
    );
  }
}
