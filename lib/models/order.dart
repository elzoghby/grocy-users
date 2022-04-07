import 'cart.dart';

class Order{

  final String? id;
  final double? total;
  final List<Cart>? listOfProducts;
  final DateTime? dateTime;
   Order({this.id, this.total, this.dateTime, this.listOfProducts});
}