import 'package:flutter/material.dart';
import 'package:grocery/providers/order_provider.dart';

import 'package:provider/provider.dart';

import '../../components/custom_navbar.dart';

import '../../enums.dart';
import 'component/order_item.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({Key? key}) : super(key: key);
  static String id = 'orderid';

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: const Text('my order'),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: Provider.of<OrderProvider>(context,listen: false).fetchOrders(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {

            return const Center(
                child: CircularProgressIndicator(
                    backgroundColor: Colors.lightBlueAccent));
          } else if (snapshot.hasError) {
            return Center(child: Text('an error occured${snapshot.error}'));
          } else {


            return Consumer<OrderProvider>(
              builder: (c, order, child) => ListView.builder(
                itemBuilder: (context, i) => OrderItem(order.orders[i]),
                itemCount: order.orders.length,
              ),
            );
          }
        },
      ),
      bottomNavigationBar: CustomBottomNavBar(
        selectedMenu: MenuState.orders,
      ),
    );
  }
}
