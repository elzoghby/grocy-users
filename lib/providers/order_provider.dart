
import 'package:flutter/material.dart';

import '../models/cart.dart';
import '../models/order.dart';
import '../services/database_methods.dart';

class OrderProvider with ChangeNotifier {
  List<Order> _orders = [];
  List<Order> get orders{
    return [..._orders];
  }

  addOrder(List<Cart> cartProducts, double total) async {
    final timeStamp = DateTime.now();
    Order order = Order(
        id: timeStamp.toIso8601String(),
        total: total,
        dateTime: timeStamp,
        listOfProducts: cartProducts);
    await DatabaseMethods().addOrder(order);
    _orders.add(order);
    notifyListeners();
  }

  fetchOrders() async {
    _orders = await DatabaseMethods().fetchOrders();
    notifyListeners();
  }
}
