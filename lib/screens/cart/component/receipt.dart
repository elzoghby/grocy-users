import 'package:flutter/material.dart';


import 'package:grocery/providers/cart_provider.dart';
import 'package:grocery/screens/home/home_screen.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../providers/order_provider.dart';

class Receipt extends StatelessWidget {
  const Receipt({
    required this.cart,
    Key? key,
  }) : super(key: key);
  final CartProvider cart;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.horizontal(
            left: Radius.circular(20),
            right: Radius.circular(20),
          ),
          color: Colors.white,
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(1.5.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                   Text(
                    'Delivery',
                    style: TextStyle(fontSize: 20.sp, color: Colors.red),
                  ),
                  Text(
                    '\$ 5 ',
                    style: TextStyle(
                      fontSize: 16.sp,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total',
                    style: TextStyle(
                        fontSize: 16.sp,
                        color: Colors.red),
                  ),
                  Text(
                    '\$ ${cart.getTotal() + 5} ',
                    style: TextStyle(
                      fontSize: 15.sp,
                    ),
                  ),
                ],
              ),
            ),
            TextButton(
              onPressed: () async {
                await Provider.of<OrderProvider>(context, listen: false)
                    .addOrder(cart.items.values.toList(), cart.getTotal()+5);
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text(' order placed'),
                      content:
                      Text('the delivery will call you shortly'),
                      actions: [
                        TextButton(onPressed: () {
                          Navigator.pushNamed(context, Home.id);
                        },
                        child: const Text('Ok'),)
                      ],
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                    ));
                await Provider.of<CartProvider>(context, listen: false)
                    .removeAllItems();
              },
              child: const Text('Checkout'),
              style: TextButton.styleFrom(
                primary: Colors.white,
                shadowColor: Colors.teal,
                backgroundColor: Colors.red,

              ),
            ),
          ],
        ),
      ),
    );
  }
}
