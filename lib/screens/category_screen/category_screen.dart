import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:grocery/models/category.dart'as model;
import 'package:grocery/models/items.dart';
import 'package:grocery/providers/item_provider.dart';

import 'package:provider/provider.dart';

import '../../components/products_grid.dart';

import 'component/category_widget.dart';

class CategoryScreen extends StatelessWidget {
   CategoryScreen({required this.category,Key? key}) : super(key: key);
final String category;

  @override
  Widget build(BuildContext context) {
    List<Item> items =Provider.of<ItemsProvider>(context).findByCategory(category);
    print('categ: ${items.length}');
    final model.Category categoryD=model.CategoriesList().getCategory(category);
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(),
      body: Container(
        padding: const EdgeInsets.all(5),
        child: Column(
          children: [
            CategoryWidget(categoryD: categoryD),
            ProductsGrid(items: items)
          ],
        ),
      ),
    );
  }
}




