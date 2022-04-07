import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../models/items.dart';
import '../screens/detailed_item_screen/detailed_item_screen.dart';

class ProductsGrid extends StatelessWidget {
  const ProductsGrid({
    Key? key,
    required this.items,
  }) : super(key: key);

  final List<Item> items;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: GridView.count(
          crossAxisCount: 2,
          children: List.generate(items.length, (index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DetailItemScreen(id: items[index].id!,)));
              },
              child: Card(
                color: Colors.grey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(height: 2.h),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.network(
                        items[index].imageUrl!,
                        fit: BoxFit.cover,
                        width: 32.w,
                        height: 10.h,
                      ),
                    ),
                    SizedBox(
                      height: 1.w,
                    ),
                    Text(
                      items[index].name!,
                      style: TextStyle(color: Colors.black, fontSize: 20.sp),
                    ),
                    Text(
                      '\$ ${items[index].price}',
                      style: TextStyle(
                          fontSize: 18.sp,
                          color: Theme.of(context).shadowColor),
                    )
                  ],
                ),
              ),
            );
          }, growable: true),
        ));
  }
}