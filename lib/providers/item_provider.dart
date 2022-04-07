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

  addItem(
      {required String category,
      required String name,
      required String desc,
      required double price,
      required File image,
      required String id}) async {
    final imageUrl = await DatabaseMethods().getItemPic(name, image);
    Item item = Item(
        id: id,
        category: category,
        description: desc,
        imageUrl: imageUrl,
        price: price,
        name: name,
        isFavorite: false);
    final success = await DatabaseMethods().addItem(item);

    if (success==true) {
      _items.add(item);
      notifyListeners();
      return true;
    } else {
      return success;
    }
  }

  removeProduct(String id) {
    _items.removeWhere((element) => element.id == id);
    notifyListeners();
    DatabaseMethods().removeItem(id);
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
