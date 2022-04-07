import 'dart:io';
import 'package:flutter/material.dart';
import 'package:grocery/models/items.dart';
import '../services/database_methods.dart';

class ItemsProvider with ChangeNotifier {
  List<Item> _items = [];

  List<Item> get items {
    return [..._items];
  }

  List<Item> getFav() {


    return [..._items].where((element) => element.isFavorite == true).toList();

  }

  changefav(String id) async {
    final Item item =_items.firstWhere((element) => element.id == id);
    item.isFavorite=!item.isFavorite!;
    notifyListeners();
    await  DatabaseMethods().handleToggleLike(
        id, item.isFavorite!);

  }
  Item findById(String id) {

    return _items.firstWhere((element) => element.id == id);

  }
  List<Item> findByCategory(String category){

   final cat= _items.where((element) => element.category==category).toList();

    return cat;
  }

  fetchItems() async {
    _items = await DatabaseMethods().fetchItem();
    notifyListeners();

  }



  searchForProduct(String title) {
    List<Item> searchedProducts = [];
    for (int i = 0; i < _items.length; i++) {
      if (_items[i].name!.toLowerCase().contains(title.toLowerCase())) {
        searchedProducts.add(_items[i]);
      }
    }
    return searchedProducts;
  }
}
