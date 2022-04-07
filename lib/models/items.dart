
import 'package:flutter/material.dart';

class Item  {
  String? id;
  String? category;
  String? name;
  String? description;
  double? price;
  String? imageUrl;
  bool? isFavorite;

  Item(
      {this.id,
      this.category,
      this.name,
      this.description,
      this.price,
      this.imageUrl,
      this.isFavorite});


}

// class Grocery with ChangeNotifier {
//   List<Item> _Items = [];
//
//   List<Item> get Items {
//     return [..._Items];
//   }
//
//   Future<void> fetchGrocery() async {
//     FirebaseFirestore.instance.collection('groceries').snapshots().listen(
//       (snapshot) {
//         if (snapshot.docs.isNotEmpty) {
//           for (var doc in snapshot.docs) {
//             _Items.add(Item(
//                 id: doc['id'],
//                 category: doc['category'],
//                 name: doc['name'],
//                 description: doc['description'],
//                 price: doc['price'],
//                 imageUrl: doc['imageUrl']));
//             print(_Items[0].imageUrl);
//           }
//         } else {
//           return;
//         }
//       },
//     );
//     notifyListeners();
//   }
//
//   Future<void> addItem(String category, String name, String description,
//       String price, File fileImage) async {
//     try {
//       final check = await FirebaseFirestore.instance
//           .collection('groceries')
//           .where('name', isEqualTo: name)
//           .get();
//       if (check.docs.isEmpty) {
//         final ref = FirebaseStorage.instance
//             .ref()
//             .child('items')
//             .child(name + '.png');
//         await ref.putFile(fileImage).snapshot;
//         final url = await ref.getDownloadURL();
//         await FirebaseFirestore.instance.collection('groceries').add({
//           'id': Timestamp.now().toString(),
//           'category': category,
//           'name': name,
//           'description': description,
//           'price': price,
//           'imageUrl': url,
//         });
//       }
//     } catch (e) {
//       print(e);
//     }
//     notifyListeners();
//   }
// }
