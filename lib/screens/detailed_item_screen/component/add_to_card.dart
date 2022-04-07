import 'package:flutter/material.dart';
import 'package:grocery/models/items.dart';
import 'package:grocery/providers/cart_provider.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AddToCart extends StatefulWidget {
   AddToCart({
required this.item,
    Key? key,
  }) : super(key: key);
   final Item item;

  @override
  State<AddToCart> createState() => _AddToCartState();
}

class _AddToCartState extends State<AddToCart> {
 int count=1 ;

  @override
  Widget build(BuildContext context) {
    return Container(
padding: EdgeInsets.all(5.w),
      decoration: const BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(color: Colors.black12, blurRadius: 20, offset: Offset.zero)
      ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                padding:
                EdgeInsets.symmetric(horizontal: 1.w),
                onPressed: () {
                  if(count!=10){
                    count++;

                  setState(() {

                  });

                  }
                  else{
                    return;
                  }
                },
                icon: Icon(
                  Icons.add_circle_outline,
                  color: Colors.red,
                  size: 26.sp,

                ),
              ),
              Text(
                '$count kg',
                style: TextStyle(fontSize: 24.sp),
              ),
              IconButton(
                padding:
                EdgeInsets.symmetric(horizontal: 1.6.w),
                onPressed: () {
                  if(count!=1){
                    --count;
                      setState(() {
                        
                      });
                  }
                },
                icon:  Icon(
                  Icons.remove_circle_outline,
                  size: 26.sp,
                ),
              ),
            ],
          ),
          ElevatedButton.icon(
            onPressed: () {
              Provider.of<CartProvider>(context,listen: false).addItem(widget.item, count);
              print('$count');
            },
            icon: Icon(
              Icons.shopping_cart_outlined,
              size: 26.sp,
            ),
            label: Text(
              'Add to cart',
              style: TextStyle(fontSize: 18.sp),
            ),
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.all(2.5.w),

              primary: Colors.teal,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(35),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
