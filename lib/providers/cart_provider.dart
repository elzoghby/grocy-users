import 'package:flutter/material.dart';
import 'package:grocery/models/items.dart';

import '../models/cart.dart';
import '../services/database_methods.dart';

class CartProvider with ChangeNotifier {
  Map<String, Cart> _items = {};
  Map<String, Cart> savedItems = {};

  Map<String, Cart> get items {
    return {..._items};
  }

  double getTotal() {
    double numberOfProducts = 0;
    for (int i = 0; i < _items.length; i++) {
      numberOfProducts += (_items.values.toList()[i].quantity! *
          _items.values.toList()[i].myProduct!.price!);
    }
    return numberOfProducts;
  }

  int getCount() {
    int numberOfProducts = 0;
    for (int i = 0; i < _items.length; i++) {
      numberOfProducts += _items.values.toList()[i].quantity!;
    }
    return numberOfProducts;
  }

  fetchCarts() async {
    DatabaseMethods databaseMethods = DatabaseMethods();
    _items = await databaseMethods.fetchCartData();
    notifyListeners();
  }

  addItem(Item item ,int quantity) async {
    DatabaseMethods databaseMethods = DatabaseMethods();
    late Cart updatedCart;
    if (_items.containsKey(item.id)) {
      _items.update(item.id!, (existingValue) {
        Cart cart = Cart(
          myProduct: existingValue.myProduct,
          quantity: existingValue.quantity! + quantity,
        );
        updatedCart = cart;
        return updatedCart;
      });
      await databaseMethods.addCartItem(updatedCart, true);
    } else {
      _items.putIfAbsent(
        item.id!,
        () {
          Cart cart = Cart(
            myProduct: item,
            quantity: quantity,
          );
          updatedCart = cart;
          return updatedCart;
        },
      );
      await databaseMethods.addCartItem(updatedCart, false);
    }
    notifyListeners();
  }

  removeItem(String cartId) async {
    await DatabaseMethods().removeSingleCartItem(cartId);
    _items.removeWhere((key, value) => key == cartId);
    notifyListeners();
  }

  removeAllItems() async {
    await DatabaseMethods().removeAllCartItems();
    _items.clear();
    notifyListeners();
  }



}
