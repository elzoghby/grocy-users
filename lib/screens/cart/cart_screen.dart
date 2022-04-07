import 'package:flutter/material.dart';
import 'package:grocery/providers/cart_provider.dart';
import 'package:provider/provider.dart';

import 'component/item_card.dart';
import 'component/receipt.dart';

class CartScreen extends StatelessWidget {
  static String id = 'cartid';
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: const Text('cart items'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.red,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
         backgroundColor: Colors.black12,
        titleTextStyle: const TextStyle(color: Colors.teal),
      ),
      body: FutureBuilder(
        future: Provider.of<CartProvider>(context, listen: false).fetchCarts(),
        builder: ( context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
              child: CircularProgressIndicator(
                  backgroundColor: Colors.lightBlueAccent));
        } else if (snapshot.hasError) {
          return Center(child: Text('an error occured${snapshot.error}'));
        }
        else{
          final cartData=  Provider.of<CartProvider>(context,listen: true);

          return Stack(
            children: [

              ListView.builder(
                itemBuilder: (context, i) =>  Padding(
                  padding: const EdgeInsets.only(top: 8, bottom: 8),
                  child: CartItemCard(cart: cartData.items.values.toList()[i],),
                ),
                itemCount: cartData.items.length,
              ),
              if(cartData.items.isNotEmpty)
              Receipt(cart:cartData ,)
            ],
          );
        }
      },

      ) ,
    );
  }
}




