import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'package:grocery/providers/cart_provider.dart';
import 'package:provider/provider.dart';

import '../../../components/badge.dart';
import '../../cart/cart_screen.dart';

class TopBar extends StatelessWidget {
  const TopBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: 2.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
        Text('Enjoy shopping',style: TextStyle(fontSize: 24.sp,color: Colors.white),),

          Consumer<CartProvider>(
            builder: (key, cart, c) => Badge(
              child: c!,
              value: cart.getCount().toString(),
              color:Colors.teal
            ),
            child: IconButton(
              icon: Icon(Icons.shopping_cart, color:Colors.white),iconSize: 25.sp,
              onPressed: () {
                Navigator.pushNamed(context, CartScreen.id);
              },
            ),
          )
        ],
      ),
    );
  }
}
