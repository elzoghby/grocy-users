import 'dart:math';


import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import '../../../models/order.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
class OrderItem extends StatefulWidget {
  final Order order;

  OrderItem(this.order);

  @override
  _OrderItemState createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  bool expand = false;

  @override
  Widget build(BuildContext context) {

    return AnimatedContainer(

      duration: Duration(milliseconds: 300),
      height: expand ? min(10 * 20.0 + 1170, 300) : 150,
      child: Column(
        children: <Widget>[
          ListTile(
            leading:
                Icon(Icons.shopping_bag_outlined, color: Colors.orange,),
            title: Text(
              'ordered',
              style: TextStyle(
                  color: Colors.green,
                  fontSize: 17.sp),
            ),
            subtitle: Text(
              DateFormat('dd/MM/yyyy hh:mm').format(widget.order.dateTime!),
              style: TextStyle(
                  color: Colors.greenAccent,
                  fontSize: 14.sp),
            ),
            trailing:Text('amout: \$${widget.order.total}',   style: TextStyle(
                color: Colors.greenAccent,
                fontSize: 17.sp),
            ),
          ),
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 3.w),
            child: Row(mainAxisAlignment:MainAxisAlignment.spaceBetween,children: [
              Text('view order detail',
              style: TextStyle(color: Colors.grey,fontSize: 17.sp),),
              IconButton(
                icon: Icon(expand ? Icons.expand_less : Icons.expand_more),
                onPressed: () {
                  setState(() {
                    expand = !expand;
                  });
                },
              ),
            ]),
          ),
          AnimatedContainer(
            duration: Duration(milliseconds: 300),
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
            height: expand
                ? min(widget.order.listOfProducts!.length * 20.0 + 10, 20.h)
                : 0,
            child: ListView(
              children: widget.order.listOfProducts!
                  .map(
                    (pro) => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          pro.myProduct!.name!,
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          ' \$${pro.myProduct!.price} X${pro.quantity}',
                          style: TextStyle(fontSize: 18, color: Colors.grey),
                        )
                      ],
                    ),
                  )
                  .toList(),
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
