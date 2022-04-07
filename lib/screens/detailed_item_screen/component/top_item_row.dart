import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../components/badge.dart';
import '../../../providers/cart_provider.dart';
import '../../cart/cart_screen.dart';
class TopItemRow extends StatelessWidget {
   TopItemRow({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.all(1.4.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(onPressed: (){
            Navigator.pop(context);
          }, icon: const Icon(Icons.arrow_back_rounded)),
          Consumer<CartProvider>(
            builder: (key, cart, c) => Badge(
                child: c!,
                value: cart.getCount().toString(),
                color:Colors.teal
            ),
            child: IconButton(
              icon: const Icon(Icons.shopping_cart, color:Colors.white),iconSize: 26.sp,
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