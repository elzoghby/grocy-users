import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:grocery/models/items.dart';

import '../models/cart.dart';
import '../models/order.dart';
import '../models/user.dart';

class  DatabaseMethods {
  final userId = auth.FirebaseAuth.instance.currentUser!.uid;
  final CollectionReference refUsers =
      FirebaseFirestore.instance.collection('users');
  final CollectionReference refItems =
      FirebaseFirestore.instance.collection('groceries');
  final CollectionReference refFavorites =
      FirebaseFirestore.instance.collection('favorites');
  final CollectionReference refCarts =
      FirebaseFirestore.instance.collection('carts');
  final CollectionReference refOrders =
      FirebaseFirestore.instance.collection('orders');

  setUserInfo(
    User myUser,
  ) async {
   try {
      Map<String, dynamic> info = {
        "email": myUser.email,
        "userName": myUser.name,
        "phone": myUser.phone.toString(),
        'address': myUser.address,
      };
      await refUsers.doc(userId).set(info);
      return true;
    }
    catch(e){
     return e;
    }
  }

  updateUserInfo(
    String email,
    String name,
    String address,
    int phone,
  ) async {
    await refUsers.doc(userId).update({
      'email': email,
      'userName': name,
      'phone': phone.toString(),
      'address': address,
    });
  }

  fetchUser() async {

    final userInfo = await refUsers.doc(userId).get();

    User user =  User(userInfo['email'], userInfo['userName'], int.parse(userInfo['phone']),
        userInfo['address']);

    return user;
  }

  handleToggleLike( String productId, bool state) async {
    if (state) {
      await refFavorites
          .doc(userId)
          .collection('groceries')
          .doc(productId)
          .set({"state": true});
    } else {
      await refFavorites
          .doc(userId)
          .collection('groceries')
          .doc(productId)
          .delete();
    }
  }

  checkState(String userId, String productId) async {
    DocumentSnapshot doc = await refFavorites
        .doc(userId)
        .collection('groceries')
        .doc(productId)
        .get();
    if (doc.exists) {

      return true;
    } else {
      return false;
    }
  }

  fetchCartData() async {
    Map<String, Cart> cartMap = {};
    QuerySnapshot snapshot =
        await refCarts.doc(userId).collection('items').get();
    List<dynamic> carts = snapshot.docs;
    for (int i = 0; i < carts.length; i++) {
      Item myProduct = Item(
        id: carts[i]['id'],
        name: carts[i]['title'],
        price: carts[i]['price'].toDouble(),
        imageUrl: carts[i]['imageUrl'],
      );
      Cart myCart = Cart(
        myProduct: myProduct,
        quantity: carts[i]['quantity'],
      );
      cartMap.putIfAbsent(myProduct.id!, () => myCart);
    }
    return cartMap;
  }

  addCartItem(Cart cart, bool alreadyExists) async {
    if (!alreadyExists) {
      await refCarts
          .doc(userId)
          .collection('items')
          .doc(cart.myProduct!.id)
          .set({
        'id': cart.myProduct!.id,
        'imageUrl': cart.myProduct!.imageUrl,
        'price': cart.myProduct!.price,
        'title': cart.myProduct!.name,
        'quantity': cart.quantity,
      });
    } else {
      await refCarts
          .doc(userId)
          .collection('items')
          .doc(cart.myProduct!.id)
          .update({'quantity': cart.quantity});
    }
  }

  removeSingleCartItem(String productId) async {
    return await refCarts
        .doc(userId)
        .collection('items')
        .doc(productId)
        .delete();
  }

  removeAllCartItems() async {
    refCarts.doc(userId).collection('items').get().then((snapshot) {
      for (DocumentSnapshot ds in snapshot.docs) {
        ds.reference.delete();
      }
    });
  }

  addOrder(Order order) async {
    await refOrders.doc(userId).collection('orders').doc(order.id).set({
      'dateTime': order.dateTime!.toIso8601String(),
      'amount': order.total.toString(),
      'listOfProducts': order.listOfProducts!
          .map((e) => {

                'title': e.myProduct!.name,
                'price': e.myProduct!.price,
                'quantity': e.quantity,
                'id': e.myProduct!.id,
                'imageUrl': e.myProduct!.imageUrl
              })
          .toList(),
    });
  }

  fetchOrders() async {
    List<Order> orders = [];
    List<Cart> carts = [];
    QuerySnapshot snapshot =
        await refOrders.doc(userId).collection('orders').get();
    snapshot.docs.forEach((element) {
      (element['listOfProducts']).forEach((e) {
        Item item =
            Item(imageUrl: e['imageUrl'], name: e['title'], id: e['id'],price: e['price']);
        Cart cart = Cart(
          myProduct: item,
          quantity: e['quantity'],
        );
        carts.add(cart);
      });
      Order order = Order(
          total: double.parse(element['amount']),
          dateTime: DateTime.parse(element['dateTime']),
          listOfProducts: carts);
      orders.add(order);
    });
    return orders;
  }

 fetchItem() async {
    QuerySnapshot snapshot = await refItems.get();
    List<Item> myList = [];
    for (var element in snapshot.docs) {
      String productId = element.id;
   //   print(element['desc']);
      bool state = await DatabaseMethods().checkState(userId, productId);
     // print(state);
      Item myProduct = Item(
          description: element['desc'],
          imageUrl: element['imageUrl'],
          price: element['price'].toDouble(),
          isFavorite: state,
          id: element['id'],
          category:element['category'] ,
          name: element['name']);
      myList.add(myProduct);

    }
    return myList;
  }


}
