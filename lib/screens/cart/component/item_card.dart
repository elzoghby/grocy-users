import 'package:flutter/material.dart';
import 'package:grocery/models/cart.dart';
import 'package:grocery/providers/cart_provider.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CartItemCard extends StatelessWidget {
  const CartItemCard({Key? key, required this.cart}) : super(key: key);
  final Cart cart;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
        key: ValueKey(cart),
        background: Container(
          decoration: const BoxDecoration(
              color: Colors.redAccent,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(7),
                  bottomRight: Radius.circular(7))),
          alignment: Alignment.centerRight,
          padding: EdgeInsets.only(right: 5.w),
          margin: EdgeInsets.all(2.w),
          child: Icon(
            Icons.delete,
            color: Colors.white,
            size: 25.sp,
          ),
        ),
        direction: DismissDirection.endToStart,
        confirmDismiss: (direction) {
          return showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    title: Text('Are you sure?'),
                    content:
                        Text('Do you want to remove this item from the cart?'),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(false);
                          },
                          child: Text('No')),
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(true);
                          },
                          child: Text('Yes')),
                    ],
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                elevation: 1,
                  ));
        },
        onDismissed: (direction) {
          Provider.of<CartProvider>(context, listen: false)
              .removeItem(cart.myProduct!.id!);
        },
        child: Card(
            color: Theme.of(context).cardColor ,
            margin: EdgeInsets.all(2.w),
            shape: Border.all(color: Colors.black12, width: 1,),

            shadowColor: Colors.white70,
            child: ListTile(
              leading: ClipOval(
                child: Image.network(
                  cart.myProduct!.imageUrl!,
                  width: 20.w,
                  height: 20.w,
                  fit: BoxFit.cover,
                ),
              ),
              title: Text(
                cart.myProduct!.name!,
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600),
              ),
              subtitle: Text(
                "${cart.myProduct!.price!} X${cart.quantity}",
                style: TextStyle(
                  color: Theme.of(context).shadowColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 14.sp,
                ),
              ),
              trailing: Text('swap to delete',
                  style: TextStyle(color: Theme.of(context).shadowColor)),
            )));
  }
}
